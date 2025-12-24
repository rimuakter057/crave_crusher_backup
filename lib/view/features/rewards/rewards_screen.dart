import 'package:crave_crusher/utils/app_colors/app_colors.dart';
import 'package:crave_crusher/utils/app_icons/app_icons.dart';
import 'package:crave_crusher/view/components/common_empty/common_empty_widget.dart';
import 'package:crave_crusher/view/components/custom_container/custom_container.dart';
import 'package:crave_crusher/view/components/custom_image/custom_image.dart';
import 'package:crave_crusher/view/components/custom_leadin_title_appbar.dart';
import 'package:crave_crusher/view/components/custom_loader/custom_loader.dart';
import 'package:crave_crusher/view/components/custom_nav_bar/navbar.dart';
import 'package:crave_crusher/view/components/custom_network_image/custom_network_image.dart';
import 'package:crave_crusher/view/components/custom_text/custom_text.dart';
import 'package:crave_crusher/view/features/rewards/widgets/custom_circular_indicator.dart';
import 'package:crave_crusher/view/features/rewards/widgets/reward_color.dart';
import 'package:crave_crusher/view/features/rewards/widgets/shimmer_reward.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:shimmer/shimmer.dart';
import '../../../helper/imges_handler/image_handler.dart';
import 'controller/reward_controller.dart';
import 'package:get/get.dart';

class RewardsScreen extends StatefulWidget {
  const RewardsScreen({super.key});

  @override
  State<RewardsScreen> createState() => _RewardsScreenState();
}

