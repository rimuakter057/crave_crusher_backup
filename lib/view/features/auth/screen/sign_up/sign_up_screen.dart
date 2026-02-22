// ignore_for_file: use_build_context_synchronously

import 'package:crave_crusher/helper/responsive_helper/responsive_helper.dart';
import 'package:crave_crusher/utils/app_colors/app_colors.dart';
import 'package:crave_crusher/view/components/custom_button/custom_button.dart';
import 'package:crave_crusher/view/components/custom_loader/custom_loader.dart';
import 'package:crave_crusher/view/components/custom_text/custom_text.dart';
import 'package:crave_crusher/view/components/input_field_with_title/input_field_with_title.dart';
import 'package:crave_crusher/view/components/show_snack_bar/show_snack_bar.dart';
import 'package:crave_crusher/view/features/auth/controllers/sign_up_controller.dart';
import 'package:crave_crusher/view/features/auth/models/signup_model.dart';
import 'package:crave_crusher/view/features/auth/screen/login/login_screen.dart';
import 'package:crave_crusher/view/features/auth/screen/verify_account/verify_account_screen.dart';
import 'package:crave_crusher/view/features/auth/screen/widgets/action_promote_widget.dart';
import 'package:crave_crusher/view/features/auth/screen/widgets/or_divider_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _fullNameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmedPasswordController =
      TextEditingController();

  final SignUpController signUpController = Get.find<SignUpController>();

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

    final double termsTextSize = isTablet ? 12.0 : 10.0;

    final double verticalSpacing1 = isTablet ? 32.0 : 24.0;
    final double verticalSpacing2 = isTablet ? 24.0 : 16.0;

    return Scaffold(
      body: SafeArea(
        child: Form(
          key: _formKey,
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
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        if (isTablet) const SizedBox(height: 20),

                        /// Sign Up text
                        CustomText(
                          textAlign: TextAlign.start,
                          text: "Create Your Account",
                          fontSize: titleSize,
                          fontWeight: FontWeight.w500,
                        ),

                        SizedBox(height: isTablet ? 12 : 8),

                        CustomText(
                          maxLines: 3,
                          textAlign: TextAlign.start,
                          text:
                              "Start your battle and defeat your Addiction Monster.",
                          fontSize: subtitleSize,
                          fontWeight: FontWeight.w400,
                          color: const Color(0xFF555555),
                        ),

                        SizedBox(height: verticalSpacing1),

                        InputFieldWithTitleWidget(
                          title: "Full Name",
                          hintText: "Enter your full name",
                          controller: _fullNameController,
                          isTablet: isTablet,
                          validator: (String? value) {
                            if (value == null || value.trim().isEmpty) {
                              return "Enter your full name";
                            }

                            if (value.trim().length > 12) {
                              return "Full Name must be within 12 characters";
                            }

                            return null;
                          },
                        ),

                        SizedBox(height: verticalSpacing2),

                        InputFieldWithTitleWidget(
                          title: "Email Address",
                          hintText: "Enter your email",
                          controller: _emailController,
                          isTablet: isTablet,
                          validator: (String? value) {
                            if (value == null || value.trim().isEmpty) {
                              return "Enter Your Email";
                            }
                            // Simple email regex
                            final emailRegex = RegExp(
                              r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$',
                            );
                            if (!emailRegex.hasMatch(value.trim())) {
                              return "Enter a valid email address";
                            }
                            return null;
                          },
                        ),

                        SizedBox(height: verticalSpacing2),

                        InputPasswordFieldWidget(
                          title: "Password",
                          controller: _passwordController,
                          isTablet: isTablet,
                          validator: (String? value) {
                            if ((value?.isEmpty ?? true) || value!.length < 6) {
                              return "Enter a valid password";
                            }
                            return null;
                          },
                        ),

                        SizedBox(height: verticalSpacing2),

                        InputPasswordFieldWidget(
                          title: "Confirmed Password",
                          hintText: "Enter Confirmed password",
                          controller: _confirmedPasswordController,
                          isTablet: isTablet,
                        ),

                        SizedBox(height: verticalSpacing2),

                        /// Remember & Terms
                        GetBuilder<SignUpController>(
                          builder: (controller) {
                            return Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Transform.scale(
                                  scale: isTablet ? 1.2 : 1.0,
                                  child: Checkbox(
                                    value: controller.termsAgree,
                                    onChanged: (value) {
                                      controller.toggleTerms(value ?? false);
                                    },
                                    materialTapTargetSize:
                                        MaterialTapTargetSize.shrinkWrap,
                                  ),
                                ),
                                SizedBox(width: isTablet ? 8 : 4),
                                Expanded(
                                  child: CustomText(
                                    maxLines: 2,
                                    overflow: TextOverflow.ellipsis,
                                    textAlign: TextAlign.start,
                                    text:
                                        "I agree to the Terms & Conditions and Privacy Policy",
                                    fontSize: termsTextSize,
                                    color: const Color(0xFF555555),
                                  ),
                                ),
                              ],
                            );
                          },
                        ),

                        const OrDivider(),

                        SizedBox(height: verticalSpacing1),

                        ActionPromptWidget(
                          prefixText: 'Already have an account?',
                          actionText: 'Log In',
                          onActionTapped: () {
                            Get.to(() => const LoginScreen());
                          },
                        ),

                        SizedBox(height: verticalSpacing1),

                        /// Sign Up Button with loader
                        GetBuilder<SignUpController>(
                          builder: (controller) {
                            return Visibility(
                              visible: controller.signUpInProgress == false,
                              replacement: const CustomLoader(),
                              child: CustomButton(
                                title: "Sign Up",
                                onTap: _signUp,
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

  Future<void> _signUp() async {
    // 🔹 Terms check
    if (!signUpController.termsAgree) {
      showSnackBarMessage(
        context,
        "Please accept the Terms & Conditions to continue.",
        true,
      );
      return;
    }

    if (_formKey.currentState!.validate()) {
      if (_passwordController.text != _confirmedPasswordController.text) {
        showSnackBarMessage(
          context,
          "Password and Confirm Password do not match.",
          true,
        );
        return;
      }





      // 🔹 Create user model
      SignUpModel userModel = SignUpModel(
        fullName: _fullNameController.text.trim(),
        email: _emailController.text.trim(),
        password: _passwordController.text,
      );

      // 🔹 Call signUp
      final bool isSuccess = await signUpController.signUp(
        userModel,
        _confirmedPasswordController.text, // pass confirm password
      );

      if (isSuccess) {
        Get.to(() => VerifyAccountScreen(email: _emailController.text));
      } else {
        showSnackBarMessage(
          context,
          signUpController.errorMessage ?? "Something went wrong.",
          true,
        );
      }
    }
  }

  @override
  void dispose() {
    _fullNameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _confirmedPasswordController.dispose();
    super.dispose();
  }




}


