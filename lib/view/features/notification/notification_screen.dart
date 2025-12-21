

import 'package:crave_crusher/utils/app_colors/app_colors.dart';
import 'package:crave_crusher/utils/app_const/app_const.dart';
import 'package:crave_crusher/utils/app_images/app_images.dart';
import 'package:crave_crusher/view/components/common_empty/common_empty_widget.dart';
import 'package:crave_crusher/view/components/custom_image/custom_image.dart';
import 'package:crave_crusher/view/components/custom_leadin_title_appbar.dart';
import 'package:crave_crusher/view/components/custom_loader/custom_loader.dart';
import 'package:crave_crusher/view/components/custom_refresh_indicator/custom_refresh_indicator.dart';
import 'package:crave_crusher/view/components/custom_text/custom_text.dart';
import 'package:crave_crusher/view/features/home/controller/home_controller.dart';
import 'package:crave_crusher/view/features/notification/widgets/notification_tile_widget.dart';
import 'package:crave_crusher/view/features/rewards/widgets/custom_circular_indicator.dart';
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
      backgroundColor: AppColors.backgroundColor,
      appBar: CustomLeadingTitleAppbar(title: "Notification"),
      body: CustomRefreshIndicator(
        onRefresh: ()async{
          controller.currentPage.value = 1;
          await controller.fetchNotificationList(isRefresh: true);
        },
        child: Obx(() {
          // Loading state
          if (controller.isLoadingNotification.value) {
            return CustomLoader();
          }

          // Empty state
          if (controller.notificationList.isEmpty) {
            return EmptyWidget(title: "No notification yet");
          }
          return ListView.separated(
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
                  trailing:IconButton(onPressed: (){
                    controller.deleteNotification(notification.id!);
                  }, icon: Icon(
                    Icons.close,
                    color: AppColors.primary,
                    size: 24,
                  ),),



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
          );
        }),
      ),
    );
  }
}





