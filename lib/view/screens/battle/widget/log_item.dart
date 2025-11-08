// ignore_for_file: deprecated_member_use

import 'package:crave_crusher/utils/app_colors/app_colors.dart';
import 'package:crave_crusher/utils/app_icons/app_icons.dart';
import 'package:crave_crusher/view/components/custom_image/custom_image.dart';
import 'package:crave_crusher/view/components/custom_text/custom_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

enum LogType {
  // Successful action/avoided craving (The 'sword/cross' icon in green border)
  success,
  // Failed to avoid craving/caved in (The 'monster/devil' icon in red border)
  caved,
}

/// A dynamic component for displaying a single log entry in the Battle Log list.
class LogEntryItem extends StatelessWidget {
  final LogType type;
  final int dayNumber;
  final String statusText;
  final String timestamp;

  const LogEntryItem({
    super.key,
    required this.type,
    required this.dayNumber,
    required this.statusText,
    required this.timestamp,
  });

  // Dynamic colors and icons based on LogType
  Color get _primaryColor {
    return type == LogType.success
        ? AppColors.green.withAlpha(50)
        : AppColors.red.withAlpha(50);
  }

  Color get _borderColor {
    return type == LogType.success
        ? AppColors.green.withAlpha(90)
        : AppColors.red.withAlpha(90);
  }

  String get icon {
    // Apnar chobi anujayi icon use kora holo
    return type == LogType.success
        ? AppIcons
            .battle // Swords icon er jonno placeholder
        : AppIcons.smallMonster; // Monster/Devil icon er jonno placeholder
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(bottom: 12.h),
      child: Container(
        padding: EdgeInsets.all(12.w),
        decoration: BoxDecoration(
          color: AppColors.white,
          borderRadius: BorderRadius.circular(10.r),
          border: Border.all(color: AppColors.subPrimary, width: 1.w),
          // boxShadow: [
          //   BoxShadow(
          //     color: AppColors.black.withOpacity(0.05),
          //     blurRadius: 4,
          //     offset: const Offset(0, 2),
          //   ),
          // ],
        ),
        child: Row(
          children: [
            // --- Icon and Border Container ---
            Container(
              width: 48.w,
              height: 48.h,
              decoration: BoxDecoration(
                color: _primaryColor.withOpacity(0.1),
                borderRadius: BorderRadius.circular(8.r),
                border: Border.all(color: _borderColor, width: 1.w),
              ),
              child: Center(child: CustomImage(imageSrc: icon)),
            ),

            SizedBox(width: 12.w),

            // --- Day and Status Text ---
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CustomText(
                    text: 'Day $dayNumber',
                    fontWeight: FontWeight.w600,
                    fontSize: 16,
                    color: AppColors.appTitle,
                  ),
                  CustomText(
                    text: statusText,
                    fontWeight: FontWeight.w500,
                    fontSize: 13,
                    color: AppColors.softWhite, // Status color depends on type
                  ),
                ],
              ),
            ),

            // --- Timestamp ---
            Row(
              children: [
                Icon(Icons.history, size: 12, color: AppColors.subPrimary),
                SizedBox(width: 5.w),
                CustomText(
                  text: timestamp,
                  fontWeight: FontWeight.w400,
                  fontSize: 12,
                  color: AppColors.softWhite,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
