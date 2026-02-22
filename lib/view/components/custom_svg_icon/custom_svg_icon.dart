import 'package:crave_crusher/helper/responsive_helper/responsive_helper.dart';
import 'package:crave_crusher/utils/app_colors/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class CustomSvgIcon extends StatelessWidget {
  const CustomSvgIcon({super.key, required this.icon, this.height, this.width});

  final String icon;
  final double? height;
  final double? width;

  @override
  Widget build(BuildContext context) {
    return SvgPicture.asset(
      icon, // svg icon path
      width: width ?? ResponsiveHelper.width(20),
      height: height ?? ResponsiveHelper.height(20),
      colorFilter: ColorFilter.mode(AppColors.primary, BlendMode.srcIn),
    );
  }
}
