import 'package:crave_crusher/helper/responsive_helper/responsive_helper.dart';
import 'package:crave_crusher/utils/app_colors/app_colors.dart';
import 'package:crave_crusher/view/components/custom_text/custom_text.dart';
import 'package:flutter/material.dart';

import 'avatar_widget.dart';

class CommonProfileWidget extends StatelessWidget {
  const CommonProfileWidget({
    super.key,
    required this.title,
    required this.subTitle,
    required this.profileImage,
    this.onTap,
  });
  final String title;
  final String subTitle;
  final String profileImage;
  final void Function()? onTap;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ProfileAvatarWidget(
            imagePath: profileImage,
            heightA: ResponsiveHelper.height(50),
            widthA: ResponsiveHelper.width(50),
          ),

          SizedBox(width: ResponsiveHelper.width(8)),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CustomText(
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                text: title,
                fontWeight: FontWeight.w600,
                fontSize: ResponsiveHelper.fontSize(14),
                color: AppColors.black_02,
              ),
              CustomText(
                text: subTitle,
                fontWeight: FontWeight.w400,
                fontSize: ResponsiveHelper.fontSize(12),
                color: AppColors.softWhite,
              ),
            ],
          ),
        ],
      ),
    );
  }
}
