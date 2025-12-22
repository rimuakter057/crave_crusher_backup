import 'package:crave_crusher/utils/app_colors/app_colors.dart';
import 'package:crave_crusher/view/components/custom_button/custom_button.dart';
import 'package:crave_crusher/view/components/custom_text/custom_text.dart';
import 'package:crave_crusher/view/components/show_snack_bar/show_snack_bar.dart';
import 'package:crave_crusher/view/features/auth/controllers/user_resend_otp_controller.dart';
import 'package:crave_crusher/view/features/auth/controllers/verify_account_otp_controller.dart';
import 'package:crave_crusher/view/features/auth/models/verify_account_otp_model.dart';
import 'package:crave_crusher/view/features/auth/screen/login/login_screen.dart';
import 'package:crave_crusher/view/features/auth/screen/widgets/otp_field_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';

class VerifyAccountScreen extends StatefulWidget {
  const VerifyAccountScreen({super.key, required this.email});
  final String email;

  @override
  State<VerifyAccountScreen> createState() => _VerifyAccountScreenState();
}

class _VerifyAccountScreenState extends State<VerifyAccountScreen> {
  final TextEditingController _controller = TextEditingController();

  final VerifyAccountOtpController verifyOtpController =
      Get.find<VerifyAccountOtpController>();
  final UserResendOtpController resendOtpController =
      Get.find<UserResendOtpController>();

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      resendOtpController.startCountdown(seconds: 60);
    });
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

                ///reset  text
                CustomText(
                  textAlign: TextAlign.start,
                  text: "Verify Your Account",
                  fontSize: 28.sp,
                  fontWeight: FontWeight.w500,
                ),
                CustomText(
                  maxLines: 2,
                  textAlign: TextAlign.start,
                  text:
                      "Verify it’s you — check your email for the 6-digit code:${widget.email}",
                  fontSize: 14.sp,
                  fontWeight: FontWeight.w400,
                  color: Color(0xFF555555),
                ),
                Gap(16.h),

                ///otp field
                OtpFieldWidget(
                  controller: _controller,
                  onCompleted: (value) {
                    debugPrint("OTP Completed: $value");
                  },
                ),

                Gap(16.h),

                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Flexible(
                      child: CustomText(
                        text: "'Didn’t receive the code?'",
                        fontSize: 14,
                        fontWeight: FontWeight.w400,
                        color: Color(0xFF555555),
                      ),
                    ),

                    GetBuilder<UserResendOtpController>(
                      builder: (controller) {
                        return GestureDetector(
                          onTap:
                              (controller.countdown == 0 &&
                                      !controller.inProgress)
                                  ? _resendOtpButton
                                  : null,
                          child: Padding(
                            padding: const EdgeInsets.only(left: 4.0),
                            child: CustomText(
                              text:
                                  controller.countdown > 0
                                      ? 'Resend OTP (${controller.countdownText})'
                                      : 'Resend OTP',
                              fontSize: 14,
                              fontWeight: FontWeight.w500,
                              color:
                                  (controller.countdown > 0 ||
                                          controller.inProgress)
                                      ? AppColors.primary
                                      : AppColors.primary,
                            ),
                          ),
                        );
                      },
                    ),
                  ],
                ),

                ///reset button
                Gap(16.h),

                GetBuilder<VerifyAccountOtpController>(
                  builder: (controller) {
                    return Visibility(
                      visible: controller.inProgress == false,
                      replacement: Center(child: CircularProgressIndicator()),
                      child: CustomButton(
                        title: "Verify OTP",
                        onTap: _verifyOtpButton,
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

  ///verify_otp button
  Future<void> _verifyOtpButton() async {
    if (_controller.text.isEmpty || _controller.text.length != 6) {
      showSnackBarMessage(context, "Please enter a 6-digit OTP", true);
      return;
    }

    VerifyAccountOtpModel verifyOtpModel = VerifyAccountOtpModel(
      email: widget.email,
      verifyCode: _controller.text,
    );

    final bool isSuccess = await Get.find<VerifyAccountOtpController>()
        .verifyOtp(verifyOtpModel);

    if (isSuccess) {
      _controller.clear();

      resendOtpController.startCountdown(seconds: 60);
      Get.to(() => LoginScreen());
    } else {
      showSnackBarMessage(
        context,
        verifyOtpController.errorMessage ?? "Something went wrong",
        true,
      );
    }
  }

  ///resend otp
  Future<void> _resendOtpButton() async {
    if (widget.email.isEmpty) {
      Get.snackbar("Error", "Email not found!");
      return;
    }

    final bool isSuccess = await resendOtpController.resendOtp(widget.email);

    if (isSuccess) {
      Get.snackbar("Success", "A new OTP has been sent to your email.");
    } else {
      Get.snackbar(
        "Error",
        resendOtpController.errorMessage ?? "Something went wrong.",
      );
    }
  }
}
