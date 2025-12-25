import 'package:crave_crusher/utils/app_colors/app_colors.dart';
import 'package:crave_crusher/utils/app_icons/app_icons.dart';
import 'package:crave_crusher/view/components/custom_image/custom_image.dart';
import 'package:crave_crusher/view/components/custom_text/custom_text.dart';
import 'package:crave_crusher/view/components/leading_back/custom_leading_back_icon.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final Widget? leading;
  final Color? backgroundColor;
  final double elevation;
  final List<Widget>? actions;
  final String? actionIcon;
  final VoidCallback? onActionPressed;

  const CustomAppBar({
    super.key,
    required this.title,
    this.leading,
    this.backgroundColor,
    this.elevation = 0.0,
    this.actions,
    this.actionIcon,
    this.onActionPressed,
  });

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16.0.w),
      child: AppBar(
        surfaceTintColor: backgroundColor ?? AppColors.backgroundColor,
        backgroundColor: backgroundColor ?? AppColors.backgroundColor,
        elevation: elevation,
        leading: Center(
          child: Container(
            width: 50.w,
            height: 50.h,
            alignment: Alignment.center,
            decoration: BoxDecoration(
              color: AppColors.subPrimary.withOpacity(.3),
              shape: BoxShape.circle,
              border: Border.all(color: AppColors.subPrimary),
            ),
            child: leading ??
              LeadingBackIconWidget(),

      ),
        ),
        centerTitle: true,
        title: CustomText(
          text: title,
          fontSize: 18.sp,
          fontWeight: FontWeight.w500,
        ),
        actions:
            actions ??
            [
              GestureDetector(
                onTap: onActionPressed,
                child: Container(
                  width: 50.w,
                  height: 50.h,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    color: AppColors.subPrimary.withOpacity(.3),
                    shape: BoxShape.circle,
                    border: Border.all(color: AppColors.subPrimary),
                  ),
                  child: CustomImage(
                    imageSrc: actionIcon ?? AppIcons.add,
                    height: 20.h,
                    width: 20.w,
                  ),
                ),
              ),
            ],
      ),
    );
  }
}


