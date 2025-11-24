import 'package:crave_crusher/view/components/custom_button/custom_button.dart';
import 'package:crave_crusher/view/components/custom_text/custom_text.dart';
import 'package:crave_crusher/view/components/input_field_with_title/input_field_with_title.dart';
import 'package:crave_crusher/view/components/input_password_field_widget/input_password_field_widget.dart';
import 'package:crave_crusher/view/components/show_snakbar/show_snakbar.dart';
import 'package:crave_crusher/view/features/auth/controllers/sign_up_controller.dart';
import 'package:crave_crusher/view/features/auth/models/user_model.dart';
import 'package:crave_crusher/view/features/auth/screen/login/login_screen.dart';
import 'package:crave_crusher/view/features/auth/screen/verify_account/verify_account_screen.dart';
import 'package:crave_crusher/view/features/auth/screen/widgets/action_promote_widget.dart';
import 'package:crave_crusher/view/features/auth/screen/widgets/or_divider_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final bool _rememberMe = false;

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _fullNameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmedPasswordController = TextEditingController();

  final SignUpController signUpController = Get.find<SignUpController>();

  /// ======================= Sign Up Method =========================




  /// ================================================================

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Form(
        key: _formKey,
        child: Center(
          child: SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.w),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  /// Sign Up text
                  CustomText(
                    textAlign: TextAlign.start,
                    text: "Create Your Account",
                    fontSize: 28.sp,
                    fontWeight: FontWeight.w500,
                  ),
                  CustomText(
                    maxLines: 2,
                    textAlign: TextAlign.start,
                    text: "Start your battle and defeat your Addiction Monster.",
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w400,
                    color: Color(0xFF555555),
                  ),
                  Gap(24.h),

                  /// Input Fields
                  InputFieldWithTitleWidget(
                    title: "Full Name",
                    hintText: "Enter your full name",
                    controller: _fullNameController,
                    validator: (String? value) {
                      if (value?.trim().isEmpty ?? true) {
                        return "Enter Your Full Name";
                      }
                      return null;
                    },
                  ),
                  Gap(16.h),
                  InputFieldWithTitleWidget(
                    title: "Email Address",
                    hintText: "Enter your email",
                    controller: _emailController,
                    validator: (String? value) {
                      if (value?.trim().isEmpty ?? true) {
                        return "Enter Your Email";
                      }
                      return null;
                    },
                  ),
                  Gap(16.h),
                  InputPasswordFieldWidget(
                    title: "Password",
                    controller: _passwordController,
                    validator: (String? value) {
                      if ((value?.isEmpty ?? true) || value!.length < 6) {
                        return "Enter a valid password";
                      }
                      return null;
                    },
                  ),
                  Gap(16.h),
                  InputPasswordFieldWidget(
                    title: "Confirmed Password",
                    hintText: "Enter Confirmed password",
                    controller: _confirmedPasswordController,
                  ),
                  Gap(16.h),

                  /// Remember & Terms
                  Row(
                    children: [
                      Checkbox(
                        value: _rememberMe,
                        onChanged: (value) {},
                      ),
                      Expanded(
                        child: const CustomText(
                          textAlign: TextAlign.start,
                          maxLines: 2,
                          text: "I agree to the Terms & Conditions and Privacy Policy",
                          fontWeight: FontWeight.w400,
                          fontSize: 12,
                          color: Color(0xFF555555),
                        ),
                      ),
                    ],
                  ),

                  OrDivider(),
                  Gap(24.h),
                  ActionPromptWidget(
                    prefixText: 'Already have an account?',
                    actionText: 'Log In',
                    onActionTapped: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => LoginScreen()),
                      );
                    },
                  ),
                  Gap(24.h),

                  /// Sign Up Button with loader
                  GetBuilder<SignUpController>(
                    builder: (controller) {
                      return Visibility(
                        visible: controller.signUpInProgress == false,
                        replacement: Center(child: CircularProgressIndicator()),
                        child: CustomButton(
                          title: "Sign Up",
                          onTap: _signUp, // <-- calls separate method
                        ),
                      );
                    },
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }




 Future <void> _signUp() async{
    if (_formKey.currentState!.validate()) {
      UserModel userModel =UserModel(fullName: _fullNameController.text.trim(), email: _emailController.text.trim(),
          password: _passwordController.text);
      final bool isSuccess= await signUpController.signUp(userModel);

      if(isSuccess){
        Get.to(VerifyAccountScreen(email: _emailController.text,));
      }else{
        showSnackBarMessage(context, signUpController.errorMessage!, true);
      }


    }
  }




}
