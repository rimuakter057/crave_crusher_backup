

import 'package:crave_crusher/utils/app_colors/app_colors.dart';
import 'package:crave_crusher/utils/app_images/app_images.dart';
import 'package:crave_crusher/view/components/common_profile/avater_widget.dart';
import 'package:crave_crusher/view/components/custom_button/custom_button.dart';
import 'package:crave_crusher/view/components/custom_container/custom_container.dart';
import 'package:crave_crusher/view/components/custom_text/custom_text.dart';
import 'package:crave_crusher/view/components/input_password_field_widget/input_password_field_widget.dart';
import 'package:crave_crusher/view/screens/auth/screen/login/login_screen.dart';
import 'package:crave_crusher/view/screens/auth/screen/widgets/action_promote_widget.dart';
import 'package:crave_crusher/view/screens/profile/profile_screen/profile_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';


class ResetPasswordScreen extends StatelessWidget {
  const ResetPasswordScreen({super.key});

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
                  text: "Reset Your Password",fontSize: 28.sp,fontWeight: FontWeight.w500,),
                CustomText(
                  maxLines: 2,
                  textAlign: TextAlign.start,
                  text: "Create a new password for your Crave Crusher account.",fontSize: 14.sp,fontWeight: FontWeight.w400,
                  color: Color(0xFF555555),
                ),
                Gap(24.h),

                InputPasswordFieldWidget(title: "New Password",),
                Gap(16.h),
                InputPasswordFieldWidget(title: "Confirmed Password",),
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
                    title: "Reset Password",
                    onTap: (){
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => LoginScreen()),
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






