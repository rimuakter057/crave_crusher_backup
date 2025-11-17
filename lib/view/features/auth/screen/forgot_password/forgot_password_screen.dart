

import 'package:crave_crusher/view/components/custom_button/custom_button.dart';
import 'package:crave_crusher/view/components/custom_text/custom_text.dart';
import 'package:crave_crusher/view/components/input_field_with_title/input_field_with_title.dart';
import 'package:crave_crusher/view/features/auth/screen/login/login_screen.dart';
import 'package:crave_crusher/view/features/auth/screen/verify_account/verify_account_screen.dart';

import 'package:crave_crusher/view/features/auth/screen/widgets/action_promote_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';


class ForgotPasswordScreen extends StatelessWidget {
  const ForgotPasswordScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(


      body: Center(
        child: SingleChildScrollView(
          child: Padding(
            padding:  EdgeInsets.symmetric(horizontal:16.w),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Gap(8.h),
                ///reset  text
                CustomText(
                  textAlign: TextAlign.start,
                  text: "Forgot Your Password",fontSize: 28.sp,fontWeight: FontWeight.w500,),
                CustomText(
                  maxLines: 2,
                  textAlign: TextAlign.start,
                  text: "Create a new password for your Crave Crusher account.",fontSize: 14.sp,fontWeight: FontWeight.w400,
                  color: Color(0xFF555555),
                ),
                Gap(24.h),

                ///input field
                InputFieldWithTitleWidget(title: "Email Address", hintText: "Enter your email"),

                Gap(16.h),
                ActionPromptWidget(prefixText: 'Remembered it now?', actionText: 'Log In', onActionTapped: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => LoginScreen()),
                  );
                },),


                ///reset button
                Gap(16.h),
                CustomButton(
                    title: "Forgot Password",
                    onTap: (){
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => VerifyAccountScreen()),
                      );
                    })
              ],
            ),
          ),
        ),
      ),

    );
  }
}






