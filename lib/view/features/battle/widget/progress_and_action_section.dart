import 'package:crave_crusher/utils/app_colors/app_colors.dart';
import 'package:crave_crusher/utils/app_icons/app_icons.dart';
import 'package:crave_crusher/view/components/custom_image/custom_image.dart';
import 'package:crave_crusher/view/components/custom_text/custom_text.dart';
import 'package:crave_crusher/view/features/battle/widget/active_battle_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ProgressAndActionSection extends StatelessWidget {
  final double progress;
  final String dayCount;
  final String title;
  final VoidCallback onBattleLogPressed;
  final VoidCallback onBattleNowPressed;
  final bool isActive;
  final String?buttonText;
  final Color? bgColor;
  final String?iconSrc;
  final Color boarderColor;
final Color?textColor;
  const ProgressAndActionSection({
    super.key,
    required this.progress,
    required this.dayCount,
    required this.title,
    required this.onBattleLogPressed,
    required this.onBattleNowPressed,
    required this.isActive,
     this.buttonText,
    this.textColor,
 this.bgColor,
   this.iconSrc,
   required this.boarderColor

  });

  Widget _buildActionButton({
    required Color boarderColor,
    required String text,
    required String iconSrc,
    required Color bgColor,
    required Color textColor,
    required VoidCallback onTap,
    bool isPrimary = false,
  }) {

    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: 36.h,
        width: 130.w,
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: bgColor,
          borderRadius: BorderRadius.circular(8.r),
          border: Border.all(color: boarderColor),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CustomImage(
              imageSrc: iconSrc,
              height: 18.h,
            ),
            SizedBox(width: 8.w),
            CustomText(
              text: text,
              fontSize: 12.sp,
              fontWeight: FontWeight.w600,
              color: textColor,
              bottom: 0,
              top: 0,
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Title
          CustomText(
            text: "Your $title Battle Progress",
            fontWeight: FontWeight.w600,
            fontSize: 14.sp,
            color: AppColors.appTitle,
            bottom: 0,
            top: 0,
          ),
          SizedBox(height: 10.h),

          // Progress Text (75% to complete)
          Container(
            decoration: BoxDecoration(
              border: Border.all(color: AppColors.subPrimary),
            ),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [

                   CustomText(
                          text: "${(progress * 100).toInt()}% to complete",
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          fontSize: 14.sp,
                          fontWeight: FontWeight.w600,
                          color: AppColors.black,
                          bottom: 0,
                          top: 0,
                        ),

                      SizedBox(
                        width:78.w,
                        child: Row(
                          children: [
                            Icon(
                              Icons.access_time,
                              size: 14.w,
                              color: AppColors.softWhite,
                            ),
                            SizedBox(width: 2.w),
                            CustomText(
                              overflow: TextOverflow.ellipsis,
                              maxLines: 1,
                              text: dayCount, // e.g., Day 12 of 30
                              fontSize: 12.sp,
                              fontWeight: FontWeight.w400,
                              color: AppColors.softWhite,
                              bottom: 0,
                              top: 0,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),

                  SizedBox(height: 8.h),

                  // Progress Bar (using the existing DottedProgressBar)
                  DottedProgressBar(
                    progress: progress,
                    height: 10.h,
                    borderRadius: 5.r,
                  ),

                  SizedBox(height: 20.h),

                  // Buttons Row
                  Row(
                    children: [
                      // Battle Log Button
                      _buildActionButton(
                        boarderColor:AppColors.subPrimary,
                        text: "Battle Log",
                        iconSrc: AppIcons.calender,
                        bgColor: AppColors.subPrimary,
                        textColor: AppColors.primary,
                        onTap: onBattleLogPressed,
                        isPrimary: false,
                      ),
                      SizedBox(width: 12.w),

                      // Battle Now Button
                    ],
                  ),
                ],
              ),
            ),
          ),

          SizedBox(height: 20.h),

          if(isActive)
          _buildActionButton(
            boarderColor:boarderColor,
            text:buttonText?? "Battle Now",
            iconSrc:iconSrc?? AppIcons.battle,
            bgColor:bgColor?? AppColors.primary,
            textColor:textColor?? AppColors.white,
            onTap: onBattleNowPressed,
            isPrimary: true,
          ),
        ],
      ),
    );
  }
}