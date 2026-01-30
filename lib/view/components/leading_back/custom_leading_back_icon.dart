import 'package:crave_crusher/helper/responsive_helper/responsive_helper.dart';
import 'package:crave_crusher/utils/app_colors/app_colors.dart';
import 'package:crave_crusher/utils/app_icons/app_icons.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class LeadingBackIconWidget extends StatelessWidget {
  const LeadingBackIconWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: () {
        Navigator.pop(context);
      },
      icon: SvgPicture.asset(
        AppIcons.backButton, // আপনার svg path
        colorFilter: ColorFilter.mode(AppColors.primary, BlendMode.srcIn),
        width: ResponsiveHelper.width(20), // 20.w,
        height: ResponsiveHelper.height(20), // 20.h,
      ),
    );
  }
}
