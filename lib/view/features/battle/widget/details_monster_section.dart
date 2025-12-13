// ignore_for_file: deprecated_member_use

import 'package:crave_crusher/utils/app_colors/app_colors.dart';
import 'package:crave_crusher/utils/app_icons/app_icons.dart';
import 'package:crave_crusher/view/components/custom_image/custom_image.dart';
import 'package:crave_crusher/view/components/custom_text/custom_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class DetailsMonsterSection extends StatelessWidget {
  // Battle details to display in the header
  final String battleTitle;
  final String battleDescription;
  final String status;
  final String monsterStatusMessage;

  const DetailsMonsterSection({
    super.key,
    required this.battleTitle,
    required this.battleDescription,
    required this.status,
    required this.monsterStatusMessage,
  });

  @override
  Widget build(BuildContext context) {

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Battle Header (Icon, Title, Status)
        Padding(
          padding: EdgeInsets.only(bottom: 16.h),
          child: Container(
            padding: EdgeInsets.all(12.w),
            decoration: BoxDecoration(
              color: AppColors.white,
              borderRadius: BorderRadius.circular(12),

            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                // Icon, Title, and Description
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      height: 44.h,
                      width: 44.w,
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        color: AppColors.subPrimary.withOpacity(.3),
                        borderRadius: BorderRadius.circular(3.r),
                        border: Border.all(color: AppColors.subPrimary),
                      ),
                      child: CustomImage(
                        imageSrc: AppIcons.smoke, // Small monster avatar
                        height: 36.h,
                        width: 36.w,
                      ),
                    ),
                    SizedBox(width: 10.w),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        CustomText(
                          textAlign: TextAlign.start,
                          text: battleTitle,
                          fontWeight: FontWeight.w600,
                          fontSize: 16.sp,
                          color: AppColors.appTitle,
                          bottom: 0,
                          top: 0,
                        ),

                        SizedBox(
                          width: 180.w, // Constrain width for description
                          child: CustomText(
                            textAlign: TextAlign.start,
                            text: battleDescription,
                            fontWeight: FontWeight.w400,
                            fontSize: 12.sp,
                            color: AppColors.softWhite,
                            maxLines: 2,
                            bottom: 0,
                            top: 0,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                // Status Badge
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 4.w, vertical: 4.h),
                  decoration: BoxDecoration(
                    color: AppColors.subPrimary.withOpacity(
                      0.3,
                    ), // Using subPrimary as a placeholder color
                    borderRadius: BorderRadius.circular(5),
                    border: Border.all(color: AppColors.primary),
                  ),
                  child: CustomText(
                    text: "• $status",
                    fontSize: 12.w,
                    fontWeight: FontWeight.w500,
                    color: AppColors.primary,
                    bottom: 0,
                    top: 0,
                  ),
                ),

              ],
            ),
          ),
        ),

        // Monster Image
        Center(
          child: CustomImage(
            imageSrc: AppIcons.happyMonstar, // Placeholder Monster PNG
            height: 250.h,
            width: 250.w,
            scale: 1,
          ),
        ),
        SizedBox(height: 24.h),

        // Monster Status Container
        Container(
          height: 52.h,
          width: double.maxFinite,
          alignment: Alignment.center,
          padding: EdgeInsets.symmetric(horizontal: 16.w),
          decoration: BoxDecoration(
            color: AppColors.softGreen, // Light Green
            borderRadius: BorderRadius.circular(8),
            border: Border.all(color: AppColors.green),
          ),
          child: CustomText(
            text: monsterStatusMessage,
            fontWeight: FontWeight.w600,
            fontSize: 14.sp,
            color: AppColors.green,
            maxLines: 2,
            textAlign: TextAlign.center,
            bottom: 0,
            top: 0,
          ),
        ),
      ],
    );
  }
}
