import 'package:crave_crusher/core/routes/app_routes.dart';
import 'package:crave_crusher/utils/app_colors/app_colors.dart';
import 'package:crave_crusher/utils/app_icons/app_icons.dart';
import 'package:crave_crusher/utils/app_images/app_images.dart';
import 'package:crave_crusher/view/components/custom_app_bar/custom_app_bar.dart';
import 'package:crave_crusher/view/components/custom_image/custom_image.dart';
import 'package:crave_crusher/view/components/custom_text/custom_text.dart';
import 'package:crave_crusher/view/features/battle/controller/battle_controller.dart';
import 'package:crave_crusher/view/features/battle/inner_screen/battle_log_screen.dart';
import 'package:crave_crusher/view/features/battle/widget/details_monster_section.dart';
import 'package:crave_crusher/view/features/battle/widget/progress_and_action_section.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gap/gap.dart';
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
    print("-----------------------------id--------------${widget.battleId}");
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
          Get.toNamed(AppRoutes.updateBattle,
            arguments: widget.battleId,
          );
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
                    final id = widget.battleId;
                    print("-----------------------------id--------------${id}");
                    Get.to(BattleLogScreen(battleId:id));
                    // Get.to(BattleLogScreen());
                  },
                  onBattleNowPressed: () {
                    final id = widget.battleId;
                    print("-----------------------------id--------------${id}");
                    showDialog(
                      context: context,
                      barrierDismissible: false, // accidental close prevent
                      builder: (_) {
                        return Obx(() {
                          return Center(
                            child: Card(
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12),
                              ),
                              child: SizedBox(
                                height: 170.h,
                                width: 320.w,
                                child: Padding(
                                  padding: EdgeInsets.all(12.w),
                                  child: controller.isLoadingCompleteBattle.value
                                      ? const Center(child: CircularProgressIndicator())
                                      : Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                                    children: [
                                      // 🔹 Caved
                                      InkWell(
                                        onTap: () async {
                                          if (controller.isLoadingCompleteBattle.value) return;

                                          // API call
                                      final success = await controller.completeBattleDay(
                                           id,
                                            "caved",
                                          );

                                          if (success) {
                                            // Close dialog
                                            Get.back();

                                            // Optional success message
                                            Get.snackbar("Success", "Status updated to Caved");
                                         // Immediately refresh the same screen
                                            await controller.fetchSingleBattle(id);
                                          }
                                        },
                                        child: _buildDialogContainer("Caved", AppIcons.smallMonster),
                                      ),

                                      // 🔹 Craved
                                      InkWell(
                                        onTap: () async {
                                          if (controller.isLoadingCompleteBattle.value) return;

                                          // API call
                                          final success = await controller.completeBattleDay(
                                            id,
                                            "craved",
                                          );

                                          if (success) {
                                            // Close dialog
                                            Get.back();

                                            // Optional success message
                                            Get.snackbar("Success", "Status updated to Craved");
                                          // Immediately refresh the same screen
                                            await controller.fetchSingleBattle(id);
                                          }
                                        },
                                        child: _buildDialogContainer("Craved", AppIcons.battlePng),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          );
                        });
                      },
                    );
                  },






                  // onBattleNowPressed: () {
                  //   showDialog(
                  //     context: context,
                  //     barrierDismissible: true,
                  //     builder: (_) {
                  //       return Center(
                  //         child: Card(
                  //           shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                  //           child: SizedBox(
                  //             height: 170.h,
                  //             width: 320.w,
                  //             child: Padding(
                  //               padding: EdgeInsets.all(12.w),
                  //               child: Row(
                  //                 mainAxisAlignment: MainAxisAlignment.spaceAround,
                  //                 children: [
                  //                   _buildDialogContainer("Caved", AppIcons.smallMonster),
                  //                   _buildDialogContainer("craved", AppIcons.battlePng),
                  //                 ],
                  //               ),
                  //             ),
                  //           ),
                  //         ),
                  //       );
                  //     },
                  //   );
                  // },

                ),

                SizedBox(height: 30.h),
              ],
            ),
          );
        }),
      ),
    );
  }


  ///build dialog container
  Container _buildDialogContainer(final String text, final String image) {
    return Container(
      height: 130.h,
      width: 128.w,
      decoration: BoxDecoration(
        color: AppColors.subPrimary,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          CustomImage(
            imageSrc: image,
            height: 80.h,
            width: 108.w,
            fit: BoxFit.cover,
          ),
          Gap(4.h),
          CustomText(text: text),
        ],
      ),
    );
  }
}
