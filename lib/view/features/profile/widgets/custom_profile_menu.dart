import 'package:crave_crusher/utils/app_colors/app_colors.dart';
import 'package:crave_crusher/utils/app_icons/app_icons.dart';
import 'package:crave_crusher/view/components/custom_svg_icon/custom_svg_icon.dart';
import 'package:crave_crusher/view/components/custom_text/custom_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';

class CustomProfileMenu extends StatelessWidget {
  const CustomProfileMenu({
    super.key,
    required this.text,
    required this.onTap,
    this.textColor,
    this.iconColor,
    required this.icon,
  });
  final String text;

  final void Function() onTap;
  final Color? textColor;
  final Color? iconColor;
  final String icon;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.all(12.w),
        decoration: BoxDecoration(
          border: Border.all(color: Colors.grey.shade200), // Grey border
          borderRadius: BorderRadius.circular(8), // Rounded corners (optional)
        ),

        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                IconTheme(
                  data: IconThemeData(
                    size: 24, // auto size for any icon
                    color: iconColor ?? AppColors.primary, // auto color
                  ),
                  child: CustomSvgIcon(icon: icon),
                ),

                Gap(18.w),

                CustomText(text: text, color: textColor ?? AppColors.primary),
              ],
            ),

            CustomSvgIcon(icon: AppIcons.arrowFront),
          ],
        ),
      ),
    );
  }
}
