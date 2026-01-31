import 'package:crave_crusher/helper/responsive_helper/responsive_helper.dart';
import 'package:crave_crusher/utils/app_colors/app_colors.dart';
import 'package:crave_crusher/utils/app_icons/app_icons.dart';
import 'package:crave_crusher/view/components/custom_image/custom_image.dart';
import 'package:crave_crusher/view/components/custom_text/custom_text.dart';
import 'package:crave_crusher/view/features/notification/notification_screen.dart';
import 'package:crave_crusher/view/features/profile/controllers/profile_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HomeAppbar extends StatelessWidget implements PreferredSizeWidget {
  HomeAppbar({super.key, this.onNotificationTab, required this.name});

  final Widget name;
  final ProfileController profileController = Get.find<ProfileController>();
  final VoidCallback? onNotificationTab;

  @override
  Widget build(BuildContext context) {
    // Initialize responsive helper
    ResponsiveHelper.init(context);

    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: ResponsiveHelper.isTablet ? 16.0 : 0,
      ),
      child: AppBar(
        backgroundColor: AppColors.backgroundColor,
        elevation: 0,
        toolbarHeight: ResponsiveHelper.height(56),
        title: Row(
          children: [
            CustomImage(
              imageSrc: AppIcons.appLogoSmall,
              height: ResponsiveHelper.iconSize(24),
              width: ResponsiveHelper.iconSize(24),
            ),
            SizedBox(width: ResponsiveHelper.spacing(8)),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  SizedBox(width: ResponsiveHelper.width(200), child: name),
                  CustomText(
                    text: "Welcome to Crave Crusher",
                    fontWeight: FontWeight.w400,
                    fontSize: ResponsiveHelper.fontSize(12),
                    color: AppColors.softWhite,
                    textAlign: TextAlign.start,
                  ),
                ],
              ),
            ),
          ],
        ),
        actions: [
          GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const NotificationScreen(),
                ),
              );
            },
            child: Padding(
              padding: EdgeInsets.only(
                right: ResponsiveHelper.isTablet ? 24.0 : 16.0,
              ),
              child: Container(
                height: ResponsiveHelper.iconSize(36),
                width: ResponsiveHelper.iconSize(36),
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(
                    width: ResponsiveHelper.borderWidth(0.5),
                    color: AppColors.primary,
                  ),
                ),
                child: CustomImage(
                  height: ResponsiveHelper.iconSize(24),
                  width: ResponsiveHelper.iconSize(24),
                  imageSrc: AppIcons.notification,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  @override
  Size get preferredSize {
    final context = Get.context;
    if (context != null) {
      ResponsiveHelper.init(context);
      return Size.fromHeight(ResponsiveHelper.height(56));
    }
    return const Size.fromHeight(56);
  }
}

// import 'package:crave_crusher/utils/app_colors/app_colors.dart';
// import 'package:crave_crusher/utils/app_icons/app_icons.dart';
// import 'package:crave_crusher/view/components/custom_image/custom_image.dart';
// import 'package:crave_crusher/view/components/custom_text/custom_text.dart';
// import 'package:crave_crusher/view/features/notification/notification_screen.dart';
// import 'package:crave_crusher/view/features/profile/controllers/profile_controller.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:get/get.dart';

// class HomeAppbar extends StatelessWidget implements PreferredSizeWidget {
//   HomeAppbar({super.key, this.onNotificationTab, required this.name});
//   final Widget name;
//   final ProfileController profileController = Get.find<ProfileController>();

//   final VoidCallback? onNotificationTab;

//   @override
//   Widget build(BuildContext context) {
//     return AppBar(
//       backgroundColor: AppColors.backgroundColor,
//       elevation: 0,
//       title: Row(
//         children: [
//           const CustomImage(
//             imageSrc: AppIcons.appLogoSmall, // Placeholder logo
//             // height: 24,
//             //width: 24,
//           ),
//           SizedBox(width: 8.w),
//           Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               // Obx(() {
//               //   final profile = profileController.myProfile.value;
//               //
//               //   return SizedBox(
//               //     width: 200.w,
//               //     child: CustomText(
//               //       textAlign: TextAlign.start,
//               //       maxLines: 1,
//               //       overflow: TextOverflow.ellipsis,
//               //       text: "Hello $name",
//               //       fontWeight: FontWeight.w600,
//               //       fontSize: 18.w,
//               //       color: AppColors.black_02,
//               //     ),
//               //   );
//               //
//               // }),
//               SizedBox(width: 200.w, child: name),

//               CustomText(
//                 text: "Welcome to Crave Crusher",
//                 fontWeight: FontWeight.w400,
//                 fontSize: 12.w,
//                 color: AppColors.softWhite,
//               ),
//             ],
//           ),
//         ],
//       ),
//       actions: [
//         GestureDetector(
//           onTap: () {
//             Navigator.push(
//               context,
//               MaterialPageRoute(builder: (context) => NotificationScreen()),
//             );
//           },
//           child: Padding(
//             padding: EdgeInsets.only(right: 16.w),
//             child: Container(
//               height: 36.h,
//               width: 36.w,
//               alignment: Alignment.center,
//               decoration: BoxDecoration(
//                 shape: BoxShape.circle,
//                 border: Border.all(width: .5, color: AppColors.primary),
//               ),
//               child: CustomImage(
//                 height: 24.h,
//                 width: 24.w,
//                 imageSrc: AppIcons.notification,
//               ),
//             ),
//           ),
//         ),
//       ],
//     );
//   }

//   @override
//   // TO DO: implement preferredSize
//   Size get preferredSize => Size.fromHeight(56.h);
// }
