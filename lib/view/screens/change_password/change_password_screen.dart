

import 'package:crave_crusher/utils/app_colors/app_colors.dart';
import 'package:crave_crusher/utils/app_images/app_images.dart';
import 'package:crave_crusher/view/components/common_profile/avater_widget.dart';
import 'package:crave_crusher/view/components/custom_container/custom_container.dart';
import 'package:crave_crusher/view/components/custom_text/custom_text.dart';
import 'package:crave_crusher/view/components/input_password_field_widget/input_password_field_widget.dart';
import 'package:crave_crusher/view/screens/profile/profile_screen/profile_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';


class ChangePasswordScreen extends StatelessWidget {
  const ChangePasswordScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:  AppBar(
        surfaceTintColor: AppColors.backgroundColor,
        backgroundColor:AppColors.backgroundColor,
        leading: Center(
          child: Container(
            width: 50.w,
            height: 50.h,
            alignment: Alignment.center,
            decoration: BoxDecoration(
              color: AppColors.subPrimary.withOpacity(.3),
              shape: BoxShape.circle,
              border: Border.all(color: AppColors.subPrimary),
            ),
            child: BackButton(color: AppColors.primary),
          ),
        ),
        centerTitle: true,
        title: CustomText(
          text: "Change Password",
          fontSize: 18.sp,
          fontWeight: FontWeight.w500,
        ),
      ),

      body: Padding(
        padding:  EdgeInsets.symmetric(horizontal:16.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Gap(8.h),

            InputPasswordFieldWidget(title: "Old Password",),
            Gap(16.h),
            InputPasswordFieldWidget(title: "New Password",),
            Gap(16.h),
            InputPasswordFieldWidget(title: "Confirmed Password",),
            Gap(16.h),
            ///update button
            GestureDetector(
              onTap: (){
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => ProfileScreen()),
                );


              },
              child: CustomContainer(
                backgroundColor: AppColors.primary,
                padding: 4,
                height: 36.h,
                width: 140.w,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [

                    CustomText(text: "Update", color: AppColors.white),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),

    );
  }
}






