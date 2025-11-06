import 'package:crave_crusher/utils/app_colors/app_colors.dart';
import 'package:crave_crusher/view/components/custom_button/custom_button.dart';
import 'package:crave_crusher/view/components/custom_image/custom_image.dart';
import 'package:crave_crusher/view/components/custom_nav_bar/navbar.dart';
import 'package:crave_crusher/view/components/custom_text/custom_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppBar(),
      body: SingleChildScrollView(
        padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.h),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Tip and Monster Section
            const _TipAndMonsterSection(),

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
            _ActiveBattleCard(
              iconSrc: 'assets/icons/smoking_detox.svg', // Placeholder
              title: "Smoking Detox",
              progress: 0.58, // 58%
              status: "Pending",
              dayCount: "Day 12 of 30",
              statusColor: AppColors.statusPending,
            ),
            SizedBox(height: 16.h),
            _ActiveBattleCard(
              iconSrc: 'assets/icons/money_battle.svg', // Placeholder
              title: "Shaving Money Battle",
              progress: 0.75, // 75%
              status: "Craved",
              dayCount: "Day 12 of 30",
              statusColor:
                  AppColors
                      .statusshiping, // Assuming statusshiping is green/success
            ),
            SizedBox(height: 16.h),
            _ActiveBattleCard(
              iconSrc: 'assets/icons/social_media.svg', // Placeholder
              title: "Social Media Detox",
              progress: 0.92, // 92%
              status:
                  "Craved", // Assuming "Craved" means Saved based on red color use
              dayCount: "Day 12 of 30",
              statusColor: AppColors.red,
            ),
            SizedBox(height: 24.h),
          ],
        ),
      ),

      bottomNavigationBar: NavBar(currentIndex: 0),
    );
  }

  AppBar _buildAppBar() {
    return AppBar(
      backgroundColor: AppColors.white,
      elevation: 0,
      title: Row(
        children: [
          const CustomImage(
            imageSrc: 'assets/icons/logo_small.svg', // Placeholder logo
            height: 24,
            width: 24,
          ),
          SizedBox(width: 8.w),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CustomText(
                text: "Hello Sheena",
                fontWeight: FontWeight.w600,
                fontSize: 18.w,
                color: AppColors.black_02,
              ),
              CustomText(
                text: "Welcome to Crave Crusher",
                fontWeight: FontWeight.w400,
                fontSize: 12.w,
                color: AppColors.softWhite,
              ),
            ],
          ),
        ],
      ),
      actions: [
        Padding(
          padding: EdgeInsets.only(right: 16.w),
          child: const Icon(Icons.notifications, color: AppColors.black),
        ),
      ],
    );
  }
}

// SOLID Principle (SRP): Ei widget-ti shudhu Tip o Monster UI render korar kaaj korche.
class _TipAndMonsterSection extends StatelessWidget {
  const _TipAndMonsterSection();

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Tip for Today Title
        Padding(
          padding: EdgeInsets.only(bottom: 12.h),
          child: const Row(
            children: [
              Icon(Icons.lightbulb_outline, color: AppColors.black),
              SizedBox(width: 8),
              CustomText(
                text: "Tip for Today",
                fontWeight: FontWeight.w600,
                fontSize: 18,
              ),
            ],
          ),
        ),

        // Tip Card
        Container(
          padding: EdgeInsets.all(16.w),
          decoration: BoxDecoration(
            color: AppColors.subPrimary.withOpacity(0.5), // Lighter shade
            borderRadius: BorderRadius.circular(12),
          ),
          child: CustomText(
            text: 'Tip for Today', // Apni AppStrings e add korte paren
            textAlign: TextAlign.center,
            fontSize: 14.w,
            fontWeight: FontWeight.w600,
            color: AppColors.appTitle, // Darker text color
            maxLines: 5,
            bottom: 0,
            top: 0,
          ),
        ),

        SizedBox(height: 24.h),

