

import 'package:crave_crusher/utils/app_colors/app_colors.dart';
import 'package:crave_crusher/utils/app_const/app_const.dart';
import 'package:crave_crusher/utils/app_images/app_images.dart';
import 'package:crave_crusher/view/components/custom_image/custom_image.dart';
import 'package:crave_crusher/view/components/custom_leadin_title_appbar.dart';
import 'package:crave_crusher/view/components/custom_text/custom_text.dart';
import 'package:crave_crusher/view/features/home/controller/home_controller.dart';
import 'package:crave_crusher/view/features/notification/widgets/notification_tile_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';


import 'package:crave_crusher/utils/app_colors/app_colors.dart';
import 'package:crave_crusher/utils/app_images/app_images.dart';
import 'package:crave_crusher/view/components/custom_image/custom_image.dart';
import 'package:crave_crusher/view/components/custom_leadin_title_appbar.dart';
import 'package:crave_crusher/view/features/home/controller/home_controller.dart';
import 'package:crave_crusher/view/features/notification/widgets/notification_tile_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class NotificationScreen extends StatefulWidget {
  const NotificationScreen({super.key});

  @override
  State<NotificationScreen> createState() => _NotificationScreenState();
}

class _NotificationScreenState extends State<NotificationScreen> {
  final HomeController controller = Get.find<HomeController>();

  final ScrollController scrollController = ScrollController();






  @override
  Widget build(BuildContext context) {
    // Pagination scroll listener
    scrollController.addListener(() {
      if (scrollController.position.pixels ==
          scrollController.position.maxScrollExtent) {
        // Load next page if exists
        controller.fetchNextPageNotifications();
      }
    });




    return Scaffold(
      appBar: CustomLeadingTitleAppbar(title: "Notification"),
      body: Obx(() {
        // Initial loading
        if (controller.isLoadingNotification.value &&
            controller.notificationList.isEmpty) {
          return Center(child: CircularProgressIndicator());
        }

        // Error state
        if (controller.notificationStatus.value == Status.error &&
            controller.notificationList.isEmpty) {
          return Center(child: Text("Failed to load notifications"));
        }

        return RefreshIndicator(
          onRefresh: () async {
            controller.currentPage.value = 1;
            await controller.fetchNotificationList(isRefresh: true);
          },
          child: ListView.separated(
            controller: scrollController,
            padding: EdgeInsets.symmetric(vertical: 12.h),
            itemCount: controller.notificationList.length + 1,
            separatorBuilder: (context, index) => SizedBox(height: 12.h),
            itemBuilder: (context, index) {
              if (index < controller.notificationList.length) {
                final notification = controller.notificationList[index];
                return NotificationTileWidget(
                  title: notification.title ?? "empty title",
                  subtitle: notification.message ?? "",
                  leading: Container(
                    width: 40.w,
                    height: 40.h,
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      color: AppColors.subPrimary.withOpacity(.3),
                      shape: BoxShape.circle,
                      border: Border.all(color: AppColors.subPrimary),
                    ),
                    child: CustomImage(
                      imageSrc: AppImages.appLogo,
                      height: 24.h,
                      width: 27.w,
                      fit: BoxFit.cover,
                    ),
                  ),
                  trailing: Icon(
                    Icons.close,
                    color: AppColors.primary,
                    size: 24,
                  ),
                );
              } else {
                // Bottom loader for pagination
                return Obx(() {
                  return controller.isLoadingNotification.value &&
                      controller.currentPage.value > 1
                      ? Padding(
                    padding: EdgeInsets.symmetric(vertical: 8.h),
                    child: LinearProgressIndicator(
                      color: AppColors.primary,
                      minHeight: 3,
                    ),
                  )
                      : SizedBox();
                });
              }
            },
          ),
        );
      }),
    );
  }
}





//
// class NotificationScreen extends StatelessWidget {
//   const NotificationScreen({super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: CustomLeadingTitleAppbar(title: "Notification"),
//
//       body: ListView.separated(
//         itemCount: 16,
//         separatorBuilder: (context,index){return SizedBox(height: 12.h,);},
//         itemBuilder: (context,index){
//
//           return NotificationTileWidget(
//
//             title: "New Badge Earned",
//             subtitle: "Congratulations! You’ve unlocked a new badge for your dedication and progress. Check your Rewards tab to view your achievement.",
//             leading: Container(
//               width: 40.w,
//               height: 40.h,
//               alignment: Alignment.center,
//               decoration: BoxDecoration(
//                 color: AppColors.subPrimary.withOpacity(.3),
//                 shape: BoxShape.circle,
//                 border: Border.all(color: AppColors.subPrimary),
//               ),
//               child: CustomImage(
//                 imageSrc: AppImages.appLogo,
//                 height: 24.h,
//                 width: 27.w,
//                 fit: BoxFit.cover,
//               ),
//             ),
//
//             trailing: Icon(Icons.close,color: AppColors.primary,size: 24,),
//
//
//           );
//
//
//         },  ),
//
//     );
//   }
// }