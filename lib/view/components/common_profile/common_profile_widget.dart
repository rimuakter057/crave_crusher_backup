import 'package:crave_crusher/utils/app_colors/app_colors.dart';
import 'package:crave_crusher/utils/app_icons/app_icons.dart';
import 'package:crave_crusher/view/components/custom_image/custom_image.dart';
import 'package:crave_crusher/view/components/custom_text/custom_text.dart';
import 'package:crave_crusher/view/screens/community/community_profile_screen/community_profile_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'avater_widget.dart';

class CommonProfileWidget extends StatelessWidget {
  const CommonProfileWidget({super.key, required this.title, required this.subTitle, required this.image, this.onTap});
final String title;
final String subTitle;
final String image;
final void Function() ?onTap;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Row(
        children: [

          ProfileAvatarWidget(imagePath: image,

          ),

          // CustomImage(
          //   imageSrc: image,
          //   // height: 24,
          //   //width: 24,
          // ),
          SizedBox(width: 16.w),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CustomText(
                text: title,
                fontWeight: FontWeight.w600,
                fontSize: 18.w,
                color: AppColors.black_02,
              ),
              CustomText(
                text: subTitle,
                fontWeight: FontWeight.w400,
                fontSize: 12.w,
                color: AppColors.softWhite,
              ),
            ],
          ),
        ],
      ),
    );
  }
}
