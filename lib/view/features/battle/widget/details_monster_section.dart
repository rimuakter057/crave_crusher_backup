// ignore_for_file: deprecated_member_use

import 'package:crave_crusher/helper/imges_handler/image_handler.dart';
import 'package:crave_crusher/utils/app_colors/app_colors.dart';
import 'package:crave_crusher/utils/app_icons/app_icons.dart';
import 'package:crave_crusher/view/components/custom_image/custom_image.dart';
import 'package:crave_crusher/view/components/custom_text/custom_text.dart';
import 'package:crave_crusher/view/features/battle/widget/active_battle_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../components/custom_network_image/custom_network_image.dart';

class DetailsMonsterSection extends StatelessWidget {
  // Battle details to display in the header
  final String battleTitle;
  final String battleDescription;
  final String status;
  final String monsterStatusMessage;
 final DetoxType detoxType;
 final String monster;
  const DetailsMonsterSection({
    super.key,
    required this.battleTitle,
    required this.battleDescription,
    required this.status,
    required this.monsterStatusMessage,
    required this.detoxType,
    required this.monster,
  });


  String getIcon( DetoxType detoxType) {
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
        // Battle Header (Icon, Title, Status)
        Padding(
          padding: EdgeInsets.only(bottom: 16.h),
          child: Container(
            padding: EdgeInsets.all(8.w),
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
                      height: 40.h,
                      width: 40.w,
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        color: AppColors.subPrimary.withOpacity(.3),
                        borderRadius: BorderRadius.circular(3.r),
                        border: Border.all(color: AppColors.subPrimary),
                      ),
                      child: CustomImage(
                        imageSrc: getIcon(detoxType), // Small monster avatar
                        height: 36.h,
                        width: 36.w,
                      ),
                    ),
                    SizedBox(width: 8.w),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        CustomText(
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          textAlign: TextAlign.start,
                          text: battleTitle,
                          fontWeight: FontWeight.w600,
                          fontSize: 14.sp,
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
                  padding: EdgeInsets.symmetric(horizontal: 2.w, vertical: 2.h),
                  decoration: BoxDecoration(
                    color: AppColors.subPrimary.withOpacity(
                      0.3,
                    ), // Using subPrimary as a placeholder color
                    borderRadius: BorderRadius.circular(5),
                    border: Border.all(color: AppColors.primary),
                  ),
                  child: CustomText(
                    text: "• $status",
                    fontSize: 11.w,
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
          child:

          CustomNetworkImage(
            imageUrl: ImageHandler.imagesHandle( monster),
              height: 250.h,
              width: 250.w,
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
