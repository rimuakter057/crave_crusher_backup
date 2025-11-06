// ignore_for_file: deprecated_member_use

import 'package:crave_crusher/utils/app_colors/app_colors.dart';
import 'package:crave_crusher/view/components/custom_button/custom_button.dart';
import 'package:crave_crusher/view/components/custom_image/custom_image.dart';
import 'package:crave_crusher/view/components/custom_text/custom_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ActiveBattleCard extends StatelessWidget {
  final String iconSrc;
  final String title;
  final double progress;
  final String status;
  final String dayCount;
  final Color statusColor;

  const ActiveBattleCard({
    super.key,
    required this.iconSrc,
    required this.title,
    required this.progress,
    required this.status,
    required this.dayCount,
    required this.statusColor,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(12.w),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: AppColors.black.withOpacity(0.05),
            spreadRadius: 1,
            blurRadius: 5,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              // Icon and Title
              Row(
                children: [
                  Container(
                    height: 30.h,
                    width: 30.w,
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      color: AppColors.subPrimary.withOpacity(.3),
                      border: Border.all(color: AppColors.primary),
                      borderRadius: BorderRadius.circular(3),
                    ),
                    child: CustomImage(
                      imageSrc: iconSrc,
                      height: 22.h,
                      width: 22.w,
                    ),
                  ),
                  SizedBox(width: 10.w),
                  CustomText(
                    text: title,
                    fontWeight: FontWeight.w600,
                    fontSize: 16,
                    color: AppColors.appTitle,
                    bottom: 0,
                    top: 0,
                  ),
                ],
              ),
              // Status Badge
              Container(
                padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 4.h),
                decoration: BoxDecoration(
                  color: statusColor.withOpacity(0.2),
                  borderRadius: BorderRadius.circular(16),
                ),
                child: CustomText(
                  text: "* $status",
                  fontSize: 12.w,
                  fontWeight: FontWeight.w500,
                  color: statusColor,
                  bottom: 0,
                  top: 0,
                ),
              ),
            ],
          ),

          SizedBox(height: 10.h),

          // Progress Text (58% to complete)
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              CustomText(
                text: "${(progress * 100).toInt()}% to complete",
                fontSize: 14.w,
                fontWeight: FontWeight.w500,
                color: AppColors.black,
                bottom: 0,
                top: 0,
              ),
              CustomText(
                text: dayCount,
                fontSize: 12.w,
                fontWeight: FontWeight.w400,
                color: AppColors.softWhite,
                bottom: 0,
                top: 0,
              ),
            ],
          ),

          SizedBox(height: 8.h),

          // Progress Bar
          LinearProgressIndicator(
            value: progress,
            backgroundColor: AppColors.subPrimary.withOpacity(0.5),
            valueColor: AlwaysStoppedAnimation<Color>(AppColors.primary),
            minHeight: 8.h,
            borderRadius: BorderRadius.circular(4.r),
          ),

          SizedBox(height: 12.h),

          // Open Battle Button
          CustomButton(
            onTap: () {}, // Logic will be implemented here
            title: "Open Battle",
            height: 35.h,
            width: 150.w, // Fixed width for button
            fillColor: AppColors.subPrimary,
            textColor: AppColors.primary,
            borderRadius: 8,
            fontSize: 14.w,
            fontWeight: FontWeight.w600,
          ),
        ],
      ),
    );
  }
}
