import 'package:crave_crusher/utils/app_colors/app_colors.dart';
import 'package:crave_crusher/utils/app_icons/app_icons.dart';
import 'package:crave_crusher/view/components/custom_button/custom_button.dart';
import 'package:crave_crusher/view/components/custom_image/custom_image.dart';
import 'package:crave_crusher/view/components/custom_nav_bar/navbar.dart';
import 'package:crave_crusher/view/components/custom_text/custom_text.dart';
import 'package:crave_crusher/view/screens/home/widget/active_battle_card.dart';
import 'package:crave_crusher/view/screens/home/widget/home_appbar.dart';
import 'package:crave_crusher/view/screens/home/widget/monster_section.dart';
import 'package:crave_crusher/view/screens/home/widget/today_tips.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: HomeAppbar(),
      body: SingleChildScrollView(
        padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.h),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Tip and Monster Section
            TodayTips(),
            MonsterSection(),

            SizedBox(height: 24.h),

            // Active Battle Section Title
            Padding(
              padding: EdgeInsets.only(bottom: 12.h),
              child: const Row(
                children: [
                  Icon(Icons.close, color: AppColors.black),
                  SizedBox(width: 8),
                  CustomText(
                    text: "Active Battle",
                    fontWeight: FontWeight.w600,
                    fontSize: 18,
                  ),
                ],
              ),
            ),

            // Active Battle Cards
            // SOLID Principle (OCP): Notun battle add korle shudhu list e add korlei hobe.
            ActiveBattleCard(
              iconSrc: AppIcons.smoke, // Placeholder
              title: "Smoking Detox",
              progress: 0.58, // 58%
              status: "Pending",
              dayCount: "Day 12 of 30",
              statusColor: AppColors.statusPending,
            ),
            SizedBox(height: 16.h),
            // _ActiveBattleCard(
            //   iconSrc: 'assets/icons/money_battle.svg', // Placeholder
            //   title: "Shaving Money Battle",
            //   progress: 0.75, // 75%
            //   status: "Craved",
            //   dayCount: "Day 12 of 30",
            //   statusColor:
            //       AppColors
            //           .statusshiping, // Assuming statusshiping is green/success
            // ),
            // SizedBox(height: 16.h),
            // _ActiveBattleCard(
            //   iconSrc: 'assets/icons/social_media.svg', // Placeholder
            //   title: "Social Media Detox",
            //   progress: 0.92, // 92%
            //   status:
            //       "Craved", // Assuming "Craved" means Saved based on red color use
            //   dayCount: "Day 12 of 30",
            //   statusColor: AppColors.red,
            // ),
            // SizedBox(height: 24.h),
          ],
        ),
      ),

      bottomNavigationBar: NavBar(currentIndex: 0),
    );
  }
}

// SOLID Principle (SRP): Ei widget-ti shudhu Tip o Monster UI render korar kaaj korche.

// SOLID Principle (OCP, ISP): Highly reusable component with minimal, necessary parameters.
