// ignore_for_file: must_be_immutable, deprecated_member_use

import 'package:crave_crusher/helper/responsive_helper/responsive_helper.dart';
import 'package:crave_crusher/utils/app_colors/app_colors.dart';
import 'package:crave_crusher/utils/app_icons/app_icons.dart';
import 'package:crave_crusher/utils/app_strings/app_strings.dart';
import 'package:crave_crusher/view/components/common_empty/common_empty_widget.dart';
import 'package:crave_crusher/view/components/custom_button/custom_button.dart';

import 'package:crave_crusher/view/components/custom_svg_icon/custom_svg_icon.dart';
import 'package:crave_crusher/view/components/custom_text/custom_text.dart';
import 'package:crave_crusher/view/features/battle/battle_screen.dart';
import 'package:crave_crusher/view/features/battle/controller/battle_controller.dart';
import 'package:crave_crusher/view/features/battle/inner_screen/battle_log_screen.dart';
import 'package:crave_crusher/view/features/battle/widget/battle_details_shimmer.dart';
import 'package:crave_crusher/view/features/battle/widget/details_monster_section.dart';
import 'package:crave_crusher/view/features/battle/widget/progress_and_action_section.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../widget/detox_type.dart';

class BattleDetailsScreen extends StatefulWidget {
  BattleDetailsScreen({
    super.key,
    required this.battleId,
    required this.isActive,
    required this.status,
  });
  final String battleId;
  final String status;
  bool isActive = false;
  @override
  State<BattleDetailsScreen> createState() => _BattleDetailsScreenState();
}

class _BattleDetailsScreenState extends State<BattleDetailsScreen> {
  final BattleController controller = Get.find<BattleController>();

  bool showAnimation = false; // ✅ Animation on/off handle

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      controller.fetchSingleBattle(widget.battleId);
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
      appBar: _buildAppbar(),

