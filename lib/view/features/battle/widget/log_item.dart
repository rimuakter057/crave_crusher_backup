// ignore_for_file: deprecated_member_use

import 'package:crave_crusher/helper/responsive_helper/responsive_helper.dart';
import 'package:crave_crusher/utils/app_colors/app_colors.dart';
import 'package:crave_crusher/utils/app_icons/app_icons.dart';
import 'package:crave_crusher/view/components/custom_image/custom_image.dart';
import 'package:crave_crusher/view/components/custom_text/custom_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

enum LogType { craved, caved, missed }

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
  final int countCaved;
  final int countCraved;
  //final String timestamp;

  const LogEntryItem({
    super.key,
    required this.type,
    required this.dayNumber,

    required this.countCraved,
    // required this.timestamp,
    required this.countCaved,
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
        return AppIcons.correct;
      case LogType.caved:
        return AppIcons.smallMonster;
      case LogType.missed:
        return AppIcons.missed;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(bottom: ResponsiveHelper.height(12)),
      child: Container(
        padding: EdgeInsets.all(ResponsiveHelper.width(12)),
        decoration: BoxDecoration(
          color: AppColors.white,
          borderRadius: BorderRadius.circular(10.r),
          border: Border.all(
            color: AppColors.subPrimary,
            width: ResponsiveHelper.width(1),
          ),
        ),
        child: Row(
          children: [
            // Icon container
            Container(
              width: ResponsiveHelper.width(48),
              height: ResponsiveHelper.height(48),
              decoration: BoxDecoration(
                color: _primaryColor.withOpacity(0.1),
                borderRadius: BorderRadius.circular(
                  ResponsiveHelper.borderRadius(8),
                ),
                border: Border.all(
                  color: _borderColor,
                  width: ResponsiveHelper.width(1),
                ),
              ),
              child: Center(child: CustomImage(imageSrc: icon)),
            ),
            SizedBox(width: ResponsiveHelper.width(12)),

            // Day + Status
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      CustomText(
                        text: 'Day $dayNumber',
                        fontWeight: FontWeight.w600,
                        fontSize: ResponsiveHelper.fontSize(16),
                        color: AppColors.appTitle,
                      ),

                      // Timestamp
                      // Row(
                      //   children: [
                      //     CustomSvgIcon(icon: AppIcons.alarm, height: 12.h, width: 12.w),
                      //     SizedBox(width: 5.w),
                      //     CustomText(
                      //       text: timestamp,
                      //       fontWeight: FontWeight.w400,
                      //       fontSize: 12,
                      //       color: AppColors.softWhite,
                      //     ),
                      //   ],
                      // ),
                    ],
                  ),
                  SizedBox(height: ResponsiveHelper.height(4)),
                  Row(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          CustomText(
                            text: "Caved",
                            fontWeight: FontWeight.w500,
                            fontSize: ResponsiveHelper.fontSize(12),
                            color: AppColors.softWhite,
                          ),
                          SizedBox(width: ResponsiveHelper.width(4)),

                          CustomText(
                            text: countCaved.toString(),
                            fontWeight: FontWeight.w500,
                            fontSize: ResponsiveHelper.fontSize(12),
                            color: AppColors.softWhite,
                          ),
                        ],
                      ),
                      SizedBox(
                        height: ResponsiveHelper.height(10),
                        child: VerticalDivider(
                          color: AppColors.softWhite,
                          thickness: 1,
                        ),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          CustomText(
                            text: "Craved",
                            fontWeight: FontWeight.w500,
                            fontSize: ResponsiveHelper.fontSize(12),
                            color: AppColors.softWhite,
                          ),
                          SizedBox(width: ResponsiveHelper.width(4)),

                          CustomText(
                            text: countCraved.toString(),

                            fontWeight: FontWeight.w500,
                            fontSize: ResponsiveHelper.fontSize(12),
                            color: AppColors.softWhite,
                          ),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
