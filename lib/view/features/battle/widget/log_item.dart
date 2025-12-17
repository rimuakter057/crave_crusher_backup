// ignore_for_file: deprecated_member_use

import 'package:crave_crusher/utils/app_colors/app_colors.dart';
import 'package:crave_crusher/utils/app_icons/app_icons.dart';
import 'package:crave_crusher/view/components/custom_image/custom_image.dart';
import 'package:crave_crusher/view/components/custom_text/custom_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

enum LogType {
  craved,
  caved,
  missed
}


LogType getLogTypeFromStatus(String status) {
  switch (status.toLowerCase()) {
    case 'craved':
      return LogType.craved;
    case 'caved':
      return LogType.caved;
    case 'missed':
      return LogType.missed;
    default:
      return LogType.missed; // fallback
  }
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

  Color get _primaryColor {
    switch (type) {
      case LogType.craved:
        return AppColors.green.withAlpha(50);
      case LogType.caved:
        return AppColors.red.withAlpha(50);
      case LogType.missed:
        return Colors.grey.withAlpha(50);
    }
  }

  Color get _borderColor {
    switch (type) {
      case LogType.craved:
        return AppColors.green.withAlpha(90);
      case LogType.caved:
        return AppColors.red.withAlpha(90);
      case LogType.missed:
        return Colors.grey.withAlpha(90);
    }
  }

  String get icon {
    switch (type) {
      case LogType.craved:
        return AppIcons.battlePng;
      case LogType.caved:
        return AppIcons.smallMonster;
      case LogType.missed:
        return AppIcons.missed;
    }
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
        ),
        child: Row(
          children: [
            // Icon container
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

            // Day + Status
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
                    color: AppColors.softWhite,
                  ),
                ],
              ),
            ),

            // Timestamp
            Row(
              children: [
                Icon(Icons.history, size: 12, color: AppColors.softWhite),
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
