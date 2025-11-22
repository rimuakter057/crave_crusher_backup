// ignore_for_file: deprecated_member_use

import 'package:crave_crusher/core/routes/app_routes.dart';
import 'package:crave_crusher/utils/app_colors/app_colors.dart';
import 'package:crave_crusher/utils/app_icons/app_icons.dart';
import 'package:crave_crusher/view/components/custom_button/custom_button.dart';
import 'package:crave_crusher/view/components/custom_image/custom_image.dart';
import 'package:crave_crusher/view/components/custom_nav_bar/navbar.dart';
import 'package:crave_crusher/view/components/custom_text/custom_text.dart';
import 'package:crave_crusher/view/features/battle/widget/active_battle_card.dart';
import 'package:crave_crusher/view/features/home/widget/home_appbar.dart';
import 'package:crave_crusher/view/features/home/widget/monster_section.dart';
import 'package:crave_crusher/view/features/home/widget/today_tips.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
class EmptyHomeScreen extends StatelessWidget {
  const EmptyHomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: HomeAppbar(),
      body: SingleChildScrollView(
        padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.h),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Tip and Monster Section
            TodayTips(),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Tip for Today Title
                SizedBox(height: 24.h),

                // Your Monster Today Title
                buildTitleText(
                  imageSrc: AppIcons.smallMonster,
                  title: 'Your Monster Today',
                ),
                SizedBox(height: 16.h),
                _buildIconText(
                  text: "Add your first battle to summon your Monster.",
                ),
                SizedBox(height: 32.h),
                buildTitleText(
                  imageSrc: AppIcons.battle,
                  title: 'Active Battle',
                ),
                SizedBox(height: 16.h),
                _buildIconText(text: "Add your first battle to get started."),
                SizedBox(height: 32.h),
                CustomButton(onTap: (){
                  Get.offNamed(AppRoutes.homeScreen);

                },
                  title: "next",
                ),

              ],
            ),
          ],
        ),
      ),

      bottomNavigationBar: NavBar(currentIndex: 0),
    );
  }

  ///image with text
  Center _buildIconText({required String text}) {
    return Center(
      child: Column(
        children: [
          CustomImage(
            imageSrc: AppIcons.emptyHome,
            height: 41.h,
            width: 64.w,
            boxFit: BoxFit.cover,
          ),
          SizedBox(height: 24.h),
          SizedBox(
            width: 272.w,
            child: CustomText(
              text: text,
              maxLines: 2,
              fontSize: 16.sp,
              fontWeight: FontWeight.w400,
            ),
          ),
        ],
      ),
    );
  }

  ///build text title
  Padding buildTitleText({required String imageSrc, required String title}) {
    return Padding(
      padding: EdgeInsets.only(bottom: 12.h),
      child: Row(
        children: [
          Container(
            height: 28.h,
            width: 28.w,
            alignment: Alignment.center,
            decoration: BoxDecoration(
              color: AppColors.subPrimary.withOpacity(.3),
              shape: BoxShape.circle,
              border: Border.all(color: AppColors.primary),
            ),
            child: CustomImage(imageSrc: imageSrc, height: 16.h, width: 16.w),
          ),
          SizedBox(width: 8.w),
          CustomText(text: title, fontWeight: FontWeight.w600, fontSize: 18.sp),




        ],
      ),
    );
  }
}
