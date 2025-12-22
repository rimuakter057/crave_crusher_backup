import 'package:crave_crusher/utils/app_colors/app_colors.dart';
import 'package:crave_crusher/utils/app_icons/app_icons.dart';
import 'package:crave_crusher/view/components/common_empty/common_empty_widget.dart';
import 'package:crave_crusher/view/components/custom_button/custom_button.dart';
import 'package:crave_crusher/view/components/custom_image/custom_image.dart';
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
import '../../../components/custom_loader/custom_loader.dart';
import '../widget/detox_type.dart';

class BattleDetailsScreen extends StatefulWidget {
   BattleDetailsScreen({
    super.key,
    required this.battleId,
   required this.isActive,
  });
  final String battleId;

  bool isActive=false;
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
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(kToolbarHeight),
        child: Padding(
          padding: EdgeInsets.symmetric(
            horizontal: 16.w,
          ), // custom horizontal padding
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
              child: BackButton(color: AppColors.primary),
            ),
            centerTitle: true,
            title: CustomText(
              text: 'Battle Details',
              fontSize: 18.sp,
              fontWeight: FontWeight.w500,
            ),
            actions: [
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
                        text: "Are you sure you want to cancel your battle?",
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
                                    : () {
                                      // synchronous wrapper
                                      () async {
                                        final success = await controller
                                            .cancelBattle(widget.battleId);
                                        if (success) {
                                          Get.to(() => BattleScreen());
                                          controller.fetchAllBattle("active");
                                        }
                                      }(); // immediately invoked
                                    },
                            title: "Yes",
                            height: 30.h,
                            width: 100.w,
                          );
                        }),
                      ],
                    ),
                    barrierDismissible: false, // optional
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
                  child: Icon(
                    Icons.close,
                    color: AppColors.primary,
                    size: 24.w,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),

      body: SingleChildScrollView(
        padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
        child: Obx(() {
          if (controller.isLoadingSingleBattle.value) {
            return const Center(child: CustomLoader());
          }

          final battle = controller.battleDetails.value.battle;
          if (battle == null) {
            return EmptyWidget(title: "No battle details yet");
          }

          return SingleChildScrollView(
            padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                DetailsMonsterSection(
                  detoxType: checkDetoxType(battle.addictionType ?? ''),
                  battleTitle: battle.addictionType ?? '',
                  battleDescription: battle.battleReason ?? '',
                  status: battle.todayStatus ?? '....',
                  monster:
                      controller.battleDetails.value.monster?.monsterImage ??
                      '',
                  monsterStatusMessage:
                  controller.battleDetails.value.monster?.monsterMessage ?? "Your Monster Is Losing Power — Keep It Up!",
                ),

                SizedBox(height: 24.h),

                ProgressAndActionSection(

                  buttonText: battle.todayStatus == "caved"
                      ? "Caved"
                      : battle.todayStatus == "craved"
                      ? "Craved"
                      : "Battle Now",


                  bgColor: battle.todayStatus == "caved"
                      ? AppColors.red100
                      : battle.todayStatus == "craved"
                      ? AppColors.softGreen
                      : AppColors.primary,


                  textColor: battle.todayStatus == "caved"
                      ? AppColors.red
                      : battle.todayStatus == "craved"
                      ? AppColors.green
                      : AppColors.white,
                  boarderColor: battle.todayStatus == "caved"
                      ? AppColors.red
                      : battle.todayStatus == "craved"
                      ? AppColors.green
                      : AppColors.primary,

                  iconSrc: battle.todayStatus == "caved"
                      ? AppIcons.cavedComplete
                      : battle.todayStatus == "craved"
                      ? AppIcons.battlePng
                      : AppIcons.battleNow,

                  isActive: widget.isActive,
                  progress: (battle.battleProgress ?? 0) / 100,
                  dayCount:
                      "Day ${battle.day ?? 0} of ${battle.battleLength ?? 0}",
                  title: battle.addictionType ?? '',
                  onBattleLogPressed: () {
                    final id = widget.battleId;
                    Get.to(() => BattleLogScreen(battleId: id));
                  },


                  onBattleNowPressed: battle.todayStatus == "caved"
                      ? (){}
                      : battle.todayStatus == "craved"
                      ? (){}
                      : (){
                    _buildShowBattleDialog(widget.battleId);
                  }

                ),

                SizedBox(height: 30.h),
              ],
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
        return Dialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          child: SizedBox(
            height: 170.h,
            width: 320.w,
            child: Padding(
              padding: EdgeInsets.all(12.w),
              child:
                  controller.isLoadingCompleteBattle.value
                      ? const Center(child: CustomLoader())
                      : Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
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
                                await controller.fetchSingleBattle(id);
                                Get.back(); // Dialog বন্ধ
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
                          // Craved
                          InkWell(
                            onTap: () async {
                              if (controller.isLoadingCompleteBattle.value)
                                return;
                              final success = await controller
                                  .completeBattleDay(id, "craved");
                              Get.back(); // Dialog বন্ধ
                              if (success) {
                                Get.snackbar(
                                  "Success",
                                  "Status updated to Craved",
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
