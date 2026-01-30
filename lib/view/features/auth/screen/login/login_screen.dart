// ignore_for_file: use_build_context_synchronously

import 'package:crave_crusher/core/routes/app_routes.dart';
import 'package:crave_crusher/utils/app_colors/app_colors.dart';
import 'package:crave_crusher/view/components/custom_button/custom_button.dart';
import 'package:crave_crusher/view/components/custom_loader/custom_loader.dart';
import 'package:crave_crusher/view/components/custom_text/custom_text.dart';
import 'package:crave_crusher/view/components/input_field_with_title/input_field_with_title.dart';
import 'package:crave_crusher/view/components/show_snack_bar/show_snack_bar.dart';
import 'package:crave_crusher/view/features/auth/controllers/auth_controller.dart';
import 'package:crave_crusher/view/features/auth/controllers/forget_password_controller.dart';
import 'package:crave_crusher/view/features/auth/controllers/login_controller.dart';
import 'package:crave_crusher/view/features/auth/models/login_model.dart';
import 'package:crave_crusher/view/features/auth/screen/sign_up/sign_up_screen.dart';
import 'package:crave_crusher/view/features/auth/screen/verify_account/verify_account_screen.dart';
import 'package:crave_crusher/view/features/auth/screen/verify_identity/verify_identity_screen.dart';
import 'package:crave_crusher/view/features/auth/screen/widgets/action_promote_widget.dart';
import 'package:crave_crusher/view/features/auth/screen/widgets/or_divider_widget.dart';
import 'package:crave_crusher/view/features/auth/screen/widgets/remember_me_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  bool _rememberMe = false;

  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  final GlobalKey<FormState> _key = GlobalKey<FormState>();
  final LogInController logInController = Get.find<LogInController>();
  final AuthController authController = Get.find<AuthController>();
  final ForgetPasswordController forgetPasswordController =
      Get.find<ForgetPasswordController>();

  @override
  void initState() {
    super.initState();
    loadRememberData();
  }

  Future<void> loadRememberData() async {
    final data = await authController.getRememberMeData();

    if (data["rememberMe"] == true) {
      _emailController.text = data["email"];
      _passwordController.text = data["password"];
      _rememberMe = true;
      setState(() {});
    }
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
        isTablet ? (screenWidth > 800 ? 42.0 : 36.0) : 30.0;

    final double subtitleSize =
        isTablet ? (screenWidth > 800 ? 18.0 : 16.0) : 14.0;

    final double verticalSpacing1 = isTablet ? 40.0 : 24.0;
    final double verticalSpacing2 = isTablet ? 32.0 : 24.0;
    final double verticalSpacing3 = isTablet ? 20.0 : 16.0;

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
                  child: Form(
                    key: _key,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        if (isTablet) const SizedBox(height: 20),

                        ///login text
                        CustomText(
                          textAlign: TextAlign.start,
                          text: "Welcome Back",
                          fontSize: titleSize,
                          fontWeight: FontWeight.w500,
                        ),

                        SizedBox(height: isTablet ? 12 : 8),

                        CustomText(
                          maxLines: 3,
                          textAlign: TextAlign.start,
                          text:
                              "Let's continue your journey to crush those cravings!",
                          fontSize: subtitleSize,
                          fontWeight: FontWeight.w400,
                          color: const Color(0xFF555555),
                        ),

                        SizedBox(height: verticalSpacing1),

                        ///input field
                        InputFieldWithTitleWidget(
                          title: "Email Address",
                          hintText: "Enter your email",
                          controller: _emailController,
                          isTablet: isTablet,
                          validator: (String? value) {
                            if (value == null || value.trim().isEmpty) {
                              return "Enter Your Email";
                            }
                            final emailRegex = RegExp(
                              r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$',
                            );
                            if (!emailRegex.hasMatch(value.trim())) {
                              return "Enter a valid email address";
                            }
                            return null;
                          },
                        ),

                        SizedBox(height: verticalSpacing3),

                        InputPasswordFieldWidget(
                          title: "Password",
                          controller: _passwordController,
                          isTablet: isTablet,
                          validator: (String? value) {
                            if ((value?.isEmpty ?? true) ||
                                _passwordController.text.length < 6) {
                              return "Enter Your password minimum length 6";
                            }
                            return null;
                          },
                        ),

                        ///remember and forgot section
                        RememberMeAndForgotPassword(
                          isChecked: _rememberMe,
                          onRememberMeChanged: (bool? newValue) {
                            setState(() {
                              _rememberMe = newValue ?? false;
                            });
                          },
                          child: GetBuilder<ForgetPasswordController>(
                            builder: (controller) {
                              return Visibility(
                                visible: controller.inProgress == false,
                                replacement: const CustomLoader(),
                                child: TextButton(
                                  onPressed: _forgetButtonTap,
                                  child: CustomText(
                                    text: "Forget Password?",
                                    fontWeight: FontWeight.w600,
                                    fontSize: isTablet ? 14.0 : 12.0,
                                    color: AppColors.primary,
                                  ),
                                ),
                              );
                            },
                          ),
                        ),

                        const OrDivider(),

                        SizedBox(height: verticalSpacing2),

                        ActionPromptWidget(
                          prefixText: "Don't have an account?",
                          actionText: 'Sign Up Now',
                          onActionTapped: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => const SignUpScreen(),
                              ),
                            );
                          },
                        ),

                        SizedBox(height: verticalSpacing2),

                        ///login button
                        GetBuilder<LogInController>(
                          builder: (controller) {
                            return Visibility(
                              visible: controller.inProgress == false,
                              replacement: const CustomLoader(),
                              child: CustomButton(
                                title: "Log In",
                                onTap: _signInButtonTap,
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

  ///sign in button
  Future<void> _signInButtonTap() async {
    if (_key.currentState!.validate()) {
      LogInModel logInModel = LogInModel(
        email: _emailController.text,
        password: _passwordController.text,
      );

      final bool isSuccess = await logInController.logIn(logInModel);

      if (isSuccess) {
        /// 🔹 Email not verified → OTP
        if (logInController.emailNotVerified) {
          Get.to(() => VerifyAccountScreen(email: _emailController.text));
        }
        /// 🔹 Login success → Home
        else {
          await authController.saveRememberMe(
            rememberMe: _rememberMe,
            email: _emailController.text,
            password: _passwordController.text,
          );

          Get.offAllNamed(AppRoutes.homeScreen);
        }
      } else {
        showSnackBarMessage(
          context,
          logInController.errorMessage ?? "Something went wrong",
          true,
        );
      }
    }
  }

  ///forget button
  Future<void> _forgetButtonTap() async {
    final bool isSuccess = await forgetPasswordController.forgetPassword(
      _emailController.text,
    );

    if (isSuccess && _emailController.text.isNotEmpty) {
      Get.to(() => VerifyIdentityScreen(email: _emailController.text));
    } else {
      Get.snackbar("Error", "Please Enter Your Email");
    }
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }
}

// // ignore_for_file: use_build_context_synchronously

// import 'package:crave_crusher/core/routes/app_routes.dart';
// import 'package:crave_crusher/utils/app_colors/app_colors.dart';
// import 'package:crave_crusher/view/components/custom_button/custom_button.dart';
// import 'package:crave_crusher/view/components/custom_loader/custom_loader.dart';
// import 'package:crave_crusher/view/components/custom_text/custom_text.dart';
// import 'package:crave_crusher/view/components/input_field_with_title/input_field_with_title.dart';
// import 'package:crave_crusher/view/components/input_password_field_widget/input_password_field_widget.dart';
// import 'package:crave_crusher/view/components/show_snack_bar/show_snack_bar.dart';
// import 'package:crave_crusher/view/features/auth/controllers/auth_controller.dart';
// import 'package:crave_crusher/view/features/auth/controllers/forget_password_controller.dart';
// import 'package:crave_crusher/view/features/auth/controllers/login_controller.dart';
// import 'package:crave_crusher/view/features/auth/models/login_model.dart';
// import 'package:crave_crusher/view/features/auth/screen/sign_up/sign_up_screen.dart';
// import 'package:crave_crusher/view/features/auth/screen/verify_account/verify_account_screen.dart';
// import 'package:crave_crusher/view/features/auth/screen/verify_identity/verify_identity_screen.dart';
// import 'package:crave_crusher/view/features/auth/screen/widgets/action_promote_widget.dart';
// import 'package:crave_crusher/view/features/auth/screen/widgets/or_divider_widget.dart';
// import 'package:crave_crusher/view/features/auth/screen/widgets/remember_me_widget.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:gap/gap.dart';
// import 'package:get/get.dart';

// class LoginScreen extends StatefulWidget {
//   const LoginScreen({super.key});

//   @override
//   State<LoginScreen> createState() => _LoginScreenState();
// }

// class _LoginScreenState extends State<LoginScreen> {
//   bool _rememberMe = false;

//   final TextEditingController _emailController = TextEditingController();
//   final TextEditingController _passwordController = TextEditingController();

//   final GlobalKey<FormState> _key = GlobalKey<FormState>();
//   final LogInController logInController = Get.find<LogInController>();
//   final AuthController authController = Get.find<AuthController>();
//   final ForgetPasswordController forgetPasswordController =
//       Get.find<ForgetPasswordController>();

//   @override
//   void initState() {
//     super.initState();
//     loadRememberData();
//   }

//   Future<void> loadRememberData() async {
//     final data = await authController.getRememberMeData();

//     if (data["rememberMe"] == true) {
//       _emailController.text = data["email"];
//       _passwordController.text = data["password"];
//       _rememberMe = true;
//       setState(() {});
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: SafeArea(
//         child: Center(
//           child: SingleChildScrollView(
//             child: Padding(
//               padding: EdgeInsets.symmetric(horizontal: 16.w),
//               child: Form(
//                 key: _key,
//                 child: Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   mainAxisAlignment: MainAxisAlignment.center,
//                   children: [
//                     ///login text
//                     CustomText(
//                       textAlign: TextAlign.start,
//                       text: "Welcome Back",
//                       fontSize: 30.sp,
//                       fontWeight: FontWeight.w500,
//                     ),
//                     CustomText(
//                       maxLines: 2,
//                       textAlign: TextAlign.start,
//                       text:
//                           "Let’s continue your journey to crush those cravings!",
//                       fontSize: 14.sp,
//                       fontWeight: FontWeight.w400,
//                       color: Color(0xFF555555),
//                     ),
//                     Gap(24.h),

//                     ///input field
//                     InputFieldWithTitleWidget(
//                       title: "Email Address",
//                       hintText: "Enter your email",
//                       controller: _emailController,
//                       validator: (String? value) {
//                         if (value == null || value.trim().isEmpty) {
//                           return "Enter Your Email";
//                         }
//                         // Simple email regex
//                         final emailRegex = RegExp(
//                           r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$',
//                         );
//                         if (!emailRegex.hasMatch(value.trim())) {
//                           return "Enter a valid email address";
//                         }
//                         return null;
//                       },
//                     ),

//                     Gap(16.h),
//                     InputPasswordFieldWidget(
//                       title: "Password",
//                       controller: _passwordController,
//                       validator: (String? value) {
//                         if (value?.isEmpty ??
//                             true && _passwordController.text.length < 6) {
//                           return "Enter Your password minimum length 6";
//                         }
//                         return null;
//                       },
//                     ),

//                     ///remember and forgot section
//                     RememberMeAndForgotPassword(
//                       isChecked: _rememberMe,
//                       onRememberMeChanged: (bool? newValue) {
//                         setState(() {
//                           _rememberMe = newValue ?? false;
//                         });
//                       },

//                       child: GetBuilder<ForgetPasswordController>(
//                         builder: (controller) {
//                           return Visibility(
//                             visible: controller.inProgress == false,
//                             replacement: CustomLoader(),
//                             child: TextButton(
//                               onPressed: _forgetButtonTap,
//                               child: CustomText(
//                                 text: "Forget Password?",
//                                 fontWeight: FontWeight.w600,
//                                 fontSize: 12,
//                                 color: AppColors.primary,
//                               ),
//                             ),
//                           );
//                         },
//                       ),
//                     ),
//                     OrDivider(),
//                     Gap(24.h),
//                     ActionPromptWidget(
//                       prefixText: 'Don’t have an account?',
//                       actionText: 'Sign Up Now',
//                       onActionTapped: () {
//                         Navigator.push(
//                           context,
//                           MaterialPageRoute(
//                             builder: (context) => SignUpScreen(),
//                           ),
//                         );
//                       },
//                     ),
//                     Gap(24.h),

//                     ///login button

//                     /// Sign Up Button with loader
//                     GetBuilder<LogInController>(
//                       builder: (controller) {
//                         return Visibility(
//                           visible: controller.inProgress == false,
//                           replacement: CustomLoader(),
//                           child: CustomButton(
//                             title: "Log In",
//                             onTap: _signInButtonTap,
//                           ),
//                         );
//                       },
//                     ),
//                   ],
//                 ),
//               ),
//             ),
//           ),
//         ),
//       ),
//     );
//   }

//   ///sign in button
//   Future<void> _signInButtonTap() async {
//     if (_key.currentState!.validate()) {
//       LogInModel logInModel = LogInModel(
//         email: _emailController.text,
//         password: _passwordController.text,
//       );

//       final bool isSuccess = await logInController.logIn(logInModel);

//       if (isSuccess) {
//         /// 🔹 Email not verified → OTP
//         if (logInController.emailNotVerified) {
//           Get.to(() => VerifyAccountScreen(email: _emailController.text));
//         }
//         /// 🔹 Login success → Home
//         else {
//           await authController.saveRememberMe(
//             rememberMe: _rememberMe,
//             email: _emailController.text,
//             password: _passwordController.text,
//           );

//           Get.offAllNamed(AppRoutes.homeScreen);
//         }
//       } else {
//         showSnackBarMessage(
//           context,
//           logInController.errorMessage ?? "Something went wrong",
//           true,
//         );
//       }
//     }
//   }

//   ///forget button
//   Future<void> _forgetButtonTap() async {
//     final bool isSuccess = await forgetPasswordController.forgetPassword(
//       _emailController.text,
//     );

//     if (isSuccess && _emailController.text.isNotEmpty) {
//       Get.to(() => VerifyIdentityScreen(email: _emailController.text));
//     } else {
//       Get.snackbar("Error", "Please Enter Your Email");
//     }
//   }

//   @override
//   void dispose() {
//     _emailController.dispose();
//     _passwordController.dispose();
//     super.dispose();
//   }
// }
