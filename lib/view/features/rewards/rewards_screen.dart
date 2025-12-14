import 'package:crave_crusher/utils/app_colors/app_colors.dart';
import 'package:crave_crusher/utils/app_icons/app_icons.dart';
import 'package:crave_crusher/view/components/custom_container/custom_container.dart';
import 'package:crave_crusher/view/components/custom_image/custom_image.dart';
import 'package:crave_crusher/view/components/custom_leadin_title_appbar.dart';
import 'package:crave_crusher/view/components/custom_nav_bar/navbar.dart';
import 'package:crave_crusher/view/components/custom_netwrok_image/custom_network_image.dart';
import 'package:crave_crusher/view/components/custom_text/custom_text.dart';
import 'package:crave_crusher/view/features/rewards/widgets/custom_circular_indicator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import '../../../helper/imges_handler/image_handler.dart';
import 'controller/reward_controller.dart';
import 'data/battle_category_item_list.dart';
import 'data/battle_item_details_list.dart';
import 'package:get/get.dart';


class RewardsScreen extends StatefulWidget {
  const RewardsScreen({super.key});

  @override
  State<RewardsScreen> createState() => _RewardsScreenState();
}

class _RewardsScreenState extends State<RewardsScreen> {
  final RewardsController controller = Get.find<RewardsController>();



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: NavBar(currentIndex: 3),
      appBar:CustomLeadingTitleAppbar(title: "Reward") ,

      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ///show progress

              Center(
                child: Obx(() {
                  if (controller.isLoadingProgress.value) {
                    return CircularProgressIndicator();
                  }

                  return CustomCircularIndicator(
                    percentText: "${controller.currentProgress.value}%",
                    percent: controller.currentProgress.value / 100,
                  );
                }),
              ),

              _buildGainedBadgeText(title: "Ongoing Progress "),
              CustomContainer(
                borderColor: AppColors.subPrimary,
                width: double.infinity,
                padding: 12,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    ///focus fighter text
                    Row(
                      children: [
                        Container(
                          height: 30.h,
                          width: 30.w,
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                            color: Color(0xFFF7FEE7),
                            border: Border.all(color: Color(0xFF84CC16)),
                            borderRadius: BorderRadius.circular(3),
                          ),
                         //  child: CustomNetworkImage(
                         //
                         // imageUrl:  ImageHandler.imagesHandle(controller.currentBadge.value!.badgeImage),
                         //    height: 20.h,
                         //    width: 20.w,
                         //  ),
                         child:  CustomImage(
                            imageSrc: AppIcons.battlePng,
                            height: 22.h,
                            width: 22.w,
                          ),
                        ),
                        Gap(8.w),
                        CustomText(
                          text: "current badge",
                       //  text:controller.currentBadge.value.name,
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                        ),
                      ],
                    ),