      body: SingleChildScrollView(
        padding: EdgeInsets.symmetric(
          horizontal: ResponsiveHelper.width(16),
          vertical: ResponsiveHelper.height(12),
        ),
        child: Obx(() {
          if (controller.isLoadingSingleBattle.value) {
            return BattleDetailsShimmerLoader();
          }

          final battle = controller.battleDetails.value.battle;

          if (battle == null) {
            return EmptyWidget(title: "No battle details yet");
          }

          return Card(
            color: AppColors.white,
            child: SingleChildScrollView(
              padding: EdgeInsets.symmetric(
                horizontal: ResponsiveHelper.width(16),
                vertical: ResponsiveHelper.height(12),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  DetailsMonsterSection(
                    showMonstarImage: controller.showMonsterImage.value,
                    detoxType: checkDetoxType(battle.addictionType ?? ''),
                    battleTitle: battle.addictionType ?? '',
                    battleDescription: battle.battleReason ?? '',
                    status:
                        widget.isActive
                            ? (battle.todayStatus ??
                                battle.battleStatus ??
                                '....')
                            : (battle.battleStatus ?? '....'),
                    bgColor:
                        widget.isActive
                            ? (battle.todayStatus == AppText.cavedStatus
                                ? AppColors.red100
                                : battle.todayStatus == AppText.cravedStatus
                                ? AppColors.softGreen
                                : AppColors.subPrimary)
                            : (battle.battleStatus == AppText.cancelStatus
                                ? AppColors.red100
                                : battle.battleStatus == AppText.completeStatus
                                ? Colors.blue.shade50
                                : AppColors.subPrimary),
                    textColor:
                        widget.isActive
                            ? (battle.todayStatus == AppText.cavedStatus
                                ? AppColors.red
                                : battle.todayStatus == AppText.cravedStatus
                                ? AppColors.green
                                : AppColors.primary)
                            : (battle.battleStatus == AppText.cancelStatus
                                ? AppColors.red
                                : battle.battleStatus == AppText.completeStatus
                                ? Colors.blue
                                : AppColors.primary),
                    boarderColor:
                        widget.isActive
                            ? (battle.todayStatus == AppText.cavedStatus
                                ? AppColors.red
                                : battle.todayStatus == AppText.cravedStatus
                                ? AppColors.green
                                : AppColors.primary)
                            : (battle.battleStatus == AppText.cancelStatus
                                ? AppColors.red
                                : battle.battleStatus == AppText.completeStatus
                                ? Colors.blue
                                : AppColors.primary),
                    monster:
                        controller.battleDetails.value.monster?.monsterImage ??
                        '',
                    monsterStatusMessage:
                        controller
                            .battleDetails
                            .value
                            .monster
                            ?.monsterMessage ??
                        "Your Monster Is Losing Power — Keep It Up!",
                  ),

                  SizedBox(height: ResponsiveHelper.height(24)),

                  ProgressAndActionSection(
                    progress: (battle.battleProgress ?? 0) / 100,
                    dayCount:
                        "Day ${battle.dayProgress ?? 0} of ${battle.battleLength ?? 0}",
                    title: battle.addictionType ?? '',
                    onBattleLogPressed: () {
                      final id = widget.battleId;
                      Get.to(() => BattleLogScreen(battleId: id));
                    },
                  ),

                  ///if caved status===============================================
                  if (widget.isActive &&
                      (widget.status == AppText.pendingStatus ||
                          widget.status == AppText.cavedStatus ||
                          widget.status == AppText.cravedStatus ||
                          widget.status == AppText.missedStatus))
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        _buildCountButton(
                          count: battle.todayCavedCount ?? 0,
                          label: 'Caved',
                          onTap: () async {
                            if (controller.isLoadingCompleteBattle.value) {
                              return;
                            }
                            final success = await controller.completeBattleDay(
                              widget.battleId,
                              "caved",
                            );
                            if (success) {
                              debugPrint("caved==================success");

                              controller.showMonsterDialog(
                                image: AppIcons.cavedAnimation,
                              );
                              await Future.delayed(
                                Duration(seconds: 0),
                                () async {
                                  await controller.fetchSingleBattle(
                                    widget.battleId,
                                  );
                                },
                              );
                            } else {
                              Get.snackbar(
                                "Error",
                                "Status update failed",
                                backgroundColor: AppColors.red100,
                              );
                            }
                          },
                        ),

                        ///if craved status button============================================================================
                        _buildCountButton(
                          count: battle.todayCravedCount ?? 0,
                          label: 'Craved',
                          onTap: () async {
                            if (controller.isLoadingCompleteBattle.value) {
                              return;
                            }
                            final success = await controller.completeBattleDay(
                              widget.battleId,
                              "craved",
                            );
                            if (success) {
                              debugPrint("craved==================success");

                              controller.showMonsterDialog(
                                image: AppIcons.jailedMonster,
                              );
                              await Future.delayed(
                                Duration(seconds: 0),
                                () async {
                                  await controller.fetchSingleBattle(
                                    widget.battleId,
                                  );
                                },
                              );
                            } else {
                              Get.snackbar(
                                "Error",
                                "Status update failed",
                                backgroundColor: AppColors.red100,
                              );
                            }
                          },
                        ),
                      ],
                    ),
                ],
              ),
            ),
          );
        }),
      ),
    );
  }

  /// show dialog==============================================================================================

  PreferredSize _buildAppbar() {
    return PreferredSize(
      preferredSize: Size.fromHeight(kToolbarHeight),
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: ResponsiveHelper.width(16)),
        child: AppBar(
          surfaceTintColor: AppColors.backgroundColor,
          backgroundColor: AppColors.backgroundColor,
          leadingWidth: ResponsiveHelper.width(50), // adjust if needed
          leading: Container(
            width: ResponsiveHelper.width(50),
            height: ResponsiveHelper.height(50),
            alignment: Alignment.center,
            decoration: BoxDecoration(
              color: AppColors.subPrimary.withOpacity(.3),
              shape: BoxShape.circle,
              border: Border.all(color: AppColors.subPrimary),
            ),
            // child: BackButton(color: AppColors.primary),
            child: IconButton(
              onPressed: () {
                Get.back();
                controller.fetchAllBattle();
              },
              icon: CustomSvgIcon(icon: AppIcons.backButton),
            ),
          ),
          centerTitle: true,
          title: CustomText(
            text: 'Battle Details',
            fontSize: ResponsiveHelper.fontSize(18),
            fontWeight: FontWeight.w500,
          ),

          actions:
              widget.isActive
                  ? [
                    GestureDetector(
                      onTap: () {
                        Get.dialog(
                          AlertDialog(
                            backgroundColor: AppColors.white,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(
                                ResponsiveHelper.borderRadius(12),
                              ),
                            ),
                            title: Text(
                              "Confirm",
                              style: TextStyle(fontWeight: FontWeight.bold),
                              textAlign: TextAlign.center,
                            ),
                            content: CustomText(
                              maxLines: 2,
                              text:
                                  "Are you sure you want to cancel your battle?",
                              textAlign: TextAlign.center,
                            ),
                            actionsAlignment: MainAxisAlignment.center,
                            actions: [
                              CustomButton(
                                onTap: () {
                                  Get.back(); // Close dialog
                                },
                                title: "No",
                                height: ResponsiveHelper.height(30),
                                width: ResponsiveHelper.width(100),
                              ),
                              Obx(() {
                                return CustomButton(
                                  onTap:
                                      controller.isLoadingCancelBattle.value
                                          ? () {}
                                          : () async {
                                            final success = await controller
                                                .cancelBattle(widget.battleId);
                                            if (success) {
                                              Get.to(() => BattleScreen());
                                              controller.fetchAllBattle();
                                            }
                                          },
                                  title: "Yes",
                                  height: ResponsiveHelper.height(30),
                                  width: ResponsiveHelper.width(100),
                                );
                              }),
                            ],
                          ),
                          barrierDismissible: false,
                        );
                      },
                      child: Container(
                        width: ResponsiveHelper.width(50),
                        height: ResponsiveHelper.height(50),
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                          color: AppColors.subPrimary.withOpacity(.3),
                          shape: BoxShape.circle,
                          border: Border.all(color: AppColors.subPrimary),
                        ),
                        child: CustomSvgIcon(
                          icon: AppIcons.cross,
                          height: ResponsiveHelper.height(28),
                          width: ResponsiveHelper.width(28),
                        ),
                      ),
                    ),
                  ]
                  : [],
        ),
      ),
    );
  }
}

/// 🔹 Counter button (Caved / Craved)
Widget _buildCountButton({
  required int count,
  required String label,
  required VoidCallback onTap,
}) {
  return GestureDetector(
    onTap: onTap,
    child: Container(
      height: ResponsiveHelper.height(36),
      width: ResponsiveHelper.width(130),
      alignment: Alignment.center,
      decoration: BoxDecoration(
        color: AppColors.primary,
        borderRadius: BorderRadius.circular(ResponsiveHelper.borderRadius(8)),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          CustomText(
            text: count.toString(),
            fontSize: ResponsiveHelper.fontSize(16),
            fontWeight: FontWeight.w600,
            color: AppColors.white,
          ),
          SizedBox(width: ResponsiveHelper.width(8)),
          CustomText(
            text: label,
            fontSize: ResponsiveHelper.fontSize(14),
            fontWeight: FontWeight.w600,
            color: AppColors.white,
          ),
        ],
      ),
    ),
  );
}
