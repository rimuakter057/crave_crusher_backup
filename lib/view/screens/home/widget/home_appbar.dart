import 'package:crave_crusher/utils/app_colors/app_colors.dart';
import 'package:crave_crusher/utils/app_icons/app_icons.dart';
import 'package:crave_crusher/view/components/custom_image/custom_image.dart';
import 'package:crave_crusher/view/components/custom_text/custom_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class HomeAppbar extends StatelessWidget implements PreferredSizeWidget {
  const HomeAppbar({super.key, this.title, this.onNotificationTab});

  final String? title;
  final VoidCallback? onNotificationTab;

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: AppColors.backgroundColor,
      elevation: 0,
      title: Row(
        children: [
          const CustomImage(
            imageSrc: AppIcons.appLogoSmall, // Placeholder logo
            // height: 24,
            //width: 24,
          ),
          SizedBox(width: 8.w),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CustomText(
                text: "Hello ${title ?? "Sheena"}",
                fontWeight: FontWeight.w600,
                fontSize: 18.w,
                color: AppColors.black_02,
              ),
              CustomText(
                text: "Welcome to Crave Crusher",
                fontWeight: FontWeight.w400,
                fontSize: 12.w,
                color: AppColors.softWhite,
              ),
            ],
          ),
        ],
      ),
      actions: [
        Padding(
          padding: EdgeInsets.only(right: 16.w),
          child: Container(
            height: 36.h,
            width: 36.w,
            alignment: Alignment.center,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(width: .5, color: AppColors.primary),
            ),
            child: CustomImage(
              height: 24.h,
              width: 24.w,
              imageSrc: AppIcons.notification,
            ),
          ),
        ),
      ],
    );
  }

  @override
  // TO DO: implement preferredSize
  Size get preferredSize => Size.fromHeight(56.h);
}
