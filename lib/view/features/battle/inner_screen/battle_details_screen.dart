// ignore_for_file: must_be_immutable, deprecated_member_use

import 'package:crave_crusher/utils/app_colors/app_colors.dart';
import 'package:crave_crusher/utils/app_icons/app_icons.dart';
import 'package:crave_crusher/utils/app_strings/app_strings.dart';
import 'package:crave_crusher/view/components/common_empty/common_empty_widget.dart';
import 'package:crave_crusher/view/components/custom_button/custom_button.dart';
import 'package:crave_crusher/view/components/custom_image/custom_image.dart';
import 'package:crave_crusher/view/components/custom_svg_icon/custom_svg_icon.dart';
import 'package:crave_crusher/view/components/custom_text/custom_text.dart';
import 'package:crave_crusher/view/features/battle/battle_screen.dart';
import 'package:crave_crusher/view/features/battle/controller/battle_controller.dart';
import 'package:crave_crusher/view/features/battle/inner_screen/battle_log_screen.dart';
import 'package:crave_crusher/view/features/battle/widget/details_monster_section.dart';
import 'package:crave_crusher/view/features/battle/widget/progress_and_action_section.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import '../../../components/custom_loader/custom_loader.dart';
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
        padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
        child: Obx(() {
          if (controller.isLoadingSingleBattle.value) {
            return CustomLoader();
          }

          final battle = controller.battleDetails.value.battle;

          final logs = controller.battleDetails.value.battleLogs ?? [];

          final totalCaved =
          logs.fold(0, (sum, e) => sum + (e.totalCaved ?? 0));

          final totalCraved =
          logs.fold(0, (sum, e) => sum + (e.totalCraved ?? 0));

          if (battle == null) {
            return EmptyWidget(title: "No battle details yet");
          }

          return Card(
            color: AppColors.white,
            child: SingleChildScrollView(
              padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  DetailsMonsterSection(
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

                  SizedBox(height: 24.h),

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

          if (
          widget.isActive &&
          (
          widget.status == AppText.pendingStatus ||
              widget.status == AppText.cavedStatus ||
              widget.status == AppText.cravedStatus
          )
          )
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        ///if caved status===============================================
                        _buildCountButton(
                          count: totalCaved,
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
                              Get.dialog(
                                Center(
                                  child: Lottie.asset(
                                    AppIcons.lottieBattle,
                                    repeat: false,
                                    onLoaded: (composition) async {
                                      await Future.delayed(
                                        composition.duration,
                                      );
                                      Get.back();
                                    },
                                  ),
                                ),
                                barrierDismissible: false,
                              );

                              await controller.fetchSingleBattle(
                                widget.battleId,
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

                        ///if craved status===============================================
                        _buildCountButton(
                          count: totalCraved,
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
                              // Get.back();
                              Get.dialog(
                                Center(
                                  child: Lottie.asset(
                                    AppIcons.lottieBattle,
                                    repeat: false,
                                    onLoaded: (composition) async {
                                      await Future.delayed(
                                        composition.duration,
                                      );
                                      Get.back();
                                    },
                                  ),
                                ),
                                barrierDismissible: false,
                              );
                              await controller.fetchSingleBattle(
                                widget.battleId,
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
  void _buildShowBattleDialog(String id) {
    Get.dialog(
      Obx(() {
        return Center(
          child: Dialog(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
            child: SizedBox(
              height: 170.h,
              width: 340.w,
              child:
                  controller.isLoadingCompleteBattle.value
                      ? const Center(child: CustomLoader())
                      : Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          // Caved
                          InkWell(
                            onTap: () async {
                              if (controller.isLoadingCompleteBattle.value) {
                                return;
                              }
                              final success = await controller
                                  .completeBattleDay(id, "caved");
                              if (success) {
                                // Get.back();

                                Get.dialog(
                                  Center(
                                    child: Lottie.asset(
                                      AppIcons.lottieBattle,
                                      repeat: false,
                                      onLoaded: (composition) async {
                                        await Future.delayed(
                                          composition.duration,
                                        );
                                        Get.back();
                                      },
                                    ),
                                  ),
                                  barrierDismissible: false,
                                );

                                await controller.fetchSingleBattle(id);
                              } else {
                                Get.snackbar(
                                  "Error",
                                  "Status update failed",
                                  backgroundColor: AppColors.red100,
                                );
                              }
                            },
                            child: _buildDialogContainer(
                              "Caved",
                              AppIcons.cavedComplete,
                            ),
                          ),
                          Gap(12.w),
                          // Craved
                          InkWell(
                            onTap: () async {
                              if (controller.isLoadingCompleteBattle.value) {
                                return;
                              }

                              final success = await controller
                                  .completeBattleDay(id, "craved");

                              if (success) {
                                // Get.back();
                                Get.dialog(
                                  Center(
                                    child: Lottie.asset(
                                      AppIcons.lottieBattle,
                                      repeat: false,
                                      onLoaded: (composition) async {
                                        await Future.delayed(
                                          composition.duration,
                                        );
                                        Get.back();
                                      },
                                    ),
                                  ),
                                  barrierDismissible: false,
                                );
                                await controller.fetchSingleBattle(id);
                              } else {
                                Get.snackbar(
                                  "Error",
                                  "Status update failed",
                                  backgroundColor: AppColors.red100,
                                );
                              }
                            },
                            child: _buildDialogContainer(
                              "Craved",
                              AppIcons.battlePng,
                            ),
                          ),
                        ],
                      ),
            ),
          ),
        );
      }),
      barrierDismissible: true,
    );
  }

  PreferredSize _buildAppbar() {
    return PreferredSize(
      preferredSize: Size.fromHeight(kToolbarHeight),
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 16.w),
        child: AppBar(
          surfaceTintColor: AppColors.backgroundColor,
          backgroundColor: AppColors.backgroundColor,
          leadingWidth: 50.w, // adjust if needed
          leading: Container(
            width: 50.w,
            height: 50.h,
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
            fontSize: 18.sp,
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
                              borderRadius: BorderRadius.circular(12),
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
                                height: 30.h,
                                width: 100.w,
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
                                  height: 30.h,
                                  width: 100.w,
                                );
                              }),
                            ],
                          ),
                          barrierDismissible: false,
                        );
                      },
                      child: Container(
                        width: 50.w,
                        height: 50.h,
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                          color: AppColors.subPrimary.withOpacity(.3),
                          shape: BoxShape.circle,
                          border: Border.all(color: AppColors.subPrimary),
                        ),
                        child: CustomSvgIcon(
                          icon: AppIcons.cross,
                          height: 28.h,
                          width: 28.w,
                        ),
                      ),
                    ),
                  ]
                  : [],
        ),
      ),
    );
  }

  ///build dialog container
  Container _buildDialogContainer(final String text, final String image) {
    return Container(
      height: 120.h,
      width: 120.w,
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
            width: 100.w,
            fit: BoxFit.cover,
          ),
          Gap(4.h),
          CustomText(text: text),
        ],
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
      height: 36.h,
      width: 130.w,
      alignment: Alignment.center,
      decoration: BoxDecoration(
        color: AppColors.primary,
        borderRadius: BorderRadius.circular(8.r),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          CustomText(
            text: count.toString(),
            fontSize: 16.sp,
            fontWeight: FontWeight.w600,
            color: AppColors.white,
          ),
          SizedBox(width: 8.w),
          CustomText(
            text: label,
            fontSize: 14.sp,
            fontWeight: FontWeight.w600,
            color: AppColors.white,
          ),
        ],
      ),
    ),
  );
}
