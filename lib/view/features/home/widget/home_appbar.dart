import 'package:crave_crusher/utils/app_colors/app_colors.dart';
import 'package:crave_crusher/utils/app_icons/app_icons.dart';
import 'package:crave_crusher/view/components/custom_image/custom_image.dart';
import 'package:crave_crusher/view/components/custom_text/custom_text.dart';
import 'package:crave_crusher/view/features/notification/notification_screen.dart';
import 'package:crave_crusher/view/features/profile/controllers/profile_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class HomeAppbar extends StatelessWidget implements PreferredSizeWidget {
  HomeAppbar({super.key, this.onNotificationTab});
  final ProfileController profileController = Get.find<ProfileController>();

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

              Obx(() {
                final profile = profileController.myProfile.value;

                return SizedBox(
                  width: 200.w,
                  child: CustomText(
                    textAlign: TextAlign.start,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    text: "Hello ${profile?.fullName ?? "Empty Name"}",
                    fontWeight: FontWeight.w600,
                    fontSize: 18.w,
                    color: AppColors.black_02,
                  ),
                );

              }),

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
        GestureDetector(
          onTap: (){
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => NotificationScreen()),
            );
          },
          child: Padding(
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
        ),
      ],
    );
  }

  @override
  // TO DO: implement preferredSize
  Size get preferredSize => Size.fromHeight(56.h);
}