        // Your Monster Today Title
        Padding(
          padding: EdgeInsets.only(bottom: 12.h),
          child: const Row(
            children: [
              Icon(
                Icons.emoji_objects_outlined,
                color: AppColors.black,
              ), // Placeholder icon
              SizedBox(width: 8),
              CustomText(
                text: "Your Monster Today",
                fontWeight: FontWeight.w600,
                fontSize: 18,
              ),
            ],
          ),
        ),

        // Monster Image
        Center(
          child: CustomImage(
            imageSrc: 'assets/images/monster.png', // Placeholder Monster PNG
            height: 200.h,
            width: 200.w,
            imageType: ImageType.png,
          ),
        ),

        // Monster Status Button (Using CustomButton for structure)
        CustomButton(
          title: "Your Monster Is Losing Power — Keep It Up!",
          onTap: () {}, // No logic, just placeholder
          height: 40.h,
          width: double.maxFinite,
          fillColor: AppColors.statusshiping.withOpacity(0.5), // Light Green
          textColor: AppColors.black,
          borderRadius: 8,
          fontSize: 14.w,
          fontWeight: FontWeight.w500,
        ),
      ],
    );
  }
}

// SOLID Principle (OCP, ISP): Highly reusable component with minimal, necessary parameters.
class _ActiveBattleCard extends StatelessWidget {
  final String iconSrc;
  final String title;
  final double progress;
  final String status;
  final String dayCount;
  final Color statusColor;

  const _ActiveBattleCard({
    required this.iconSrc,
    required this.title,
    required this.progress,
    required this.status,
    required this.dayCount,
    required this.statusColor,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(12.w),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: AppColors.black.withOpacity(0.05),
            spreadRadius: 1,
            blurRadius: 5,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              // Icon and Title
              Row(
                children: [
                  CustomImage(imageSrc: iconSrc, height: 24.h, width: 24.w),
                  SizedBox(width: 10.w),
                  CustomText(
                    text: title,
                    fontWeight: FontWeight.w600,
                    fontSize: 16,
                    color: AppColors.appTitle,
                    bottom: 0,
                    top: 0,
                  ),
                ],
              ),
              // Status Badge
              Container(
                padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 4.h),
                decoration: BoxDecoration(
                  color: statusColor.withOpacity(0.2),
                  borderRadius: BorderRadius.circular(16),
                ),
                child: CustomText(
                  text: "* $status",
                  fontSize: 12.w,
                  fontWeight: FontWeight.w500,
                  color: statusColor,
                  bottom: 0,
                  top: 0,
                ),
              ),
            ],
          ),

          SizedBox(height: 10.h),

          // Progress Text (58% to complete)
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              CustomText(
                text: "${(progress * 100).toInt()}% to complete",
                fontSize: 14.w,
                fontWeight: FontWeight.w500,
                color: AppColors.black,
                bottom: 0,
                top: 0,
              ),
              CustomText(
                text: dayCount,
                fontSize: 12.w,
                fontWeight: FontWeight.w400,
                color: AppColors.softWhite,
                bottom: 0,
                top: 0,
              ),
            ],
          ),

          SizedBox(height: 8.h),

          // Progress Bar
          LinearProgressIndicator(
            value: progress,
            backgroundColor: AppColors.subPrimary.withOpacity(0.5),
            valueColor: AlwaysStoppedAnimation<Color>(AppColors.primary),
            minHeight: 8.h,
            borderRadius: BorderRadius.circular(4.r),
          ),

          SizedBox(height: 12.h),

          // Open Battle Button
          CustomButton(
            onTap: () {}, // Logic will be implemented here
            title: "Open Battle",
            height: 35.h,
            width: 150.w, // Fixed width for button
            fillColor: AppColors.subPrimary,
            textColor: AppColors.primary,
            borderRadius: 8,
            fontSize: 14.w,
            fontWeight: FontWeight.w600,
          ),
        ],
      ),
    );
  }
}
