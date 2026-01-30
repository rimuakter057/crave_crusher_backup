import 'package:crave_crusher/view/components/custom_button/custom_button.dart';
import 'package:crave_crusher/view/components/custom_loader/custom_loader.dart';
import 'package:crave_crusher/view/components/custom_text/custom_text.dart';
import 'package:crave_crusher/view/components/input_password_field_widget/input_password_field_widget.dart';
import 'package:crave_crusher/view/features/auth/controllers/reset_password_controller.dart';
import 'package:crave_crusher/view/features/auth/models/reset_password_model.dart';
import 'package:crave_crusher/view/features/auth/screen/login/login_screen.dart';
import 'package:crave_crusher/view/features/auth/screen/widgets/action_promote_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ResetPasswordScreen extends StatelessWidget {
  ResetPasswordScreen({super.key, required this.email});

  final String email;
  final TextEditingController _newPassController = TextEditingController();
  final TextEditingController _confirmedPassword = TextEditingController();
  final GlobalKey<FormState> _key = GlobalKey<FormState>();
  final ResetPasswordController resetPasswordController =
      Get.find<ResetPasswordController>();

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

    final double verticalSpacing1 = isTablet ? 32.0 : 24.0;
    final double verticalSpacing2 = isTablet ? 24.0 : 16.0;

    return Scaffold(
      body: SafeArea(
        child: Form(
          key: _key,
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

                        ///reset text
                        CustomText(
                          textAlign: TextAlign.start,
                          text: "Reset Your Password",
                          fontSize: titleSize,
                          fontWeight: FontWeight.w500,
                        ),

                        SizedBox(height: isTablet ? 12 : 8),

                        CustomText(
                          maxLines: 3,
                          textAlign: TextAlign.start,
                          text:
                              "Create a new password for your Crave Crusher account.",
                          fontSize: subtitleSize,
                          fontWeight: FontWeight.w400,
                          color: const Color(0xFF555555),
                        ),

                        SizedBox(height: verticalSpacing1),

                        InputPasswordFieldWidget(
                          title: "New Password",
                          controller: _newPassController,
                          isTablet: isTablet,
                          validator: (String? value) {
                            if ((value?.isEmpty ?? true) ||
                                _newPassController.text.length < 6) {
                              return "Enter Your password minimum length 6";
                            }
                            return null;
                          },
                        ),

                        SizedBox(height: verticalSpacing2),

                        InputPasswordFieldWidget(
                          title: "Confirmed Password",
                          controller: _confirmedPassword,
                          isTablet: isTablet,
                          validator: (String? value) {
                            if (value == null || value.isEmpty) {
                              return "Enter Confirmed Password";
                            }

                            if (_newPassController.text !=
                                _confirmedPassword.text) {
                              return "Passwords do not match";
                            }

                            return null;
                          },
                        ),

                        SizedBox(height: verticalSpacing2),

                        ActionPromptWidget(
                          prefixText: 'Remembered it now?',
                          actionText: 'Log In',
                          onActionTapped: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => const LoginScreen(),
                              ),
                            );
                          },
                        ),

                        ///reset button
                        SizedBox(height: verticalSpacing2),

                        GetBuilder<ResetPasswordController>(
                          builder: (controller) {
                            return Visibility(
                              visible: controller.inProgress == false,
                              replacement: const CustomLoader(),
                              child: CustomButton(
                                title: "Reset Password",
                                onTap: _resetButton,
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
      ),
    );
  }

  Future<void> _resetButton() async {
    if (_key.currentState!.validate()) {
      ResetPasswordModel resetPassModel = ResetPasswordModel(
        email: email,
        password: _newPassController.text,
        confirmPassword: _confirmedPassword.text,
      );

      final bool isSuccess = await resetPasswordController.resetPassword(
        resetPassModel,
      );

      if (isSuccess) {
        Get.off(() => const LoginScreen());
      } else {
        Get.snackbar(
          "Error",
          resetPasswordController.errorMessage ?? "Something went wrong",
        );
      }
    }
  }
}

