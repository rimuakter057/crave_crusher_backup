// ignore_for_file: file_names

import 'package:crave_crusher/utils/app_colors/app_colors.dart';
import 'package:crave_crusher/view/components/custom_image/custom_image.dart';
import 'package:crave_crusher/view/components/custom_text/custom_text.dart';
import 'package:flutter/material.dart';

import '../../../../helper/responsive_helper/responsive_helper.dart'
    show ResponsiveHelper;

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
        height: ResponsiveHelper.height(36),
        width: ResponsiveHelper.width(130),
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: bgColor,
          borderRadius: BorderRadius.circular(ResponsiveHelper.borderRadius(8)),
          border: Border.all(color: borderColor ?? AppColors.subPrimary),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CustomImage(
              imageSrc: iconSrc,
              height: ResponsiveHelper.height(18),
              width: ResponsiveHelper.width(18),
              imageColor: isPrimary ? AppColors.white : AppColors.primary,
            ),
            SizedBox(width: ResponsiveHelper.width(18)),
            CustomText(
              text: text,
              fontSize: ResponsiveHelper.fontSize(12),
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
