// ignore_for_file: deprecated_member_use, unused_local_variable

import 'package:crave_crusher/utils/app_colors/app_colors.dart';
import 'package:crave_crusher/utils/app_icons/app_icons.dart';
import 'package:crave_crusher/view/components/custom_image/custom_image.dart';
import 'package:crave_crusher/view/components/custom_text/custom_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ActiveBattleCard extends StatelessWidget {
  final String title;
  final double progress;
  final String status;
  final String dayCount;
  final DetoxType detoxType;
  final VoidCallback? onBattlePressed;
  final String percentText;
  const ActiveBattleCard({
    super.key,
    required this.title,
    required this.progress,
    required this.status,
    required this.dayCount,
    required this.detoxType,
    this.onBattlePressed,
    required this.percentText,
  });

  String getIcon(DetoxType detoxType) {
    switch (detoxType) {
      case DetoxType.smoke:
        return AppIcons.smoke;
      case DetoxType.love:
        return AppIcons.toxicRelationship;
      case DetoxType.drugDetox:
        return AppIcons.savingsMoney;
      case DetoxType.junkFood:
        return AppIcons.junkFood;
      case DetoxType.shopping:
        return AppIcons.shopping;
      case DetoxType.socialMedia:
        return AppIcons.socialMedia;
    }
  }

  Color getStatusColor(String status) {
    switch (status.toLowerCase()) {
      case 'cancel':
        return Colors.red;
      case 'complete':
        return Colors.blue;
      case 'active':
        return AppColors.primary;
      default:
        return AppColors.primary;
    }
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.sizeOf(context).width;

    return Container(
      width: double.infinity,
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
                    height: 28.h,
                    width: 28.w,
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      color: AppColors.subPrimary.withOpacity(.3),
                      border: Border.all(color: AppColors.primary),
                      borderRadius: BorderRadius.circular(3),
                    ),
                    child: CustomImage(
                      imageSrc: getIcon(detoxType),
                      height: 22.h,
                      width: 22.w,
                    ),
                  ),
                  SizedBox(width: 6.w),
                  SizedBox(
                    width: width < 390 ? 160.w : 200.w,
                    child: CustomText(
                      textAlign: TextAlign.left,
                      overflow: TextOverflow.ellipsis,
                      maxLines: 1,
                      text: title,
                      fontWeight: FontWeight.w600,
                      fontSize: 14.w,
                      color: AppColors.appTitle,
                      bottom: 0,
                      top: 0,
                    ),
                  ),
                ],
              ),

              // Status Badge
              Container(
                width: width < 390 ? 72.w : 80.w,
                padding: EdgeInsets.symmetric(horizontal: 4.w, vertical: 2.h),
                decoration: BoxDecoration(
                  color: getStatusColor(status).withOpacity(0.2),
                  borderRadius: BorderRadius.circular(5),
                  border: Border.all(color: getStatusColor(status)),
                ),
                child: CustomText(
                  text: "*$status",
                  fontSize: 12.w,
                  fontWeight: FontWeight.w500,
                  color: getStatusColor(status),
                  bottom: 0,
                  top: 0,
                ),
              ),
            ],
          ),

          SizedBox(height: 10.h),

          // Progress Text
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              CustomText(
                text: percentText,
                // text: "${(progress * 100).toInt()}% to complete",
                fontSize: 14.w,
                fontWeight: FontWeight.w500,
                color: AppColors.black,
                bottom: 0,
                top: 0,
              ),
              CustomText(
                text: dayCount,
                fontSize: 12.sp,
                fontWeight: FontWeight.w400,
                color: AppColors.softWhite,
                bottom: 0,
                top: 0,
              ),
            ],
          ),

          SizedBox(height: 8.h),

          // Progress Bar
          DottedProgressBar(progress: progress, height: 8.h, borderRadius: 4.r),

          SizedBox(height: 12.h),

          // Open Battle Button
          GestureDetector(
            onTap: onBattlePressed,
            child: Container(
              height: 36.h,
              width: 125.w,
              decoration: BoxDecoration(
                color: AppColors.subPrimary,
                borderRadius: BorderRadius.circular(8.r),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  CustomImage(imageSrc: AppIcons.battlePrimaryColor),
                  CustomText(
                    text: "Open Battle",
                    fontSize: 12.w,
                    fontWeight: FontWeight.w600,
                    color: AppColors.primary,
                    bottom: 0,
                    top: 0,
                  ),
                ],
              ),
            ),
          ),
          SizedBox(height: 16.h),
        ],
      ),
    );
  }
}

enum DetoxType { smoke, love, drugDetox, junkFood, shopping, socialMedia }

class DottedProgressBar extends StatelessWidget {
  final double progress; // 0.0 - 1.0
  final double height;
  final double borderRadius;
  final Color baseColor;
  final Color progressColor; // line color
  final int dotCount;
  final Color dotedColor;

  const DottedProgressBar({
    super.key,
    required this.progress,
    this.height = 8.0,
    this.borderRadius = 4.0,
    this.baseColor = AppColors.subPrimary,
    this.progressColor = AppColors.primary,
    this.dotedColor = AppColors.white,
    this.dotCount = 6,
  });

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final double totalWidth = constraints.maxWidth;

        //  dots white color হবে
        int whiteDots = (dotCount * progress).ceil();

        return Container(
          height: height.h,
          clipBehavior: Clip.hardEdge,
          decoration: BoxDecoration(
            color: baseColor.withOpacity(0.5),
            borderRadius: BorderRadius.circular(borderRadius.r),
          ),
          child: Stack(
            children: [
              // Progress Bar
              AnimatedContainer(
                duration: const Duration(milliseconds: 300),
                height: height.h,
                width: totalWidth * progress,
                decoration: BoxDecoration(color: progressColor),
              ),

              // Dots Overlay
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: List.generate(dotCount, (index) {
                  return Center(
                    child: Container(
                      width: 4.w, // circle width = height
                      height: 4.h, // circle height
                      decoration: BoxDecoration(
                        color: index < whiteDots ? dotedColor : progressColor,
                        shape: BoxShape.circle, // makes it circular
                      ),
                    ),
                  );
                }),
              ),
            ],
          ),
        );
      },
    );
  }
}
