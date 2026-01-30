// ignore_for_file: use_build_context_synchronously

import 'package:crave_crusher/view/components/custom_loader/custom_loader.dart';
import 'package:crave_crusher/view/features/auth/controllers/reset_resend_otp_controller.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:crave_crusher/view/components/custom_button/custom_button.dart';
import 'package:crave_crusher/view/components/custom_text/custom_text.dart';
import 'package:crave_crusher/view/components/show_snack_bar/show_snack_bar.dart';
import 'package:crave_crusher/view/features/auth/controllers/verify_identity_otp_controller.dart';
import 'package:crave_crusher/view/features/auth/models/verify_identity_otp_model.dart';
import 'package:crave_crusher/view/features/auth/screen/reset_password/reset_password_screen.dart';
import 'package:crave_crusher/view/features/auth/screen/widgets/otp_field_widget.dart';
import 'package:crave_crusher/utils/app_colors/app_colors.dart';

class VerifyIdentityScreen extends StatefulWidget {
  final String email;
  const VerifyIdentityScreen({super.key, required this.email});

  @override
  State<VerifyIdentityScreen> createState() => _VerifyIdentityScreenState();
}

class _VerifyIdentityScreenState extends State<VerifyIdentityScreen> {
  final TextEditingController _controller = TextEditingController();
  final VerifyIdentityOtpController verifyOtpController =
      Get.find<VerifyIdentityOtpController>();
  final ResendOtpController resendOtpController = Get.put(
    ResendOtpController(),
  );

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
    // Get screen dimensions
    final screenWidth = MediaQuery.of(context).size.width;
    final isTablet = screenWidth > 600;

    // Calculate responsive values
    final double horizontalPadding = isTablet ? 60.0 : 16.0;
    final double maxContentWidth =
        isTablet ? (screenWidth > 800 ? 600.0 : 500.0) : double.infinity;

    final double titleSize =
        isTablet ? (screenWidth > 800 ? 36.0 : 32.0) : 28.0;

    final double subtitleSize =
        isTablet ? (screenWidth > 800 ? 18.0 : 16.0) : 14.0;

    final double textSize = isTablet ? 16.0 : 14.0;

    final double verticalSpacing = isTablet ? 24.0 : 16.0;

