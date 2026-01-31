// ignore_for_file: deprecated_member_use

import 'package:crave_crusher/helper/responsive_helper/responsive_helper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../utils/app_colors/app_colors.dart';
import 'custom_text/custom_text.dart';
import 'leading_back/custom_leading_back_icon.dart';

class CustomLeadingTitleAppbar extends StatelessWidget
    implements PreferredSizeWidget {
  final String title;
  final VoidCallback? onBack;
  final Color? titleColor;
  const CustomLeadingTitleAppbar({
    super.key,
    required this.title,
    this.titleColor,
    this.onBack,
  });

  @override
  Widget build(BuildContext context) {
    return AppBar(
      surfaceTintColor: AppColors.backgroundColor,
      backgroundColor: AppColors.backgroundColor,
      centerTitle: true,

      leading: Center(
        child: Container(
          width: ResponsiveHelper.width(50),
          height:ResponsiveHelper.height(50),
          alignment: Alignment.center,
          decoration: BoxDecoration(
            color: AppColors.subPrimary.withOpacity(.3),
            shape: BoxShape.circle,
            border: Border.all(color: AppColors.subPrimary),
          ),
          child: LeadingBackIconWidget(),
        ),
      ),

      title: CustomText(
        text: title,
        fontSize: ResponsiveHelper.fontSize(18),
        color: titleColor ?? Color(0xFF1E1E1E),
        fontWeight: FontWeight.w500,
      ),
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(ResponsiveHelper.height(60),);
}
