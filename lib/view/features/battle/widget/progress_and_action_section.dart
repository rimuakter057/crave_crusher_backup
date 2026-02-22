import 'package:crave_crusher/helper/responsive_helper/responsive_helper.dart';
import 'package:crave_crusher/utils/app_colors/app_colors.dart';
import 'package:crave_crusher/utils/app_icons/app_icons.dart';
import 'package:crave_crusher/view/components/custom_image/custom_image.dart';
import 'package:crave_crusher/view/components/custom_svg_icon/custom_svg_icon.dart';
import 'package:crave_crusher/view/components/custom_text/custom_text.dart';
import 'package:crave_crusher/view/features/battle/widget/active_battle_card.dart';
import 'package:flutter/material.dart';

class ProgressAndActionSection extends StatelessWidget {
  final double progress;
  final String dayCount;
  final String title;
  final VoidCallback onBattleLogPressed;
  //final VoidCallback onBattleNowPressed;

  const ProgressAndActionSection({
    super.key,
    required this.progress,
    required this.dayCount,
    required this.title,
    required this.onBattleLogPressed,

    // required this.onBattleNowPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(ResponsiveHelper.width(16)),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(ResponsiveHelper.borderRadius(12)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Title
          CustomText(
            text: "Your $title Battle Progress",
            fontWeight: FontWeight.w600,
            fontSize: ResponsiveHelper.fontSize(14),
            color: AppColors.appTitle,
            bottom: 0,
            top: 0,
          ),
          SizedBox(height: ResponsiveHelper.height(10)),

          Container(
            decoration: BoxDecoration(
              border: Border.all(color: AppColors.subPrimary),
            ),
            child: Padding(
              padding: EdgeInsets.all(ResponsiveHelper.width(8)),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      CustomText(
                        text: "${(progress * 100).toInt()}% to complete",
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        fontSize: ResponsiveHelper.fontSize(14),
                        fontWeight: FontWeight.w600,
                        color: AppColors.black,
                        bottom: 0,
                        top: 0,
                      ),

                      SizedBox(
                        width: ResponsiveHelper.width(82),
                        child: Row(
                          children: [
                            CustomSvgIcon(
                              icon: AppIcons.alarm,
                              height: ResponsiveHelper.height(12),
                              width: ResponsiveHelper.width(12),
                            ),

                            SizedBox(width: ResponsiveHelper.width(2)),
                            CustomText(
                              overflow: TextOverflow.ellipsis,
                              maxLines: 1,
                              text: dayCount, // e.g., Day 12 of 30
                              fontSize: ResponsiveHelper.fontSize(12),
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

                  SizedBox(height: ResponsiveHelper.height(12)),

                  // Progress Bar (using the existing DottedProgressBar)
                  DottedProgressBar(
                    progress: progress,
                    height: ResponsiveHelper.height(12),
                    borderRadius: ResponsiveHelper.borderRadius(5),
                  ),

                  SizedBox(height: ResponsiveHelper.height(20)),

                  // Buttons Row
                  Row(
                    children: [
                      // Battle Log Button
                      _buildActionButton(
                        boarderColor: AppColors.subPrimary,
                        text: "Battle Log",
                        iconSrc: AppIcons.calender,
                        bgColor: AppColors.subPrimary,
                        textColor: AppColors.primary,
                        onTap: onBattleLogPressed,
                        isPrimary: false,
                      ),
                      SizedBox(width: ResponsiveHelper.width(12)),

                      // Battle Now Button
                    ],
                  ),
                ],
              ),
            ),
          ),

          // SizedBox(height: 20.h),

          // _buildActionButton(
          //   boarderColor: boarderColor,
          //   text: buttonText ?? "Battle Now",
          //   iconSrc: iconSrc ?? AppIcons.battle,
          //   bgColor: bgColor ?? AppColors.primary,
          //   textColor: textColor ?? AppColors.white,
          //   onTap: onBattleNowPressed,
          //   isPrimary: true,
          // ),
        ],
      ),
    );
  }

  /// 🔹 Build action button
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
        height: ResponsiveHelper.height(36),
        width: ResponsiveHelper.width(130),
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: bgColor,
          borderRadius: BorderRadius.circular(ResponsiveHelper.borderRadius(8)),
          border: Border.all(color: boarderColor),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CustomImage(imageSrc: iconSrc, height: ResponsiveHelper.height(18)),
            SizedBox(width: ResponsiveHelper.width(8)),
            CustomText(
              text: text,
              fontSize: ResponsiveHelper.fontSize(12),
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
}
