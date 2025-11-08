import 'package:crave_crusher/utils/app_colors/app_colors.dart';
import 'package:crave_crusher/view/components/custom_app_bar/custom_app_bar.dart';
import 'package:crave_crusher/view/components/custom_nav_bar/navbar.dart';
import 'package:crave_crusher/view/screens/battle/widget/battle_tab_selector.dart';
import 'package:crave_crusher/view/screens/home/widget/active_battle_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class BattleScreen extends StatelessWidget {
  const BattleScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: ,
      appBar: CustomAppBar(title: 'My Battle', onActionPressed: () {}),

      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 16.0.w),
        child: Column(
          children: [
            SizedBox(height: 16.h),
            BattleTabSelector(),

            SizedBox(height: 10.h),
            Expanded(
              child: ListView(
                shrinkWrap: true,
                physics: AlwaysScrollableScrollPhysics(),
                children: [
                  ActiveBattleCard(
                    detoxType: DetoxType.smoke,
                    // Placeholder
                    title: "Smoking Detox",
                    progress: 0.58, // 58%
                    status: "Pending",
                    dayCount: "Day 12 of 30",
                    statusColor: AppColors.primary,
                  ),
                  SizedBox(height: 16.h),
                  ActiveBattleCard(
                    detoxType: DetoxType.love,
                    // Placeholder
                    title: "Toxic Relationship Detox",
                    progress: 0.58, // 58%
                    status: "Pending",
                    dayCount: "Day 12 of 30",
                    statusColor: AppColors.primary,
                  ),
                  SizedBox(height: 16.h),
                  ActiveBattleCard(
                    detoxType: DetoxType.junkFood,
                    // Placeholder
                    title: "Junk Food Detox",
                    progress: 0.58, // 58%
                    status: "Pending",
                    dayCount: "Day 12 of 30",
                    statusColor: AppColors.primary,
                  ),
                  SizedBox(height: 16.h),
                  ActiveBattleCard(
                    detoxType: DetoxType.socialMedia,
                    // Placeholder
                    title: "Social Media Detox",
                    progress: 0.58, // 58%
                    status: "Pending",
                    dayCount: "Day 12 of 30",
                    statusColor: AppColors.primary,
                  ),
                  SizedBox(height: 16.h),
                  ActiveBattleCard(
                    detoxType: DetoxType.smoke,
                    // Placeholder
                    title: "Smoking Detox",
                    progress: 0.58, // 58%
                    status: "Pending",
                    dayCount: "Day 12 of 30",
                    statusColor: AppColors.primary,
                  ),
                  SizedBox(height: 16.h),
                ],
              ),
            ),
          ],
        ),
      ),

      bottomNavigationBar: NavBar(currentIndex: 1),
    );
  }
}
