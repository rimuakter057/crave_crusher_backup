import 'package:crave_crusher/core/routes/app_routes.dart';
import 'package:crave_crusher/utils/app_colors/app_colors.dart';
import 'package:crave_crusher/utils/app_icons/app_icons.dart';
import 'package:crave_crusher/view/components/custom_app_bar/custom_app_bar.dart';
import 'package:crave_crusher/view/features/battle/controller/battle_controller.dart';
import 'package:crave_crusher/view/features/battle/inner_screen/battle_log_screen.dart';
import 'package:crave_crusher/view/features/battle/widget/details_monster_section.dart';
import 'package:crave_crusher/view/features/battle/widget/progress_and_action_section.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class BattleDetailsScreen extends StatefulWidget {


  const BattleDetailsScreen({super.key, required this.battleId});
  final String battleId;


  @override
  State<BattleDetailsScreen> createState() => _BattleDetailsScreenState();
}

class _BattleDetailsScreenState extends State<BattleDetailsScreen> {
  final BattleController controller = Get.find<BattleController>();

  @override
  void initState() {
    // TODO: implement initState
    controller.fetchSingleBattle(widget.battleId);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
      appBar: CustomAppBar(
        title: 'Battle Details',
        actionIcon: AppIcons.edit,
        onActionPressed: () {
          Get.toNamed(AppRoutes.updateBattle);
        },
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
        child: Obx(() {
          if (controller.isLoadingSingleBattle.value) {
            return const Center(child: CircularProgressIndicator());
          }

          final battle = controller.battleDetails.value.battle;
          if (battle == null) {
            return const Center(child: Text("No battle found"));
          }

          return SingleChildScrollView(
            padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Monster Section (Header + Monster Image + Status Banner)
                DetailsMonsterSection(
                  battleTitle: battle.addictionType ?? '',
                  battleDescription: battle.battleReason ?? '',
                  status: battle.battleStatus ?? '',
                  monsterStatusMessage:
                      "Your Monster Is Losing Power — Keep It Up!",
                ),

                SizedBox(height: 24.h),

                // Progress & Action Section (Progress Bar + Buttons)
                ProgressAndActionSection(
                  progress: (battle.battleProgress ?? 0) / 100,
                  dayCount:
                      "Day ${battle.day ?? 0} of ${battle.battleLength ?? 0}",
                  title: battle.battleReason ?? '',
                  onBattleLogPressed: () {
                    // Navigate to Battle Log screen with battleId
                    Get.to(BattleLogScreen(battleId: widget.battleId,));
                   // Get.to(BattleLogScreen());

                  },
                  onBattleNowPressed: () {
                    // Keep your Battle Now button functionality here
                  },
                ),

                SizedBox(height: 30.h),
              ],
            ),
          );
        }),


      ),
    );
  }
}
