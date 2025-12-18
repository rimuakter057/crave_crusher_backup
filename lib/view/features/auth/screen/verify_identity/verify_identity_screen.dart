import 'package:crave_crusher/view/features/auth/controllers/reset_resend_otp_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:crave_crusher/view/components/custom_button/custom_button.dart';
import 'package:crave_crusher/view/components/custom_text/custom_text.dart';
import 'package:crave_crusher/view/components/show_snakbar/show_snakbar.dart';
import 'package:crave_crusher/view/features/auth/controllers/verify_identity_otp_controller.dart';
import 'package:crave_crusher/view/features/auth/models/verify_indentity_otp_model.dart';
import 'package:crave_crusher/view/features/auth/screen/reset_password/reset_password_screen.dart';
import 'package:crave_crusher/view/features/auth/screen/widgets/otp_field_widget.dart';
import 'package:crave_crusher/utils/app_colors/app_colors.dart';

class VerifyIdentityScreen extends StatefulWidget {
  final String email;
  const VerifyIdentityScreen({Key? key, required this.email}) : super(key: key);

  @override
  State<VerifyIdentityScreen> createState() => _VerifyIdentityScreenState();
}

class _VerifyIdentityScreenState extends State<VerifyIdentityScreen> {
  final TextEditingController _controller = TextEditingController();
  final VerifyIdentityOtpController verifyOtpController = Get.find<VerifyIdentityOtpController>();
  final ResendOtpController resendOtpController = Get.put(ResendOtpController());

  @override
  void initState() {
    super.initState();

    resendOtpController.startCountdown(seconds: 60);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.w),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Gap(8.h),
                CustomText(
                  textAlign: TextAlign.start,
                  text: "Verify Your Identity",
                  fontSize: 28.sp,
                  fontWeight: FontWeight.w500,
                ),
                CustomText(
                  maxLines: 2,
                  textAlign: TextAlign.start,
                  text:
                  "We’ve sent a 6-digit verification code to ${widget.email}",
                  fontSize: 14.sp,
                  fontWeight: FontWeight.w400,
                  color: Color(0xFF555555),
                ),
                Gap(24.h),
                OtpFieldWidget(
                  controller: _controller,
                  onCompleted: (value) {},
                ),
                Gap(16.h),

                /// Resend OTP Button

                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Flexible(
                      child: CustomText(text: "'Didn’t receive the code?",
                        fontSize: 14,
                        fontWeight: FontWeight.w400,
                        color: Color(0xFF555555),
                      ),

                    ),
                    ///resend button
                    GetBuilder<ResendOtpController>(
                      builder: (controller) {
                        return GestureDetector(
                          onTap: (controller.countdown == 0 && !controller.inProgress)
                              ? _resendOtpButton
                              : null,
                          child: Padding(
                            padding: const EdgeInsets.only(left: 4.0),
                            child: CustomText(
                              text: controller.countdown > 0
                                  ? 'Resend OTP (${controller.countdownText})'
                                  : 'Resend OTP',
                              fontSize: 14,
                              fontWeight: FontWeight.w500,
                              color: (controller.countdown > 0 || controller.inProgress)
                                  ? AppColors.primary
                                  : AppColors.primary,
                            ),
                          ),
                        );
                      },
                    ),
                  ],
                ),





                Gap(16.h),

                /// Verify OTP Button
                GetBuilder<VerifyIdentityOtpController>(
                  builder: (controller) {
                    return Visibility(
                      visible: controller.inProgress == false,
                      replacement: Center(child: CircularProgressIndicator()),
                      child: CustomButton(
                        title: "Verify OTP",
                        onTap: _verifyOtp,
                      ),
                    );
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  /// OTP Verification
  Future<void> _verifyOtp() async {
    if (_controller.text.isEmpty || _controller.text.length != 6) {
      showSnackBarMessage(context, "Please enter a 6-digit OTP", true);
      return;
    }

    VerifyIdentityOtpModel verifyModel = VerifyIdentityOtpModel(
      email: widget.email,
      resetCode: _controller.text,
    );

    final bool isSuccess =
    await verifyOtpController.verifyIdentityOtp(verifyModel);

    if (isSuccess) {
      _controller.clear(); // clear OTP field
      // Start countdown after Verify OTP
      resendOtpController.startCountdown(seconds: 60);
      Get.to(() => ResetPasswordScreen(email: widget.email));
    } else {
      showSnackBarMessage(
        context,
        verifyOtpController.errorMessage ?? "Something went wrong",
        true,
      );
    }
  }

  /// Resend OTP
  Future<void> _resendOtpButton() async {
    if (widget.email.isEmpty) {
      Get.snackbar("Error", "Email not found!");
      return;
    }

    final bool isSuccess = await resendOtpController.resendOtp(widget.email); //  static const String resendResetOtp="$baseUrl/auth/resend-reset-code";

    if (isSuccess) {
      _controller.clear();
      Get.snackbar("Success", "A new OTP has been sent to your email.");
    } else {
      Get.snackbar(
        "Error",
        resendOtpController.errorMessage ?? "Something went wrong.",
      );
    }
  }
}
