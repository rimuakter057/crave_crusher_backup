import 'package:crave_crusher/helper/responsive_helper/responsive_helper.dart';
import 'package:flutter/material.dart';
import '../../../utils/app_colors/app_colors.dart';
import '../custom_text/custom_text.dart';

class CustomButton extends StatelessWidget {
  const CustomButton({
    super.key,
    this.height,
    this.width = double.maxFinite,
    required this.onTap,
    this.title = '',
    this.marginVertical = 0,
    this.marginHorizontal = 0,
    this.fillColor = AppColors.primary,
    this.textColor = AppColors.white,
    this.isBorder = false,
    this.fontSize,
    this.borderWidth,
    this.borderRadius,
    this.fontWeight,
  });

  final double? height;
  final double? width;
  final Color? fillColor;
  final Color textColor;
  final VoidCallback onTap;
  final String title;
  final double marginVertical;
  final double marginHorizontal;
  final bool isBorder;
  final double? fontSize;
  final double? borderWidth;
  final double? borderRadius;
  final FontWeight? fontWeight;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.symmetric(vertical: ResponsiveHelper.height(5)),
        margin: EdgeInsets.symmetric(
          vertical: marginVertical,
          horizontal: marginHorizontal,
        ),
        alignment: Alignment.center,
        height: height ?? ResponsiveHelper.height(40),
        width: width,
        decoration: BoxDecoration(
          border:
              isBorder
                  ? Border.all(color: textColor, width: borderWidth ?? .05)
                  : null,
          borderRadius: BorderRadius.circular(
            borderRadius ?? ResponsiveHelper.borderRadius(6),
          ),
          color: fillColor,
        ),
        child: CustomText(
          fontSize: fontSize ?? ResponsiveHelper.fontSize(14),
          fontWeight: fontWeight ?? FontWeight.w600,
          color: textColor,
          textAlign: TextAlign.center,
          text: title,
        ),
      ),
    );
  }
}
