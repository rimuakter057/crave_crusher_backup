import 'package:crave_crusher/core/routes/app_routes.dart';
import 'package:crave_crusher/utils/app_colors/app_colors.dart';
import 'package:crave_crusher/view/components/custom_app_bar/custom_app_bar.dart';
import 'package:crave_crusher/view/components/custom_nav_bar/navbar.dart';
import 'package:crave_crusher/view/features/battle/controller/battle_controller.dart';
import 'package:crave_crusher/view/features/battle/widget/battle_tab_selector.dart';
import 'package:crave_crusher/view/features/battle/widget/active_battle_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class BattleScreen extends StatelessWidget {
   BattleScreen({super.key});

   final BattleController controller = Get.find<BattleController>();

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
        child: Obx(
                (){
            return Column(
              children: [
                SizedBox(height: 16.h),
                BattleTabSelector(),

                SizedBox(height: 10.h),
                if(controller.battleTabIndex.value == 0)...[ Expanded(
                  child: ListView.builder(
                      itemCount: 5,
                      shrinkWrap: true,
                      physics: AlwaysScrollableScrollPhysics(),
                      itemBuilder: (context, index){
                    return   ActiveBattleCard(
                            detoxType: DetoxType.smoke,
                            // Placeholder
                            title: "Smoking Detox",
                            progress: 0.58, // 58%
                            status: "Pending",
                            dayCount: "Day 12 of 30",
                            onBattlePressed: () {
                              Get.toNamed(AppRoutes.battleDetailsScreen);
                            },
                          );
                  }),


                ),],
                if(controller.battleTabIndex.value == 1)...[ Expanded(
                  child: ListView.builder(
                      itemCount: 5,
                      shrinkWrap: true,
                      physics: AlwaysScrollableScrollPhysics(),
                      itemBuilder: (context, index){
                        return   ActiveBattleCard(
                          detoxType: DetoxType.smoke,
                          // Placeholder
                          title: "Smoking Detox",
                          progress: 0.58, // 58%
                          status: "Completed",
                          dayCount: "Day 12 of 30",

                          onBattlePressed: () {
                            Get.toNamed(AppRoutes.battleDetailsScreen);
                          },
                        );
                      }),


                ),],
                if(controller.battleTabIndex.value == 2)...[ Expanded(
                  child: ListView.builder(
                      itemCount: 5,
                      shrinkWrap: true,
                      physics: AlwaysScrollableScrollPhysics(),
                      itemBuilder: (context, index){
                        return   ActiveBattleCard(
                          detoxType: DetoxType.smoke,
                          // Placeholder
                          title: "Smoking Detox",
                          progress: 0.58, // 58%
                          status: "Canceled",
                          dayCount: "Day 12 of 30",

                          onBattlePressed: () {
                            Get.toNamed(AppRoutes.battleDetailsScreen);
                          },
                        );
                      }),


                ),],

              ],
            );
          }
        ),
      ),

      bottomNavigationBar: NavBar(currentIndex: 1),
    );
  }
}