    return Scaffold(
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            child: Padding(
              padding: EdgeInsets.symmetric(
                horizontal: horizontalPadding,
                vertical: 20,
              ),
              child: Center(
                child: ConstrainedBox(
                  constraints: BoxConstraints(maxWidth: maxContentWidth),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      if (isTablet) const SizedBox(height: 20),

                      CustomText(
                        textAlign: TextAlign.start,
                        text: "Verify Your Identity",
                        fontSize: titleSize,
                        fontWeight: FontWeight.w500,
                      ),

                      SizedBox(height: isTablet ? 12 : 8),

                      CustomText(
                        maxLines: 3,
                        textAlign: TextAlign.start,
                        text:
                            "We've sent a 6-digit verification code to ${widget.email}",
                        fontSize: subtitleSize,
                        fontWeight: FontWeight.w400,
                        color: const Color(0xFF555555),
                      ),

                      SizedBox(height: verticalSpacing * 1.5),

                      OtpFieldWidget(
                        controller: _controller,
                        isTablet: isTablet,
                        onCompleted: (value) {},
                      ),

                      SizedBox(height: verticalSpacing),

                      /// Resend OTP Button
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Flexible(
                            child: CustomText(
                              textAlign: TextAlign.start,
                              text: "Didn't receive the code?",
                              fontSize: textSize,
                              fontWeight: FontWeight.w400,
                              color: const Color(0xFF555555),
                            ),
                          ),
                          const SizedBox(width: 4),

                          ///resend button
                          GetBuilder<ResendOtpController>(
                            builder: (controller) {
                              return GestureDetector(
                                onTap:
                                    (controller.countdown == 0 &&
                                            !controller.inProgress)
                                        ? _resendOtpButton
                                        : null,
                                child: CustomText(
                                  text:
                                      controller.countdown > 0
                                          ? 'Resend OTP (${controller.countdownText})'
                                          : 'Resend OTP',
                                  fontSize: textSize,
                                  fontWeight: FontWeight.w500,
                                  color:
                                      (controller.countdown > 0 ||
                                              controller.inProgress)
                                          ? AppColors.primary.withOpacity(0.6)
                                          : AppColors.primary,
                                ),
                              );
                            },
                          ),
                        ],
                      ),

                      SizedBox(height: verticalSpacing),

                      /// Verify OTP Button
                      GetBuilder<VerifyIdentityOtpController>(
                        builder: (controller) {
                          return Visibility(
                            visible: controller.inProgress == false,
                            replacement: const CustomLoader(),
                            child: CustomButton(
                              title: "Verify OTP",
                              onTap: _verifyOtp,
                              height: isTablet ? 65 : 55,
                              fontSize: isTablet ? 16.0 : 14.0,
                            ),
                          );
                        },
                      ),

                      if (isTablet) const SizedBox(height: 40),
                    ],
                  ),
                ),
              ),
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

    final bool isSuccess = await verifyOtpController.verifyIdentityOtp(
      verifyModel,
    );

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

    final bool isSuccess = await resendOtpController.resendOtp(widget.email);

    if (isSuccess) {
      _controller.clear();
      resendOtpController.startCountdown(seconds: 60);
      Get.snackbar("Success", "A new OTP has been sent to your email.");
    } else {
      Get.snackbar(
        "Error",
        resendOtpController.errorMessage ?? "Something went wrong.",
      );
    }
  }
}

// // ignore_for_file: use_build_context_synchronously

// import 'package:crave_crusher/view/components/custom_loader/custom_loader.dart';
// import 'package:crave_crusher/view/features/auth/controllers/reset_resend_otp_controller.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:gap/gap.dart';
// import 'package:get/get.dart';
// import 'package:crave_crusher/view/components/custom_button/custom_button.dart';
// import 'package:crave_crusher/view/components/custom_text/custom_text.dart';
// import 'package:crave_crusher/view/components/show_snack_bar/show_snack_bar.dart';
// import 'package:crave_crusher/view/features/auth/controllers/verify_identity_otp_controller.dart';
// import 'package:crave_crusher/view/features/auth/models/verify_identity_otp_model.dart';
// import 'package:crave_crusher/view/features/auth/screen/reset_password/reset_password_screen.dart';
// import 'package:crave_crusher/view/features/auth/screen/widgets/otp_field_widget.dart';
// import 'package:crave_crusher/utils/app_colors/app_colors.dart';

// class VerifyIdentityScreen extends StatefulWidget {
//   final String email;
//   const VerifyIdentityScreen({super.key, required this.email});

//   @override
//   State<VerifyIdentityScreen> createState() => _VerifyIdentityScreenState();
// }

// class _VerifyIdentityScreenState extends State<VerifyIdentityScreen> {
//   final TextEditingController _controller = TextEditingController();
//   final VerifyIdentityOtpController verifyOtpController =
//       Get.find<VerifyIdentityOtpController>();
//   final ResendOtpController resendOtpController = Get.put(
//     ResendOtpController(),
//   );

//   @override
//   void initState() {
//     super.initState();

//     resendOtpController.startCountdown(seconds: 60);
//   }

