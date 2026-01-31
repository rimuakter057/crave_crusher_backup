// ignore_for_file: deprecated_member_use

import 'package:crave_crusher/helper/responsive_helper/responsive_helper.dart';
import 'package:crave_crusher/utils/app_colors/app_colors.dart';
import 'package:crave_crusher/utils/app_icons/app_icons.dart';
import 'package:crave_crusher/view/components/common_empty/common_empty_widget.dart';
import 'package:crave_crusher/view/components/custom_image/custom_image.dart';
import 'package:crave_crusher/view/components/custom_nav_bar/navbar.dart';
import 'package:crave_crusher/view/components/custom_text/custom_text.dart';
import 'package:crave_crusher/view/features/battle/controller/battle_controller.dart';
import 'package:crave_crusher/view/features/battle/widget/active_battle_card.dart';
import 'package:crave_crusher/view/features/battle/widget/detox_type.dart';
import 'package:crave_crusher/view/features/battle/widget/shimmer_battle.dart';
import 'package:crave_crusher/view/features/home/controller/home_controller.dart';
import 'package:crave_crusher/view/features/home/widget/home_appbar.dart';
import 'package:crave_crusher/view/features/home/widget/home_monster_shimmer.dart';
import 'package:crave_crusher/view/features/home/widget/monster_section.dart';

import 'package:crave_crusher/view/features/profile/controllers/profile_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:shimmer/shimmer.dart';
import '../../components/custom_refresh_indicator/custom_refresh_indicator.dart';
import '../battle/inner_screen/battle_details_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final BattleController controller = Get.find<BattleController>();
  final ProfileController profileController = Get.find<ProfileController>();
  final HomeController homeController = Get.find<HomeController>();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      controller.battleTabIndex.value = 0;
      controller.fetchAllBattle();
      profileController.fetchMyProfile();
      homeController.getDailyTip();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: HomeAppbar(
        name: Obx(() {
          final profile = profileController.myProfile.value;
          return CustomText(
            textAlign: TextAlign.start,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            text: "Hello ${profile?.fullName ?? ""}",
            fontWeight: FontWeight.w600,
            fontSize: ResponsiveHelper.fontSize(18),
            color: AppColors.black_02,
          );
        }),
      ),
      body: CustomRefreshIndicator(
        onRefresh: () async {
          controller.fetchAllBattle();
          profileController.fetchMyProfile();
          homeController.getDailyTip();
        },
        child: SingleChildScrollView(
          padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.h),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              /// today tips===============================================================================================
              _buildTitle(AppIcons.i, "Tip for Today"),
              Obx(() {
                if (homeController.isLoadingTip.value) {
                  return Center(
                    child: Shimmer.fromColors(
                      baseColor: Colors.grey[300]!,
                      highlightColor: Colors.grey[100]!,
                      child: Container(
                        height: ResponsiveHelper.height(120), //  120,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(6.r),
                          color: Colors.white,
                        ),
                      ),
                    ),
                  );
                }

                return CustomImage(
                  fit: BoxFit.contain,
                  height: ResponsiveHelper.height(110),
                  width: double.infinity,
                  imageSrc: AppIcons.tipsBackground,
                  child: Padding(
                    padding: EdgeInsets.symmetric(
                      horizontal: ResponsiveHelper.width(16),
                    ),
                    child: CustomText(
                      text:
                          homeController.dailyTip.value.isNotEmpty
                              ? homeController.dailyTip.value
                              : '“ Each craving lasts only a few minutes — take slow, deep breaths and remind yourself why you started. ”',
                      maxLines: 5,
                      fontSize: ResponsiveHelper.fontSize(14),
                      textAlign: TextAlign.center,
                      color: AppColors.primary,
                    ),
                  ),
                );
              }),

              SizedBox(height: ResponsiveHelper.height(24),),

              // _buildTitle(AppIcons.smallMonster, "Your Monster Today"),
              Obx(() {
                final profile = profileController.myProfile.value;

                if (profileController.isLoadingMyProfile.value) {
                  return HomeMonsterShimmerLoader();
                }

                if (profile?.monster == null) {
                  return Center(
                    child: Column(
                      children: [
                        SizedBox(height:ResponsiveHelper.height(24),),
                        EmptyWidget(
                          title:
                              "Add your first battle to summon your Monster.",
                        ),
                      ],
                    ),
                  );
                } else {
                  return MonsterSection(
                    monster: profile?.monster?.monsterImage ?? "",
                    monsterMessage:
                        profile?.monster?.monsterMessage ??
                        "Your Monster Is Losing Power — Keep It Up!",
                  );
                }
              }),

              SizedBox(height:ResponsiveHelper.height(24),),

              // Active Battle Section Title
              _buildTitle(AppIcons.battlePng, "Active Battle"),

              Obx(() {
                if (controller.isLoadingAllBattle.value) {
                  return const Center(child: BattleShimmerLoader());
                } else if (controller.allBattleList.isEmpty) {
                  return Center(
                    child: Column(
                      children: [
                        SizedBox(height:ResponsiveHelper.height(48) ),
                        EmptyWidget(
                          title: "Add your first battle to get started.",
                        ),
                      ],
                    ),
                  );
                } else {
                  return ListView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: controller.allBattleList.length,
                    itemBuilder: (context, index) {
                      final battle = controller.allBattleList[index];
                      return Column(
                        children: [
                          ActiveBattleCard(
                            detoxType: checkDetoxType(
                              battle.addictionType ?? '',
                            ),
                            title: battle.addictionType.toString(),
                            percentText: "${battle.battleProgress}%",
                            progress: (battle.battleProgress ?? 0) / 100,
                            status: battle.todayStatus.toString(),
                            dayCount:
                                "Day ${battle.dayProgress} of ${battle.battleLength}",
                            onBattlePressed: () {
                              Get.to(
                                BattleDetailsScreen(
                                  isActive: true,
                                  battleId: battle.id.toString(),
                                  status: battle.todayStatus.toString(),
                                ),
                              );
                            },
                          ),
                          SizedBox(height: ResponsiveHelper.height(4)),
                        ],
                      );
                    },
                  );
                }
              }),
            ],
          ),
        ),
      ),

      bottomNavigationBar: NavBar(currentIndex: 0),
    );
  }

  Padding _buildTitle(String iconSrc, String title) {
    return Padding(
      padding: EdgeInsets.only(bottom:ResponsiveHelper.height(12) ),
      child: Row(
        children: [
          Container(
            height: ResponsiveHelper.height(28),
            width: ResponsiveHelper.width(28),
            alignment: Alignment.center,
            decoration: BoxDecoration(
              color: AppColors.subPrimary.withOpacity(.3),
              shape: BoxShape.circle,
              border: Border.all(color: AppColors.primary),
            ),
            child: CustomImage(
              imageSrc: iconSrc,
              height: ResponsiveHelper.height(16),
              width: ResponsiveHelper.width(16.w),
            ),
          ),
          SizedBox(width: ResponsiveHelper.width(8)),
          CustomText(
            text: title,
            fontWeight: FontWeight.w600,
            fontSize: ResponsiveHelper.fontSize(18),
          ),
        ],
      ),
    );
  }
}
