import 'package:crave_crusher/core/routes/app_routes.dart';
import 'package:crave_crusher/view/components/custom_app_bar/custom_app_bar.dart';
import 'package:crave_crusher/view/components/custom_nav_bar/navbar.dart';
import 'package:crave_crusher/view/features/battle/controller/battle_controller.dart';
import 'package:crave_crusher/view/features/battle/inner_screen/battle_details_screen.dart';
import 'package:crave_crusher/view/features/battle/widget/battle_tab_selector.dart';
import 'package:crave_crusher/view/features/battle/widget/active_battle_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class BattleScreen extends StatefulWidget {
  const BattleScreen({super.key, });

  @override
  State<BattleScreen> createState() => _BattleScreenState();
}

class _BattleScreenState extends State<BattleScreen> {
  final BattleController controller = Get.find<BattleController>();

  @override
  void initState() {
    super.initState();

    // Initial fetch based on current tab
    _fetchBattleByTab(controller.battleTabIndex.value);

    // Listen to tab changes
    ever(controller.battleTabIndex, (int index) {
      _fetchBattleByTab(index);
    });
  }

  void _fetchBattleByTab(int index) {
    switch (index) {
      case 0:
        controller.fetchAllBattle('active');
        break;
      case 1:
        controller.fetchAllBattle('complete');
        break;
      case 2:
        controller.fetchAllBattle('cancel');
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
                  child:
                      controller.isLoadingAllBattle.value
                          ? const Center(child: CircularProgressIndicator())
                          : controller.allBattleList.isEmpty
                          ? const Center(
                            child: Text(
                              "No active battles found",
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          )
                          : ListView.builder(
                            itemCount: controller.allBattleList.length,
                            physics: const AlwaysScrollableScrollPhysics(),
                            itemBuilder: (context, index) {
                              final battle = controller.allBattleList[index];

                              return ActiveBattleCard(
                                detoxType: DetoxType.smoke,
                                title: battle.addictionType.toString(),
                                percentText: "${battle.battleProgress}%",
                                progress: 0.58,
                                status: battle.battleStatus.toString(),
                                dayCount: "Day ${battle.day} of 30",
                                onBattlePressed: () {
                                  Get.to(
                                      BattleDetailsScreen(battleId: battle.id.toString())
                                  );
                                },
                              );
                            },
                          ),
                ),
              ],

              if (controller.battleTabIndex.value == 1) ...[
                Expanded(
                  child:
                      controller.isLoadingAllBattle.value
                          ? const Center(child: CircularProgressIndicator())
                          : controller.allBattleList.isEmpty
                          ? const Center(
                            child: Text(
                              "No completed battles found",
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          )
                          : ListView.builder(
                            itemCount: controller.allBattleList.length,
                            physics: const AlwaysScrollableScrollPhysics(),
                            itemBuilder: (context, index) {
                              final battle = controller.allBattleList[index];

                              return ActiveBattleCard(
                                detoxType: DetoxType.smoke,
                                title: battle.addictionType ?? "",
                                percentText: "${battle.battleProgress}%",
                                progress: (battle.battleProgress ?? 0) / 100,
                                status: "Completed",
                                dayCount: "Day ${battle.day} of 30",
                                onBattlePressed: () {
                                  Get.to(
                                      BattleDetailsScreen(battleId: battle.id.toString())
                                  );
                                },
                              );
                            },
                          ),
                ),
              ],

              if (controller.battleTabIndex.value == 2) ...[
                Expanded(
                  child:
                      controller.isLoadingAllBattle.value
                          ? const Center(child: CircularProgressIndicator())
                          : controller.allBattleList.isEmpty
                          ? const Center(
                            child: Text(
                              "No canceled battles found",
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          )
                          : ListView.builder(
                            itemCount: controller.allBattleList.length,
                            physics: const AlwaysScrollableScrollPhysics(),
                            itemBuilder: (context, index) {
                              final battle = controller.allBattleList[index];

                              return ActiveBattleCard(
                                detoxType: DetoxType.smoke,
                                title: battle.addictionType.toString(),
                                percentText: "${battle.battleProgress}%",
                                progress: 0.58,
                                status: "Canceled",
                                dayCount: "Day ${battle.day} of 30",
                                onBattlePressed: () {
                                  Get.to(
                                    BattleDetailsScreen(battleId: battle.id.toString())
                                  );
                                },
                              );
                            },
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
