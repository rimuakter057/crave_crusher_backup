// ignore_for_file: use_build_context_synchronously

import 'package:crave_crusher/core/routes/app_routes.dart';
import 'package:crave_crusher/helper/responsive_helper/responsive_helper.dart';
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
import 'package:crave_crusher/view/features/auth/screen/forgot_screen/forgot_screen.dart';
import 'package:crave_crusher/view/features/auth/screen/sign_up/sign_up_screen.dart';
import 'package:crave_crusher/view/features/auth/screen/verify_account/verify_account_screen.dart';
import 'package:crave_crusher/view/features/auth/screen/verify_identity/verify_identity_screen.dart';
import 'package:crave_crusher/view/features/auth/screen/widgets/action_promote_widget.dart';
import 'package:crave_crusher/view/features/auth/screen/widgets/or_divider_widget.dart';
import 'package:crave_crusher/view/features/auth/screen/widgets/remember_me_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

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

                        /// email input field
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

                       child:    TextButton(
                            onPressed: (){
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) =>  ForgotPasswordScreen(),
                                ),
                              );
                            },
                            child: CustomText(
                              text: "Forget Password?",
                              fontWeight: FontWeight.w600,
                              fontSize: isTablet ? 14.0 : 12.0,
                              color: AppColors.primary,
                            ),
                          ),



                          // child: GetBuilder<ForgetPasswordController>(
                          //   builder: (controller) {
                          //     return Visibility(
                          //       visible: controller.inProgress == false,
                          //       replacement: const CustomLoader(),
                          //       child: TextButton(
                          //         onPressed: _forgetButtonTap,
                          //         child: CustomText(
                          //           text: "Forget Password?",
                          //           fontWeight: FontWeight.w600,
                          //           fontSize: isTablet ? 14.0 : 12.0,
                          //           color: AppColors.primary,
                          //         ),
                          //       ),
                          //     );
                          //   },
                          // ),



                        ),

                        const OrDivider(),

                        SizedBox(height: verticalSpacing2),

                        ActionPromptWidget(
                          prefixText: "Don't have an account?",
                          actionText: 'Sign Up Now',
                          onActionTapped: ()async{

                            // ✅ Age confirmation popup
                            bool is18Plus = await _showAgeConfirmationDialog();

                            if (!is18Plus) {
                              return; // stop signup
                            }


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
    if(_emailController.text.isEmpty){
      Get.snackbar("Error", "Please Enter Your Email");
      return;
    }

    final bool isSuccess = await forgetPasswordController.forgetPassword(
      _emailController.text,
    );


if (isSuccess && _emailController.text.isNotEmpty) {
      Get.to(() => VerifyIdentityScreen(email: _emailController.text));
    }


  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }














  Future<bool> _showAgeConfirmationDialog() async {
    bool is18Plus = false;

    await showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) {
        return AlertDialog(
          backgroundColor: AppColors.white,
          title:  Text("Age Confirmation",
            style:GoogleFonts.poppins(
                color: AppColors.black

            ) ,),
          content:  Text("Are you 18 years or older?",

            style:GoogleFonts.poppins(
                color: AppColors.black

            ) ,
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child:  Text("No",

                style:GoogleFonts.poppins(
                    color: AppColors.primary,
                    fontSize: ResponsiveHelper.fontSize(14),
                    fontWeight: FontWeight.w600

                ) ,
              ),
            ),
            ElevatedButton(
              onPressed: () {
                is18Plus = true;
                Navigator.pop(context);
              },
              child:  Text("Yes",


                style:GoogleFonts.poppins(
                    color: AppColors.primary,
                    fontSize: ResponsiveHelper.fontSize(14),
                    fontWeight: FontWeight.w600

                ) ,
              ),
            ),
          ],
        );
      },
    );

    return is18Plus;
  }

}

