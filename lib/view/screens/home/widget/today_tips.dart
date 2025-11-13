// ignore_for_file: deprecated_member_use

import 'package:crave_crusher/utils/app_colors/app_colors.dart';
import 'package:crave_crusher/utils/app_icons/app_icons.dart';
import 'package:crave_crusher/view/components/custom_image/custom_image.dart';
import 'package:crave_crusher/view/components/custom_text/custom_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class TodayTips extends StatelessWidget {
  const TodayTips({super.key, this.title});

  final String? title;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
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
                child: CustomImage(
                  //imageColor: AppColors.primary,
                  imageSrc: AppIcons.tipsPng,

                  height: 16.h,
                  width: 16.w,
                ),
              ),
              SizedBox(width: 8),
              CustomText(
                text: "Tip for Today",
                fontWeight: FontWeight.w600,
                fontSize: 16,
              ),
            ],
          ),
        ),

        CustomImage(
          imageSrc: AppIcons.tipsBackground,
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.0.w),
            child: CustomText(
              text:
                  title ??
                  '“ Each craving lasts only a few minutes — take slow, deep breaths and remind yourself why you started. ”',
              maxLines: 5,
              fontSize: 14.w,
              textAlign: TextAlign.center,
              color: AppColors.primary,
            ),
          ),
        ),
      ],
    );
  }
}
