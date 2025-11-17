import 'package:crave_crusher/view/components/custom_button/custom_button.dart';
import 'package:crave_crusher/view/components/custom_text/custom_text.dart';
import 'package:crave_crusher/view/components/input_field_with_title/input_field_with_title.dart';
import 'package:crave_crusher/view/components/input_password_field_widget/input_password_field_widget.dart';
import 'package:crave_crusher/view/screens/auth/screen/sign_up/sign_up_screen.dart';
import 'package:crave_crusher/view/screens/auth/screen/widgets/action_promote_widget.dart';
import 'package:crave_crusher/view/screens/auth/screen/widgets/or_divider_widget.dart';
import 'package:crave_crusher/view/screens/auth/screen/widgets/remember_me_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {

  bool _rememberMe = false;

  void _handleRememberMeChange(bool? newValue) {
    setState(() {
      _rememberMe = newValue ?? false;
    });
    // Add logic here to save state (e.g., using SharedPreferences)
    print('Remember Me is now: $_rememberMe');
  }

  void _handleForgotPasswordTap() {
    // Add logic here to navigate to the forgot password screen
    print('Navigating to Forgot Password screen...');
    // Navigator.push(context, MaterialPageRoute(builder: (context) => ForgotPasswordScreen()));
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SingleChildScrollView(
          child: Padding(
            padding:  EdgeInsets.symmetric(horizontal: 16.w),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ///login text
                CustomText(
                
                  textAlign: TextAlign.start,
                  text: "Welcome Back",fontSize: 30.sp,fontWeight: FontWeight.w500,),
                CustomText(
                  maxLines: 2,
                  textAlign: TextAlign.start,
                  text: "Let’s continue your journey to crush those cravings!",fontSize: 14.sp,fontWeight: FontWeight.w400,
                color: Color(0xFF555555),
                ),
                Gap(24.h),
                ///input field
                 InputFieldWithTitleWidget(title: "Email Address", hintText: "Enter your email"),
                Gap(16.h),
                InputPasswordFieldWidget(title: "Password"),
                
                ///remember and forgot section
                RememberMeAndForgotPassword(
                  isChecked: _rememberMe,
                  onRememberMeChanged: _handleRememberMeChange,
                  onForgotPasswordTapped: _handleForgotPasswordTap,
                ),
                OrDivider(),
                Gap(24.h),
                ActionPromptWidget(prefixText: 'Don’t have an account?', actionText: 'Sign Up Now', onActionTapped: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => SignUpScreen()),
                  );
                },),
                Gap(24.h),
                CustomButton(
                    title: " Log In",
                    onTap: (){}),
              ],
            ),
          ),
        ),
      ),
    
    );
  }
}
