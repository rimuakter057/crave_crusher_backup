

import 'package:crave_crusher/utils/app_colors/app_colors.dart';
import 'package:crave_crusher/view/components/custom_container/custom_container.dart';
import 'package:crave_crusher/view/components/custom_leadin_title_appbar.dart';
import 'package:crave_crusher/view/components/custom_text/custom_text.dart';
import 'package:crave_crusher/view/components/input_password_field_widget/input_password_field_widget.dart';
import 'package:crave_crusher/view/features/profile/profile_screen/profile_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';


class ChangePasswordScreen extends StatelessWidget {
  const ChangePasswordScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:  CustomLeadingTitleAppbar(title: "Change Password"),

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






