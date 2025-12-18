

import 'package:crave_crusher/utils/app_colors/app_colors.dart';
import 'package:crave_crusher/utils/app_icons/app_icons.dart';
import 'package:crave_crusher/utils/app_images/app_images.dart';
import 'package:crave_crusher/view/components/common_empty/common_empty_widget.dart';
import 'package:crave_crusher/view/components/custom_image/custom_image.dart';
import 'package:crave_crusher/view/components/custom_loader/custom_loader.dart';
import 'package:crave_crusher/view/components/custom_nav_bar/navbar.dart';
import 'package:crave_crusher/view/components/custom_text/custom_text.dart';
import 'package:crave_crusher/view/features/battle/controller/battle_controller.dart';
import 'package:crave_crusher/view/features/battle/widget/active_battle_card.dart';
import 'package:crave_crusher/view/features/battle/widget/detox_type.dart';
import 'package:crave_crusher/view/features/home/widget/home_appbar.dart';
import 'package:crave_crusher/view/features/home/widget/monster_section.dart';
import 'package:crave_crusher/view/features/home/widget/today_tips.dart';
import 'package:crave_crusher/view/features/profile/controllers/profile_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../battle/inner_screen/battle_details_screen.dart';

class HomeScreen extends StatefulWidget {
   const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final BattleController controller = Get.find<BattleController>();
  final ProfileController profileController = Get.find<ProfileController>();
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      controller.fetchAllBattle('active');
      profileController.fetchMyProfile();
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: HomeAppbar(

      ),
      body: RefreshIndicator(
        onRefresh: () async {
          controller.fetchAllBattle('active');
        },
        child: SingleChildScrollView(
          padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.h),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Tip and Monster Section
              TodayTips(),
              MonsterSection(image:AppIcons.happyMonstar),

              SizedBox(height: 24.h),

              // Active Battle Section Title
              Padding(
                padding: EdgeInsets.only(bottom: 12.h),
                child: Row(
                  children: [
                    Container(
                      height: 28.h,
                      width: 28.w,
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        color: AppColors.subPrimary.withOpacity(.3),
                        shape: BoxShape.circle,
                        border: Border.all(color: AppColors.primary),
                      ),
                      child: CustomImage(

                        imageSrc: AppIcons.battlePng,

                        height: 16.h,
                        width: 16.w,
                      ),
                    ),
                    SizedBox(width: 8.w),
                    CustomText(
                      text: "Active Battle",
                      fontWeight: FontWeight.w600,
                      fontSize: 18,
                    ),
                  ],
                ),
              ),





              Obx(() {
                if (controller.isLoadingAllBattle.value) {
                  return const Center(child: CustomLoader());
                } else if (controller.allBattleList.isEmpty) {
                  return   Center(
                    child: EmptyWidget(
                      title: "Add your first battle to get started.",
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
                            detoxType: checkDetoxType(battle.addictionType??''),
                            title: battle.addictionType.toString(),
                            percentText: "${battle.battleProgress}%",
                            progress: 0.58,
                            status: battle.battleStatus.toString(),
                            dayCount: "Day ${battle.day} of 30",
                            onBattlePressed: () {
                              Get.to(BattleDetailsScreen(battleId: battle.id.toString()));
                            },
                          ),
                          SizedBox(height: 4.h,),

                        ],
                      );
                    },
                  );
                }
              })





















            ],
          ),
        ),
      ),

      bottomNavigationBar: NavBar(currentIndex: 0),
    );
  }
}





// SOLID Principle (SRP): Ei widget-ti shudhu Tip o Monster UI render korar kaaj korche.

// SOLID Principle (OCP, ISP): Highly reusable component with minimal, necessary parameters.