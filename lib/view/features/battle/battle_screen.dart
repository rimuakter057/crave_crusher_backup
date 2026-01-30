import 'package:crave_crusher/core/routes/app_routes.dart';
import 'package:crave_crusher/view/components/common_empty/common_empty_widget.dart';
import 'package:crave_crusher/view/components/custom_app_bar/custom_app_bar.dart';
import 'package:crave_crusher/view/components/custom_nav_bar/navbar.dart';
import 'package:crave_crusher/view/components/custom_refresh_indicator/custom_refresh_indicator.dart';
import 'package:crave_crusher/view/features/battle/controller/battle_controller.dart';
import 'package:crave_crusher/view/features/battle/inner_screen/battle_details_screen.dart';
import 'package:crave_crusher/view/features/battle/widget/battle_tab_selector.dart';
import 'package:crave_crusher/view/features/battle/widget/active_battle_card.dart';
import 'package:crave_crusher/view/features/battle/widget/detox_type.dart';
import 'package:crave_crusher/view/features/battle/widget/shimmer_battle.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class BattleScreen extends StatefulWidget {
  const BattleScreen({super.key});

  @override
  State<BattleScreen> createState() => _BattleScreenState();
}

class _BattleScreenState extends State<BattleScreen> {
  final BattleController controller = Get.find<BattleController>();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      // Initial fetch based on current tab
      _fetchBattleByTab(controller.battleTabIndex.value);

      // Listen to tab changes
      ever(controller.battleTabIndex, (int index) {
        _fetchBattleByTab(index);
      });
    });
  }

  void _fetchBattleByTab(int index) {
    switch (index) {
      case 0:
        controller.fetchAllBattle();
        break;
      case 1:
        controller.fetchAllBattle();
        break;
      case 2:
        controller.fetchAllBattle();
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: ,
      appBar: CustomAppBar(
        title: 'My Battle',
        onActionPressed: () {
          Get.toNamed(AppRoutes.createBattleScreen);
        },
      ),

      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 16.0.w),
        child: Obx(() {
          return Column(
            children: [
              SizedBox(height: 16.h),
              BattleTabSelector(),

              SizedBox(height: 10.h),

              if (controller.battleTabIndex.value == 0) ...[
                Expanded(
                  child: CustomRefreshIndicator(
                    onRefresh: () async {
                      _fetchBattleByTab(controller.battleTabIndex.value);
                    },
                    child:
                        controller.isLoadingAllBattle.value
                            ? const BattleShimmerLoader()
                            : controller.allBattleList.isEmpty
                            ? EmptyWidget(
                              title:
                                  "You don’t have any active battles right now.",
                            )
                            : ListView.builder(
                              physics: const AlwaysScrollableScrollPhysics(),
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
                                      progress:
                                          (battle.battleProgress ?? 0) / 100,
                                      status:
                                          battle.todayStatus?.toString() ?? '',
                                      dayCount:
                                          "Day ${battle.dayProgress} of ${battle.battleLength}",
                                      onBattlePressed: () {
                                        Get.to(
                                          () => BattleDetailsScreen(
                                            battleId: battle.id.toString(),
                                            isActive: true,
                                            status:
                                                battle.todayStatus.toString(),
                                          ),
                                        );
                                      },
                                    ),
                                    SizedBox(height: 4.h),
                                  ],
                                );
                              },
                            ),
                  ),
                ),
              ],

              if (controller.battleTabIndex.value == 1) ...[
                Expanded(
                  child: CustomRefreshIndicator(
                    onRefresh: () async {
                      _fetchBattleByTab(controller.battleTabIndex.value);
                    },
                    child:
                        controller.isLoadingAllBattle.value
                            ? const BattleShimmerLoader()
                            : controller.allBattleList.isEmpty
                            ? EmptyWidget(
                              title:
                                  "You don’t have any completed battles right now.",
                            )
                            : ListView.builder(
                              physics: const AlwaysScrollableScrollPhysics(),
                              itemCount: controller.allBattleList.length,
                              itemBuilder: (context, index) {
                                final battle = controller.allBattleList[index];

                                return Column(
                                  children: [
                                    ActiveBattleCard(
                                      detoxType: checkDetoxType(
                                        battle.addictionType ?? '',
                                      ),
                                      title: battle.addictionType ?? "",
                                      percentText: "${battle.battleProgress}%",
                                      progress:
                                          (battle.battleProgress ?? 0) / 100,
                                      status: battle.battleStatus.toString(),
                                      dayCount:
                                          "Day ${battle.dayProgress} of ${battle.battleLength} ",
                                      onBattlePressed: () {
                                        Get.to(
                                          BattleDetailsScreen(
                                            battleId: battle.id.toString(),
                                            isActive: false,
                                            status:
                                                battle.battleStatus.toString(),
                                          ),
                                        );
                                      },
                                    ),
                                    SizedBox(height: 4.h),
                                  ],
                                );
                              },
                            ),
                  ),
                ),
              ],

              if (controller.battleTabIndex.value == 2) ...[
                Expanded(
                  child: CustomRefreshIndicator(
                    onRefresh: () async {
                      _fetchBattleByTab(controller.battleTabIndex.value);
                    },
                    child:
                        controller.isLoadingAllBattle.value
                            ? const BattleShimmerLoader()
                            : controller.allBattleList.isEmpty
                            ? EmptyWidget(
                              title:
                                  "You don’t have any canceled battles right now.",
                            )
                            : ListView.builder(
                              physics: const AlwaysScrollableScrollPhysics(),
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
                                      progress:
                                          (battle.battleProgress ?? 0) / 100,
                                      status: battle.battleStatus.toString(),
                                      dayCount:
                                          "Day ${battle.dayProgress} of ${battle.battleLength}",
                                      onBattlePressed: () {
                                        Get.to(
                                          BattleDetailsScreen(
                                            battleId: battle.id.toString(),
                                            isActive: false,
                                            status:
                                                battle.battleStatus.toString(),
                                          ),
                                        );
                                      },
                                    ),
                                    SizedBox(height: 4.h),
                                  ],
                                );
                              },
                            ),
                  ),
                ),
              ],
            ],
          );
        }),
      ),

      bottomNavigationBar: NavBar(currentIndex: 1),
    );
  }
}