// import 'package:crave_crusher/view/components/custom_button/custom_button.dart';
// import 'package:crave_crusher/view/components/custom_loader/custom_loader.dart';
// import 'package:crave_crusher/view/components/custom_text/custom_text.dart';
// import 'package:crave_crusher/view/components/input_password_field_widget/input_password_field_widget.dart';
// import 'package:crave_crusher/view/features/auth/controllers/reset_password_controller.dart';
// import 'package:crave_crusher/view/features/auth/models/reset_password_model.dart';
// import 'package:crave_crusher/view/features/auth/screen/login/login_screen.dart';
// import 'package:crave_crusher/view/features/auth/screen/widgets/action_promote_widget.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:gap/gap.dart';
// import 'package:get/get.dart';

// class ResetPasswordScreen extends StatelessWidget {
//   ResetPasswordScreen({super.key, required this.email});
//   final String email;
//   final TextEditingController _newPassController = TextEditingController();
//   final TextEditingController _confirmedPassword = TextEditingController();
//   final GlobalKey<FormState> _key = GlobalKey<FormState>();
//   final ResetPasswordController resetPasswordController =
//       Get.find<ResetPasswordController>();
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Form(
//         key: _key,
//         child: Center(
//           child: SingleChildScrollView(
//             child: Padding(
//               padding: EdgeInsets.symmetric(horizontal: 16.w),
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   Gap(8.h),

//                   ///reset  text
//                   CustomText(
//                     textAlign: TextAlign.start,
//                     text: "Reset Your Password",
//                     fontSize: 28.sp,
//                     fontWeight: FontWeight.w500,
//                   ),
//                   CustomText(
//                     maxLines: 2,
//                     textAlign: TextAlign.start,
//                     text:
//                         "Create a new password for your Crave Crusher account.",
//                     fontSize: 14.sp,
//                     fontWeight: FontWeight.w400,
//                     color: Color(0xFF555555),
//                   ),
//                   Gap(24.h),

//                   InputPasswordFieldWidget(
//                     title: "New Password",
//                     controller: _newPassController,
//                     validator: (String? value) {
//                       if (value?.isEmpty ??
//                           true && _newPassController.text.length < 6) {
//                         return "Enter Your password minimum length 6";
//                       }
//                       return null;
//                     },
//                   ),
//                   Gap(16.h),
//                   InputPasswordFieldWidget(
//                     title: "Confirmed Password",
//                     controller: _confirmedPassword,
//                     validator: (String? value) {
//                       if (value == null || value.isEmpty) {
//                         return "Enter Confirmed Password";
//                       }

//                       if (_newPassController.text != _confirmedPassword.text) {
//                         return "Passwords do not match";
//                       }

//                       return null;
//                     },
//                   ),
//                   Gap(16.h),
//                   ActionPromptWidget(
//                     prefixText: 'Remembered it now?',
//                     actionText: 'Log In',
//                     onActionTapped: () {
//                       Navigator.push(
//                         context,
//                         MaterialPageRoute(builder: (context) => LoginScreen()),
//                       );
//                     },
//                   ),

//                   ///reset button
//                   Gap(16.h),
//                   GetBuilder<ResetPasswordController>(
//                     builder: (controller) {
//                       return Visibility(
//                         visible: controller.inProgress == false,
//                         replacement: CustomLoader(),
//                         child: CustomButton(
//                           title: "Reset Password",
//                           onTap: _resetButton,
//                         ),
//                       );
//                     },
//                   ),
//                 ],
//               ),
//             ),
//           ),
//         ),
//       ),
//     );
//   }

//   Future<void> _resetButton() async {
//     if (_key.currentState!.validate()) {
//       ResetPasswordModel resetPassModel = ResetPasswordModel(
//         email: email,
//         password: _newPassController.text,
//         confirmPassword: _confirmedPassword.text,
//       );

//       final bool isSuccess = await resetPasswordController.resetPassword(
//         resetPassModel,
//       );
//       if (isSuccess) {
//         Get.off(LoginScreen());
//       } else {
//         Get.snackbar("Error", resetPasswordController.errorMessage!);
//       }
//     }
//   }
// }