                    Row(
                      children: [
                        CustomImage(
                          imageSrc: AppIcons.alarm,
                          height: 12.h,
                          width: 12.w,
                        ),
                        Gap(8.w),
                        CustomText(
                          text: "Day 3 of 10",
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                          color: Color(0xFFA1A1AA),
                        ),
                      ],
                    ),






                  ],
                ),
              ),
              _buildGainedBadgeText(title: "Achieve Badges"),
              /// achieve badges section=================================================================================
              Obx(() {
                if (controller.isLoadingAchieveBadge.value) {
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                }

                var achieve = controller.allAchieveList;

                if (achieve.isEmpty) {
                  return Center(
                    child: CustomText(text: "achieve badges empty"),
                  );
                }

                return ListView.separated(
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  itemCount: achieve.length,
                  separatorBuilder: (_, __) => SizedBox(height: 8.h),
                  itemBuilder: (context, index) {
                    final itemDetails = achieve[index];
                    final claimed = controller.badgeStatus[itemDetails.id] ?? false;
                    return CustomContainer(
                      borderColor: AppColors.subPrimary,
                      width: double.infinity,
                      padding: 12,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(
                            child: Row(
                              children: [
                                Container(
                                  height: 30.h,
                                  width: 30.w,
                                  alignment: Alignment.center,
                                  decoration: BoxDecoration(
                                    color: Colors.grey.shade100,
                                    border: Border.all(color: Colors.red),
                                    borderRadius: BorderRadius.circular(3),
                                  ),
                                  child: CustomNetworkImage(
                                    imageUrl: ImageHandler.imagesHandle(itemDetails.badgeImage),
                                    height: 20.h,
                                    width: 20.w,
                                  ),
                                ),
                                Gap(12.w),
                                CustomText(
                                  text: itemDetails.name,
                                  fontSize: 14,
                                  fontWeight: FontWeight.w500,
                                ),
                              ],
                            ),
                          ),

                        ///claim button======================================

                          // Claim Button
                          Obx(() {
                            final isLoading = controller.isLoadingClaim.value;

                            return GestureDetector(
                              onTap: claimed || isLoading
                                  ? null
                                  : () async {
                                bool success = await controller.claim(itemDetails.id);
                                if (!success) {
                                  Get.snackbar("Error", "Failed to claim badge");
                                }
                              },
                              child: Container(
                                height: 28.h,
                                width: 65.w,
                                decoration: BoxDecoration(
                                  color: claimed
                                      ? Colors.grey
                                      : AppColors.primary,
                                  borderRadius: BorderRadius.circular(4.r),
                                ),
                                alignment: Alignment.center,
                                child: isLoading
                                    ? SizedBox(
                                  width: 12.w,
                                  height: 12.h,
                                  child: CircularProgressIndicator(
                                    color: AppColors.white,
                                    strokeWidth: 2,
                                  ),
                                )
                                    : Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                  children: [
                                    CustomImage(
                                      imageSrc: AppIcons.claim,
                                      imageColor: AppColors.white,
                                      height: 12.h,
                                      width: 12.w,
                                    ),
                                    CustomText(
                                      text: "Claim",
                                      fontSize: 10.sp,
                                      fontWeight: FontWeight.w600,
                                      color: AppColors.white,
                                    ),
                                  ],
                                ),
                              ),
                            );
                          }),





                        ],
                      ),
                    );
                  },
                );
              }),

















              ///gain badge category section
              _buildGainedBadgeText(title: "Gained Badges"),

              SizedBox(
                height: 82.h,
                child: ListView.separated(
                  scrollDirection: Axis.horizontal,
                  itemCount: battleCategoryItems.length,
                  separatorBuilder: (_, __) => SizedBox(width: 12.w),
                  itemBuilder: (context, index) {
                    final item = battleCategoryItems[index];
                    return CustomContainer(
                      width: 104.w,
                      height: 82.h,
                      backgroundColor: item.backgroundColor,
                      borderColor: item.borderColor,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          CustomImage(
                            imageSrc: item.icon,
                            height: 32.h,
                            width: 32.w,
                          ),
                          Gap(4.h),
                          CustomText(text: item.title, fontSize: 10),
                        ],
                      ),
                    );
                  },
                ),
              ),

              ///gain badge details section====================================================================
              _buildGainedBadgeText(title: "All Badges"),
               /// all badges section=======================================================================================
              Obx(() {
                if (controller.isLoadingAllBadge.value) {
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                }

                var badge = controller.allBadgeList;

                if (badge.isEmpty) {
                  return Center(
                    child: CustomText(text: "No badges found"),
                  );
                }

                return ListView.separated(
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  itemCount: badge.length,
                  separatorBuilder: (_, __) => SizedBox(height: 8.h),
                  itemBuilder: (context, index) {
                    final itemDetails = badge[index];
                    return CustomContainer(
                      borderColor: AppColors.subPrimary,
                      width: double.infinity,
                      padding: 12,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(
                            child: Row(
                              children: [
                                Container(
                                  height: 30.h,
                                  width: 30.w,
                                  alignment: Alignment.center,
                                  decoration: BoxDecoration(
                                    color: Colors.grey.shade100,
                                    border: Border.all(color: Colors.red),
                                    borderRadius: BorderRadius.circular(3),
                                  ),
                                  child: CustomNetworkImage(
                                    imageUrl: ImageHandler.imagesHandle(itemDetails.badgeImage),
                                    height: 20.h,
                                    width: 20.w,
                                  ),
                                ),
                                Gap(12.w),
                                CustomText(
                                  text: itemDetails.name,
                                  fontSize: 14,
                                  fontWeight: FontWeight.w500,
                                ),
                              ],
                            ),
                          ),
                          Row(
                            children: [
                              Icon(
                                Icons.lock_outline,
                                size: 14,
                                color: Color(0xFFA1A1AA),
                              ),
                              Gap(4.w),
                              CustomText(
                                text: itemDetails.name,
                                fontSize: 12,
                                fontWeight: FontWeight.w500,
                                color: Color(0xFFA1A1AA),
                              ),
                            ],
                          ),
                        ],
                      ),
                    );
                  },
                );
              }),





            ],
          ),
        ),
      ),
    );
  }

  /// GainedBadgeText
  Column _buildGainedBadgeText({required String title}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Gap(24.h),
        CustomText(
          text: title,
          fontSize: 14,
          fontWeight: FontWeight.w500,
        ),
        Gap(12.h),
      ],
    );
  }
}
