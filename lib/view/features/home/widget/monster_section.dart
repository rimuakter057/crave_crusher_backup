// ignore_for_file: deprecated_member_use

import 'package:crave_crusher/utils/app_colors/app_colors.dart';
import 'package:crave_crusher/utils/app_icons/app_icons.dart';
import 'package:crave_crusher/view/components/custom_image/custom_image.dart';
import 'package:crave_crusher/view/components/custom_text/custom_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class MonsterSection extends StatelessWidget {
  const MonsterSection({super.key, required this.image});
final String image;
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Tip for Today Title
        SizedBox(height: 24.h),

        // Your Monster Today Title
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
                  imageSrc: AppIcons.smallMonster,

                  height: 16.h,
                  width: 16.w,
                ),
              ), //Placeholder icon
              SizedBox(width: 8),
              CustomText(
                text: "Your Monster Today",
                fontWeight: FontWeight.w600,
                fontSize: 18,
              ),
            ],
          ),
        ),

        // Monster Image
        CustomImage(
          imageSrc: image, // Placeholder Monster PNG
          scale: 4,
        ),

        Container(
          height: 52.h,
          width: double.maxFinite,
          alignment: Alignment.center,
          decoration: BoxDecoration(
            color: AppColors.softGreen, // Light Green
            borderRadius: BorderRadius.circular(8),
            border: Border.all(color: AppColors.green),
          ),
          child: CustomText(
            text: "Your Monster Is Losing Power — Keep It Up!",
            fontWeight: FontWeight.w600,
            fontSize: 14.w,
            color: AppColors.green,
            maxLines: 2,
          ),
        ),
      ],
    );
  }
}
