import 'package:crave_crusher/core/routes/app_routes.dart';
import 'package:crave_crusher/utils/app_colors/app_colors.dart';
import 'package:crave_crusher/utils/app_icons/app_icons.dart';
import 'package:crave_crusher/view/components/custom_app_bar/custom_app_bar.dart';
import 'package:crave_crusher/view/features/battle/widget/details_monster_section.dart';
import 'package:crave_crusher/view/features/battle/widget/progress_and_action_section.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

// class BattleDetailsScreen extends StatelessWidget {
//   const BattleDetailsScreen({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: CustomAppBar(
//         title: 'Battle Details',
//         actionIcon: AppIcons.edit,
//         onActionPressed: () {},
//       ),

//       body: Padding(
//         padding: EdgeInsets.symmetric(horizontal: 16.0.w),
//         child: Column(
//           children: [

//           ],
//         ),
//       ),
//     );
//   }
// }
class BattleDetailsScreen extends StatelessWidget {
  // Assuming this screen receives the battle ID or details
  //final String battleId;

  const BattleDetailsScreen({super.key});

  // Sample data (Replace with actual data fetching logic)
  static const String battleTitle = "Smoking Detox";
  static const String battleDescription =
      "I want to quit smoking to be healthier for my family.";
  static const String status = "Pending";
  static const String monsterStatusMessage =
      "Your Monster Is Losing Power — Keep It Up!";
  static const double progress = 0.75;
  static const String dayCount = "Day 12 of 30";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
      appBar: CustomAppBar(
        title: 'Battle Details',
        actionIcon: AppIcons.edit,
        onActionPressed: () {
          Get.toNamed(AppRoutes.createBattleScreen);
        },
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Monster Section (Header + Monster Image + Status Banner)
            DetailsMonsterSection(
              battleTitle: battleTitle,
              battleDescription: battleDescription,
              status: status,
              monsterStatusMessage: monsterStatusMessage,
            ),

            SizedBox(height: 24.h),

            // Progress & Action Section (Progress Bar + Buttons)
            ProgressAndActionSection(
              progress: progress,
              dayCount: dayCount,
              title: battleTitle,
              onBattleLogPressed: () {
                Get.toNamed(AppRoutes.battleLogScreen);
                // To Do: Implement Battle Log navigation
              },
              onBattleNowPressed: () {
                // To Do: Implement Battle Now action
              },
            ),

            SizedBox(height: 30.h),
          ],
        ),
      ),
    );
  }
}
