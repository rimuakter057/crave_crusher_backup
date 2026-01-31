// ignore_for_file: deprecated_member_use

import 'package:crave_crusher/helper/images_handler/image_handler.dart';
import 'package:crave_crusher/helper/responsive_helper/responsive_helper.dart';
import 'package:crave_crusher/utils/app_colors/app_colors.dart';
import 'package:crave_crusher/view/components/custom_network_image/custom_network_image.dart';
import 'package:crave_crusher/view/components/custom_text/custom_text.dart';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class MonsterSection extends StatelessWidget {
  final String monster;
  final String monsterMessage;
  const MonsterSection({
    super.key,
    required this.monster,
    required this.monsterMessage,
  });

  // final ProfileController profileController = Get.find<ProfileController>();
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Center(
          child: CustomNetworkImage(
            imageUrl: ImageHandler.imagesHandle(monster),
            height: ResponsiveHelper.height(300),
            width: ResponsiveHelper.width(286),
          ),
        ),
        SizedBox(height: ResponsiveHelper.height(8)),
        Container(
          height: ResponsiveHelper.height(52),
          width: double.maxFinite,
          alignment: Alignment.center,
          decoration: BoxDecoration(
            color: AppColors.softGreen,
            borderRadius: BorderRadius.circular(ResponsiveHelper.borderRadius(8)),
            border: Border.all(color: AppColors.green),
          ),
          child: CustomText(
            text: monsterMessage,
            fontWeight: FontWeight.w600,
            fontSize: ResponsiveHelper.fontSize(14),
            color: AppColors.green,
            maxLines: 2,
          ),
        ),
      ],
    );
  }
}
