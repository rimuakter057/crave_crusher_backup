// ignore_for_file: deprecated_member_use

import 'package:crave_crusher/helper/images_handler/image_handler.dart';
import 'package:crave_crusher/helper/responsive_helper/responsive_helper.dart';
import 'package:crave_crusher/utils/app_colors/app_colors.dart';
import 'package:crave_crusher/utils/app_icons/app_icons.dart';
import 'package:crave_crusher/view/components/custom_image/custom_image.dart';
import 'package:crave_crusher/view/components/custom_text/custom_text.dart';
import 'package:crave_crusher/view/features/battle/widget/active_battle_card.dart';
import 'package:flutter/material.dart';
import '../../../components/custom_network_image/custom_network_image.dart';

class DetailsMonsterSection extends StatelessWidget {
  // Battle details to display in the header
  final String battleTitle;
  final String battleDescription;
  final String status;
  final String monsterStatusMessage;
  final DetoxType detoxType;
  final String monster;
  final Color bgColor;
  final Color textColor;
  final Color boarderColor;

  const DetailsMonsterSection({
    super.key,
    required this.battleTitle,
    required this.battleDescription,
    required this.status,
    required this.monsterStatusMessage,
    required this.detoxType,
    required this.monster,
    required this.bgColor,
    required this.textColor,
    required this.boarderColor,
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

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.only(bottom: ResponsiveHelper.height(12)),
          child: Container(
            decoration: BoxDecoration(
              color: AppColors.white,
              borderRadius: BorderRadius.circular(
                ResponsiveHelper.borderRadius(12),
              ),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                // Icon, Title, and Description
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      height: ResponsiveHelper.height(40),
                      width: ResponsiveHelper.width(40),
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        color: AppColors.subPrimary.withOpacity(.3),
                        borderRadius: BorderRadius.circular(
                          ResponsiveHelper.borderRadius(3),
                        ),
                        border: Border.all(color: AppColors.subPrimary),
                      ),
                      child: CustomImage(
                        imageSrc: getIcon(detoxType), // Small monster avatar
                        height: ResponsiveHelper.height(36),
                        width: ResponsiveHelper.width(36),
                      ),
                    ),
                    SizedBox(width: ResponsiveHelper.width(8)),
                    SizedBox(
                      width: ResponsiveHelper.width(150),

                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          CustomText(
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            textAlign: TextAlign.start,
                            text: battleTitle,
                            fontWeight: FontWeight.w600,
                            fontSize: ResponsiveHelper.fontSize(14),
                            color: AppColors.appTitle,
                            bottom: 0,
                            top: 0,
                          ),

                          CustomText(
                            textAlign: TextAlign.start,
                            text: battleDescription,
                            fontWeight: FontWeight.w400,
                            fontSize: ResponsiveHelper.fontSize(12),
                            color: AppColors.softWhite,
                            maxLines: 4,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                // Status Badge
                Container(
                  padding: EdgeInsets.symmetric(
                    horizontal: ResponsiveHelper.width(2),
                    vertical: ResponsiveHelper.height(2),
                  ),
                  decoration: BoxDecoration(
                    color: bgColor,
                    // Using subPrimary as a placeholder color
                    borderRadius: BorderRadius.circular(
                      ResponsiveHelper.borderRadius(5),
                    ),
                    border: Border.all(color: boarderColor),
                  ),
                  child: CustomText(
                    text: "• $status",
                    fontSize: ResponsiveHelper.fontSize(11),
                    fontWeight: FontWeight.w500,
                    color: textColor,
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
          child: CustomNetworkImage(
            imageUrl: ImageHandler.imagesHandle(monster),
            height: ResponsiveHelper.height(250),
            width: ResponsiveHelper.width(250),
          ),
        ),
        SizedBox(height: ResponsiveHelper.height(24)),

        // Monster Status Container
        Container(
          height: ResponsiveHelper.height(52),
          width: double.maxFinite,
          alignment: Alignment.center,
          padding: EdgeInsets.symmetric(horizontal: ResponsiveHelper.width(16)),
          decoration: BoxDecoration(
            color: AppColors.softGreen, // Light Green
            borderRadius: BorderRadius.circular(
              ResponsiveHelper.borderRadius(8),
            ),
            border: Border.all(color: AppColors.green),
          ),
          child: CustomText(
            text: monsterStatusMessage,
            fontWeight: FontWeight.w600,
            fontSize: ResponsiveHelper.fontSize(14),
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