class _RewardsScreenState extends State<RewardsScreen> {
  final RewardsController controller = Get.find<RewardsController>();

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      callMethode();
    });
  }

  callMethode() {
    controller.getBadgeProgress();
    controller.getAchieveBadges();
    controller.getAllBadges();
    controller.getClaimBadges();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: NavBar(currentIndex: 3),
      appBar: CustomLeadingTitleAppbar(title: "Reward"),

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
                    return SizedBox(
                        height: 100.h,

                        child: CustomLoader());
                  }

                  return CustomCircularIndicator(
                    percentText: "${controller.currentProgress.value}%",
                    percent: controller.currentProgress.value / 100,
                  );
                }),
              ),

              _buildGainedBadgeText(title: "Ongoing Progress "),

              Obx(() {
                final currentBadge = controller.currentBadge.value;
                final craveCount = controller.craveCount.value;
                final isLoading =
                    controller
                        .isLoadingProgress
                        .value; // create this in your controller

                if (isLoading) {
                  return RewardShimmerLoader();
                }

                if (currentBadge == null) {
                  return _buildEmptyWidget("No badge available");
                }

                // Data available
                final badgeImageUrl = ImageHandler.imagesHandle(
                  currentBadge.badgeImage,
                );
                final badgeName = currentBadge.name ?? "Loading...";
                final orderNumber = currentBadge.orderNumber.toString() ?? "00";

                return CustomContainer(
                  borderColor: AppColors.subPrimary,
                  width: double.infinity,
                  padding: 12,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      // Left side: badge
                      Row(
                        children: [
                          Container(
                            padding: EdgeInsets.all(4.w),
                            height: 30.h,
                            width: 30.w,
                            alignment: Alignment.center,
                            decoration: BoxDecoration(
                              color: getBadgeBgColor(badgeName),
                              border: Border.all(color: getBadgeBorderColor(badgeName),),
                              borderRadius: BorderRadius.circular(3),
                            ),
                            child: CustomNetworkImage(
                              imageUrl: badgeImageUrl,
                              height: 30.h,
                              width: 30.w,
                            ),
                          ),

                          Gap(8.w),
                          CustomText(
                            text: badgeName,
                            fontWeight: FontWeight.w500,
                            fontSize: 14.sp,
                          ),
                        ],
                      ),

                      // Right side: day / order
                      Row(
                        children: [
                          CustomImage(
                            imageSrc: AppIcons.alarm,
                            height: 12.h,
                            width: 12.w,
                          ),
                          Gap(8.w),
                          CustomText(
                            text: "Day $craveCount of $orderNumber",
                            fontWeight: FontWeight.w500,
                            fontSize: 14.sp,
                          ),
                        ],
                      ),
                    ],
                  ),
                );
              }),

              _buildGainedBadgeText(title: "Achieve Badges"),

              /// achieve badges section=================================================================================
              Obx(() {
                if (controller.isLoadingAchieveBadge.value) {
                  return RewardShimmerLoader();
                }

                var achieve = controller.allAchieveList;

                if (achieve.isEmpty) {
                  return
                    _buildEmptyWidget("achieve badges empty");
                }
                final isLoading = controller.isLoadingClaim.value;
                return ListView.separated(
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  itemCount: achieve.length,
                  separatorBuilder: (_, __) => SizedBox(height: 8.h),
                  itemBuilder: (context, index) {
                    final itemDetails = achieve[index];
                    final claimed =
                        controller.badgeStatus[itemDetails.id] ?? false;
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
                                    imageUrl: ImageHandler.imagesHandle(
                                      itemDetails.badgeImage,
                                    ),
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
                          GestureDetector(
                            onTap:
                                claimed || isLoading
                                    ? null
                                    : () async {
                                      bool success = await controller.claim(
                                        itemDetails.id,
                                      );
                                      if (!success) {
                                        Get.snackbar(
                                          "Error",
                                          "Failed to claim badge",
                                        );
                                      }
                                    },
                            child: Container(
                              height: 28.h,
                              width: 65.w,
                              decoration: BoxDecoration(
                                color:
                                    claimed ? Colors.grey : AppColors.primary,
                                borderRadius: BorderRadius.circular(4.r),
                              ),
                              alignment: Alignment.center,
                              child:
                                  isLoading
                                      ? SizedBox(
                                        width: 12.w,
                                        height: 12.h,
                                        child: CircularProgressIndicator(
                                          color: AppColors.white,
                                          strokeWidth: 2,
                                        ),
                                      )
                                      : Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceEvenly,
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
                          ),


                        ],
                      ),
                    );
                  },
                );
              }),

              ///gain badge category section
              _buildGainedBadgeText(title: "Gained Badges"),

              Obx(() {
                if (controller.isLoadingClaimBadge.value) {
                  return Center(
                    child: Shimmer.fromColors(
                      baseColor: Colors.grey[300]!,
                      highlightColor: Colors.grey[100]!,
                      child: Container(
                        width: double.infinity,
                        height: 40.h,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(6.r),
                          color: Colors.white,
                        ),
                      ),
                    ),
                  );
                }

                var claim = controller.allClaimList;

                if (claim.isEmpty) {
                  return _buildEmptyWidget("claim badges empty");
                }

                return SizedBox(
                  height: 82.h,
                  child: ListView.separated(
                    scrollDirection: Axis.horizontal,
                    itemCount: claim.length,
                    separatorBuilder: (_, __) => SizedBox(width: 12.w),
                    itemBuilder: (context, index) {
                      return CustomContainer(
                        width: 104.w,
                        height: 82.h,
                        backgroundColor: Colors.grey.shade100,
                        borderColor: AppColors.red,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            CustomNetworkImage(
                              imageUrl: ImageHandler.imagesHandle(
                                claim[index].badgeImage,
                              ),
                              height: 32.h,
                              width: 32.w,
                            ),
                            Gap(4.h),
                            CustomText(
                              text: claim[index].name ?? "",
                              fontSize: 10,
                            ),
                          ],
                        ),
                      );
                    },
                  ),
                );
              }),

              ///gain all badge details section====================================================================
              _buildGainedBadgeText(title: "All Badges"),

              /// all badges section=======================================================================================
              Obx(() {
                if (controller.isLoadingAllBadge.value) {
                  return RewardShimmerLoader();
                }

                var badge = controller.allBadgeList;

                if (badge.isEmpty) {
                  return EmptyWidget(title: "No badges found yet");
                }

                return ListView.separated(
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  itemCount: badge.length,
                  separatorBuilder: (_, __) => SizedBox(height: 8.h),
                  itemBuilder: (context, index) {
                    final allBadgeList = badge[index];
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
                                  padding: EdgeInsets.all(4.w),
                                  height: 30.h,
                                  width: 30.w,
                                  alignment: Alignment.center,
                                  decoration: BoxDecoration(
                                    color: getBadgeBgColor(allBadgeList.name),
                                    border: Border.all(
                                      color: getBadgeBorderColor(allBadgeList.name),
                                    ),
                                    borderRadius: BorderRadius.circular(3),
                                  ),
                                  child: CustomNetworkImage(
                                    imageUrl: ImageHandler.imagesHandle(
                                      allBadgeList.badgeImage,
                                    ),
                                    height: 22.h,
                                    width: 22.w,
                                  ),
                                ),

                                Gap(12.w),
                                CustomText(
                                  text: allBadgeList.name,
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
                                text: "Day ${allBadgeList.day}",
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

  ///build empty widget================================================================
  CustomContainer _buildEmptyWidget(final String title) {
    return CustomContainer(
      borderColor: AppColors.subPrimary,
      width: double.infinity,
      padding: 12,
      child: Center(
        child: CustomText(
          text: title,
          fontSize: 14.sp,
          fontWeight: FontWeight.w500,
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
        CustomText(text: title, fontSize: 14, fontWeight: FontWeight.w500),
        Gap(12.h),
      ],
    );
  }
}