//   @override
//   void dispose() {
//     _controller.dispose();
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Center(
//         child: SingleChildScrollView(
//           child: Padding(
//             padding: EdgeInsets.symmetric(horizontal: 16.w),
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 Gap(8.h),
//                 CustomText(
//                   textAlign: TextAlign.start,
//                   text: "Verify Your Identity",
//                   fontSize: 28.sp,
//                   fontWeight: FontWeight.w500,
//                 ),
//                 CustomText(
//                   maxLines: 2,
//                   textAlign: TextAlign.start,
//                   text:
//                       "We’ve sent a 6-digit verification code to ${widget.email}",
//                   fontSize: 14.sp,
//                   fontWeight: FontWeight.w400,
//                   color: Color(0xFF555555),
//                 ),
//                 Gap(24.h),
//                 OtpFieldWidget(
//                   controller: _controller,
//                   onCompleted: (value) {},
//                 ),
//                 Gap(16.h),

//                 /// Resend OTP Button
//                 Row(
//                   mainAxisAlignment: MainAxisAlignment.start,
//                   children: [
//                     Flexible(
//                       child: CustomText(
//                         text: "'Didn’t receive the code?",
//                         fontSize: 14,
//                         fontWeight: FontWeight.w400,
//                         color: Color(0xFF555555),
//                       ),
//                     ),

//                     ///resend button
//                     GetBuilder<ResendOtpController>(
//                       builder: (controller) {
//                         return GestureDetector(
//                           onTap:
//                               (controller.countdown == 0 &&
//                                       !controller.inProgress)
//                                   ? _resendOtpButton
//                                   : null,
//                           child: Padding(
//                             padding: const EdgeInsets.only(left: 4.0),
//                             child: CustomText(
//                               text:
//                                   controller.countdown > 0
//                                       ? 'Resend OTP (${controller.countdownText})'
//                                       : 'Resend OTP',
//                               fontSize: 14,
//                               fontWeight: FontWeight.w500,
//                               color:
//                                   (controller.countdown > 0 ||
//                                           controller.inProgress)
//                                       ? AppColors.primary
//                                       : AppColors.primary,
//                             ),
//                           ),
//                         );
//                       },
//                     ),
//                   ],
//                 ),

//                 Gap(16.h),

//                 /// Verify OTP Button
//                 GetBuilder<VerifyIdentityOtpController>(
//                   builder: (controller) {
//                     return Visibility(
//                       visible: controller.inProgress == false,
//                       replacement: CustomLoader(),
//                       child: CustomButton(
//                         title: "Verify OTP",
//                         onTap: _verifyOtp,
//                       ),
//                     );
//                   },
//                 ),
//               ],
//             ),
//           ),
//         ),
//       ),
//     );
//   }

//   /// OTP Verification
//   Future<void> _verifyOtp() async {
//     if (_controller.text.isEmpty || _controller.text.length != 6) {
//       showSnackBarMessage(context, "Please enter a 6-digit OTP", true);
//       return;
//     }

//     VerifyIdentityOtpModel verifyModel = VerifyIdentityOtpModel(
//       email: widget.email,
//       resetCode: _controller.text,
//     );

//     final bool isSuccess = await verifyOtpController.verifyIdentityOtp(
//       verifyModel,
//     );

//     if (isSuccess) {
//       _controller.clear(); // clear OTP field
//       // Start countdown after Verify OTP
//       resendOtpController.startCountdown(seconds: 60);
//       Get.to(() => ResetPasswordScreen(email: widget.email));
//     } else {
//       showSnackBarMessage(
//         context,
//         verifyOtpController.errorMessage ?? "Something went wrong",
//         true,
//       );
//     }
//   }

//   /// Resend OTP
//   Future<void> _resendOtpButton() async {
//     if (widget.email.isEmpty) {
//       Get.snackbar("Error", "Email not found!");
//       return;
//     }

//     final bool isSuccess = await resendOtpController.resendOtp(
//       widget.email,
//     ); //  static const String resendResetOtp="$baseUrl/auth/resend-reset-code";

//     if (isSuccess) {
//       _controller.clear();
//       Get.snackbar("Success", "A new OTP has been sent to your email.");
//     } else {
//       Get.snackbar(
//         "Error",
//         resendOtpController.errorMessage ?? "Something went wrong.",
//       );
//     }
//   }
// }
