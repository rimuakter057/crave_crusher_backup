import 'package:crave_crusher/utils/app_colors/app_colors.dart';
import 'package:crave_crusher/view/components/custom_image/custom_image.dart';
import 'package:crave_crusher/view/components/custom_text/custom_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class DetailsStatusButtonWidget extends StatelessWidget {
  final String text;
  final String iconSrc;
  final Color bgColor;
  final Color textColor;
  final VoidCallback onTap;
  final bool isPrimary;
  final Color? borderColor;

  const DetailsStatusButtonWidget({
    super.key,
    required this.text,
    required this.iconSrc,
    required this.bgColor,
    required this.textColor,
    required this.onTap,
    this.isPrimary = false,
    this.borderColor,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: 36.h,
        width: 130.w,
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: bgColor,
          borderRadius: BorderRadius.circular(8.r),
          border: Border.all(
            color: borderColor ?? AppColors.subPrimary,
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CustomImage(
              imageSrc: iconSrc,
              height: 18.h,
              width: 18.w,
              imageColor:
              isPrimary ? AppColors.white : AppColors.primary,
            ),
            SizedBox(width: 8.w),
            CustomText(
              text: text,
              fontSize: 12.sp,
              fontWeight: FontWeight.w600,
              color: textColor,
              top: 0,
              bottom: 0,
            ),
          ],
        ),
      ),
    );
  }
}
