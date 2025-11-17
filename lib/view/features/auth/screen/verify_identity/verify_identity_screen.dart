

import 'package:crave_crusher/view/components/custom_button/custom_button.dart';
import 'package:crave_crusher/view/components/custom_text/custom_text.dart';
import 'package:crave_crusher/view/features/auth/screen/login/login_screen.dart';
import 'package:crave_crusher/view/features/auth/screen/reset_password/reset_password_screen.dart';
import 'package:crave_crusher/view/features/auth/screen/widgets/action_promote_widget.dart';
import 'package:crave_crusher/view/features/auth/screen/widgets/otp_field_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';


class VerifyIdentityScreen extends StatelessWidget {
  const VerifyIdentityScreen({super.key});

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
                  text: "Verify Your Identity",fontSize: 28.sp,fontWeight: FontWeight.w500,),
                CustomText(
                  maxLines: 2,
                  textAlign: TextAlign.start,
                  text: "We’ve sent a 6-digit verification code to ne***************@gmail.com",fontSize: 14.sp,fontWeight: FontWeight.w400,
                  color: Color(0xFF555555),
                ),
                Gap(24.h),

                OtpFieldWidget(
                  onCompleted: (value) {
                    print("OTP Completed: $value");
                  },
                ),
                Gap(16.h),
                ///action promot
                ActionPromptWidget(prefixText: 'Didn’t receive the code?', actionText: 'Resend OTP (30s)', onActionTapped: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => LoginScreen()),
                  );
                },),


                ///reset button
                Gap(16.h),
                CustomButton(
                    title: "Verify OTP",
                    onTap: (){
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => ResetPasswordScreen()),
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






