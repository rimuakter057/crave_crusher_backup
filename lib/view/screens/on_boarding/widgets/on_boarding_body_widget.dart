import 'package:crave_crusher/utils/app_colors/app_colors.dart';
import 'package:crave_crusher/utils/app_images/app_images.dart';
import 'package:crave_crusher/view/components/custom_button/custom_button.dart';
import 'package:crave_crusher/view/components/custom_image/custom_image.dart';
import 'package:crave_crusher/view/components/custom_text/custom_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';


class OnBoardingBodyWidget extends StatelessWidget {
  const OnBoardingBodyWidget({
    super.key, required this.imagePath, required this.title, required this.subTitle, required this.onTap,
  });

  final String imagePath;
  final String title;
  final String subTitle;
  final void Function() onTap;

  @override
  Widget build(BuildContext context) {
    return Center(
      child:Padding(
        padding:  EdgeInsets.symmetric(horizontal:16.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ///image
            CustomImage(imageSrc: imagePath,height: 238.h,
              width: 280.w,
            ),
            Gap(24.h),
            ///on boarding  text
            CustomText(

              text: title,fontSize: 20.sp,fontWeight: FontWeight.w500,),
            Gap(8.h),
            CustomText(
              maxLines: 2,

              text: subTitle,fontSize: 14.sp,fontWeight: FontWeight.w400,
              color: Color(0xFF555555),
            ),
            Gap(72.h),
            ///container
            Container(
              height: 6.h, // height
              width: 28.w, // width
              decoration: BoxDecoration(
                color: AppColors.primary,// background color
                borderRadius: BorderRadius.circular(20.r), // radius
              ),
            ),

            Gap(100.h),
            ///button
            CustomButton(
                title: "Next    >",
                onTap:onTap),
          ],),
      ),
    );
  }
}