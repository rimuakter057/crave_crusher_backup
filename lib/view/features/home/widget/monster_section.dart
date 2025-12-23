// ignore_for_file: deprecated_member_use

import 'package:crave_crusher/helper/imges_handler/image_handler.dart';
import 'package:crave_crusher/utils/app_colors/app_colors.dart';
import 'package:crave_crusher/utils/app_icons/app_icons.dart';
import 'package:crave_crusher/view/components/custom_image/custom_image.dart';
import 'package:crave_crusher/view/components/custom_network_image/custom_network_image.dart';
import 'package:crave_crusher/view/components/custom_text/custom_text.dart';
import 'package:crave_crusher/view/features/profile/controllers/profile_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class MonsterSection extends StatelessWidget {

final String monster;
final String monsterMessage;
   const MonsterSection({super.key, required this.monster, required this.monsterMessage,});

 // final ProfileController profileController = Get.find<ProfileController>();
  @override
  Widget build(BuildContext context) {

      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [

          Center(
            child: CustomNetworkImage(
                imageUrl: ImageHandler.imagesHandle(monster),
                height: 300.h,
                width: 286.w
            ),
          ),
          SizedBox(height: 8),
          Container(
            height: 52.h,
            width: double.maxFinite,
            alignment: Alignment.center,
            decoration: BoxDecoration(
              color: AppColors.softGreen,
              borderRadius: BorderRadius.circular(8),
              border: Border.all(color: AppColors.green),
            ),
            child: CustomText(
              text:monsterMessage,
              fontWeight: FontWeight.w600,
              fontSize: 14.w,
              color: AppColors.green,
              maxLines: 2,
            ),
          ),
        ],
      );

  }
}
