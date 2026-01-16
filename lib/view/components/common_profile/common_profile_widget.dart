import 'package:crave_crusher/utils/app_colors/app_colors.dart';
import 'package:crave_crusher/view/components/custom_text/custom_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

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
            heightA: 50.h,
            widthA: 50.w,
          ),

          SizedBox(width: 8.w),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CustomText(
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                text: title,
                fontWeight: FontWeight.w600,
                fontSize: 14.sp,
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
