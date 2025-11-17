import 'package:crave_crusher/view/components/custom_button/custom_button.dart';
import 'package:crave_crusher/view/components/custom_text/custom_text.dart';
import 'package:crave_crusher/view/components/input_field_with_title/input_field_with_title.dart';
import 'package:crave_crusher/view/components/input_password_field_widget/input_password_field_widget.dart';
import 'package:crave_crusher/view/screens/auth/screen/login/login_screen.dart';
import 'package:crave_crusher/view/screens/auth/screen/widgets/action_promote_widget.dart';
import 'package:crave_crusher/view/screens/auth/screen/widgets/or_divider_widget.dart';
import 'package:crave_crusher/view/screens/auth/screen/widgets/remember_me_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {

  bool _rememberMe = false;


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
                ///sign up text
                CustomText(
                
                  textAlign: TextAlign.start,
                  text: "Create Your Account",fontSize: 28.sp,fontWeight: FontWeight.w500,),
                CustomText(
                  maxLines: 2,
                  textAlign: TextAlign.start,
                  text: "Start your battle and defeat your Addiction Monster.",fontSize: 14.sp,fontWeight: FontWeight.w400,
                  color: Color(0xFF555555),
                ),
                Gap(24.h),
                ///input field
              InputFieldWithTitleWidget(title: "Full Name", hintText: "Enter your full name"),
                Gap(16.h),
                InputFieldWithTitleWidget(title: "Email Address", hintText: "Enter your email"),
                Gap(16.h),
                InputPasswordFieldWidget(title: "Password"),
                Gap(16.h),
                InputPasswordFieldWidget(title: "Confirmed Password",hintText: "Enter Confirmed password",),
                
                ///remember and forgot section
                // 1. Remember Me Checkbox and Text
                Row(
                  children: [
                    Checkbox(
                      value:_rememberMe ,
                      onChanged: (value){},
                    ),
                    Expanded(
                      child: const  CustomText(
                          textAlign: TextAlign.start,
                          maxLines: 2,
                          text: "I agree to the Terms & Conditions and Privacy Policy",fontWeight: FontWeight.w400,fontSize: 12,color: Color(0xFF555555)),
                    ),
                  ],
                ),
                
                OrDivider(),
                Gap(24.h),
                ActionPromptWidget(prefixText: 'Already have an account?', actionText: 'Log In', onActionTapped: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => LoginScreen()),
                  );
                },),
                Gap(24.h),
                CustomButton(
                    title: "Sign Up",
                    onTap: (){
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => LoginScreen()),
                      );
                
                    }),
              ],
            ),
          ),
        ),
      ),

    );
  }
}
