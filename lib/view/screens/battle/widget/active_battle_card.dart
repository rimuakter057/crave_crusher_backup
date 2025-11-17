// ignore_for_file: deprecated_member_use, unused_local_variable

import 'package:crave_crusher/utils/app_colors/app_colors.dart';
import 'package:crave_crusher/utils/app_icons/app_icons.dart';
import 'package:crave_crusher/view/components/custom_image/custom_image.dart';
import 'package:crave_crusher/view/components/custom_text/custom_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ActiveBattleCard extends StatelessWidget {
  //final String iconSrc;
  final String title;
  final double progress;
  final String status;
  final String dayCount;
  final Color statusColor;
  final DetoxType detoxType;
  final VoidCallback? onBattlePressed;

  const ActiveBattleCard({
    super.key,
    // required this.iconSrc,
    required this.title,
    required this.progress,
    required this.status,
    required this.dayCount,
    required this.statusColor,
    required this.detoxType,
    this.onBattlePressed,
  });

  String getIcon() {
    switch (detoxType) {
      case DetoxType.smoke:
        return AppIcons.smoke;
      case DetoxType.love:
        return AppIcons.toxicRelationshipe;
      case DetoxType.savingMoney:
        return AppIcons.savingsMoney;
      case DetoxType.junkFood:
        return AppIcons.junkFood;
      case DetoxType.shopping:
        return AppIcons.shopping;
      case DetoxType.socialMedia:
        return AppIcons.socialMedia;
    }
  }

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
                      imageSrc: getIcon(),
                      height: 22.h,
                      width: 22.w,
                    ),
                  ),
                  SizedBox(width: 10.w),
                  CustomText(
                    overflow: TextOverflow.ellipsis,
                    maxLines: 1,
                    text: title,
                    fontWeight: FontWeight.w600,
                    fontSize: 12,
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
                  borderRadius: BorderRadius.circular(5),
                  border: Border.all(color: statusColor),
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
          DottedProgressBar(
            progress: progress, // eta 0.0 theke 1.0 er modhye value
            height: 8.h,
            borderRadius: 4.r,
          ),

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

          // CustomButton(
          //   onTap: () {}, // Logic will be implemented here
          //   title: "Open Battle",
          //   height: 35.h,
          //   width: 150.w, // Fixed width for button
          //   fillColor: AppColors.subPrimary,
          //   textColor: AppColors.primary,
          //   borderRadius: 8,
          //   fontSize: 14.w,
          //   fontWeight: FontWeight.w600,
          // ),
        ],
      ),
    );
  }
}

enum DetoxType { smoke, love, savingMoney, junkFood, shopping, socialMedia }

// DottedProgressBar widget apnar Figma design-er moto custom progress bar toiri kore.
// Eta LinearProgressIndicator-er upor choto choto shada dot add kore.
class DottedProgressBar extends StatelessWidget {
  final double progress; // 0.0 theke 1.0
  final double height;
  final double borderRadius;
  final Color baseColor;
  final Color progressColor;
  final int dotCount; // Koyta dot thakbe

  const DottedProgressBar({
    super.key,
    required this.progress,
    this.height = 8.0,
    this.borderRadius = 4.0,
    this.baseColor = AppColors.subPrimary, // DDE3FA
    this.progressColor = AppColors.primary, // 6C63FF
    this.dotCount = 6, // Total 6 ta dot design-e dekha jacche
  });

  @override
  Widget build(BuildContext context) {
    // LayoutBuilder byabohar kora hoche jate progress bar-er total available width jana jay.
    return LayoutBuilder(
      builder: (context, constraints) {
        final double totalWidth = constraints.maxWidth;
        // Dot er modhye shoman space dewar jonno dot spacing calculation
        // Total width ke (dotCount - 1) diye bhag kora hoy jate shurute o sheshe dot thake na
        // ebong dot gulo shoman vabe bishojjito hoy.
        final double dotSpacing = totalWidth / (dotCount - 1);

        return Container(
          height: height.h,
          clipBehavior: Clip.hardEdge,
          decoration: BoxDecoration(
            color: baseColor.withOpacity(0.5),
            borderRadius: BorderRadius.circular(borderRadius.r),
          ),
          child: Stack(
            children: [
              // --- 1. Progress Indicator (Blue Solid Bar) ---
              // AnimatedContainer byabohar kora hoy smooth transition-er jonno
              AnimatedContainer(
                duration: const Duration(milliseconds: 300),
                height: height.h,
                width: totalWidth * progress,
                decoration: BoxDecoration(
                  color: progressColor,
                  // Progress bar er modhye ar border radius dewar dorkar nei,
                  // karon eta Container-er opore clip hobe
                ),
              ),

              // --- 2. Dots Overlay (Shada Diamond/Rectangle Dots) ---
              // Progress bar-er puro width জুড়ে dot gulo toiri kora
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: List.generate(dotCount, (index) {
                  return Container(
                    height: height.h,
                    alignment: Alignment.center,
                    child: Container(
                      width: 2.0.w, // Dot-er thickness (design er moto)
                      height: (height * 0.7).h, // Dot-er height
                      decoration: BoxDecoration(
                        color: AppColors.white, // Dot color shada
                        borderRadius: BorderRadius.circular(
                          1.0.r,
                        ), // Choto rectangle/diamond shape
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
