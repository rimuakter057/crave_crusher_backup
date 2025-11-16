

import 'package:crave_crusher/utils/app_colors/app_colors.dart';
import 'package:crave_crusher/utils/app_images/app_images.dart';
import 'package:crave_crusher/view/components/common_profile/avater_widget.dart';
import 'package:crave_crusher/view/components/custom_container/custom_container.dart';
import 'package:crave_crusher/view/components/custom_text/custom_text.dart';
import 'package:crave_crusher/view/components/custom_text_field/custom_text_field.dart';
import 'package:crave_crusher/view/components/input_field_with_title/input_field_with_title.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';


class EditProfileScreens extends StatelessWidget {
  const EditProfileScreens({super.key});

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
          text: "Edit Profile",
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
            Center(child: ProfileAvatarWidget(imagePath: AppImages.profileManImage,heightA: 100.h,widthA: 100.w,)),
            Gap(16.h),

            InputFieldWithTitleWidget(title:"Full Name", hintText: "e.g. Sheena DuBois ",),
            Gap(16.h),
            InputFieldWithTitleWidget(title:"Email Address", hintText: "e.g. kristin.SheenaDuBois@example.com",),
            Gap(16.h),
            ///update button
            GestureDetector(
              onTap: (){
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => EditProfileScreens()),
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

                    CustomText(text: "Edit  Profile", color: AppColors.white),
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


