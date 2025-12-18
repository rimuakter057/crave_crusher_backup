import 'package:crave_crusher/utils/app_icons/app_icons.dart';
import 'package:crave_crusher/view/components/custom_image/custom_image.dart';
import 'package:crave_crusher/view/components/custom_text/custom_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
class EmptyWidget extends StatelessWidget {
  const EmptyWidget({
    super.key, required this.title,
  });
  final String title;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CustomImage(
          imageSrc: AppIcons.emptyHome,
          height: 41.h,
          width: 64.w,
          boxFit: BoxFit.cover,
        ),
        SizedBox(height: 24.h),
        SizedBox(
          width: 272.w,
          child: CustomText(
            text: title,
            maxLines: 2,
            fontSize: 16.sp,
            fontWeight: FontWeight.w400,
          ),
        ),
      ],
    );
  }
}