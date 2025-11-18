import 'package:crave_crusher/utils/app_colors/app_colors.dart';
import 'package:crave_crusher/utils/app_icons/app_icons.dart';
import 'package:crave_crusher/view/components/custom_container/custom_container.dart';
import 'package:crave_crusher/view/components/custom_image/custom_image.dart';
import 'package:crave_crusher/view/components/custom_nav_bar/navbar.dart';
import 'package:crave_crusher/view/components/custom_text/custom_text.dart';
import 'package:crave_crusher/view/features/rewards/widgets/custom_circular_indicator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'data/battle_category_item_list.dart';
import 'data/battle_item_details_list.dart';

class RewardsScreen extends StatelessWidget {
  const RewardsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: NavBar(currentIndex: 3),
      appBar: AppBar(
        surfaceTintColor: AppColors.backgroundColor,
        backgroundColor: AppColors.backgroundColor,
        leading: Center(
          child: Container(
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
        ),
        centerTitle: true,
        title: CustomText(
          text: "Rewards",
          fontSize: 18.sp,
          fontWeight: FontWeight.w500,
        ),
      ),

      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // 70%
              Center(
                child: CustomCircularIndicator(
                  percentText: '70%',
                  percent: 0.7,
                ),
              ),
              Gap(24.h),

              ///show progress
              CustomText(
                text: "Ongoing Progress",
                fontSize: 14,
                fontWeight: FontWeight.w500,
              ),
              Gap(8.h),
              CustomContainer(
                borderColor: AppColors.subPrimary,
                width: double.infinity,
                padding: 16,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    ///focus fighter text
                    Row(
                      children: [
                        Container(
                          height: 30.h,
                          width: 30.w,
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                            color: Color(0xFFF7FEE7),
                            border: Border.all(color: Color(0xFF84CC16)),
                            borderRadius: BorderRadius.circular(3),
                          ),
                          child: CustomImage(
                            imageSrc: AppIcons.battlePng,
                            height: 22.h,
                            width: 22.w,
                          ),
                        ),
                        Gap(8.w),
                        CustomText(
                          text: "Focus Fighter",
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        CustomImage(
                          imageSrc: AppIcons.alarm,
                          height: 12.h,
                          width: 12.w,
                        ),
                        Gap(8.w),
                        CustomText(
                          text: "Day 3 of 10",
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                          color: Color(0xFFA1A1AA),
                        ),
                      ],
                    ),
                  ],
                ),
              ),

              ///gain badge category section
              Gap(24.h),
              CustomText(
                text: "Gained Badges",
                fontSize: 14,
                fontWeight: FontWeight.w500,
              ),
              Gap(8.h),
              SizedBox(
                height: 82.h,
                child: ListView.separated(
                  scrollDirection: Axis.horizontal,
                  itemCount: battleCategoryItems.length,
                  separatorBuilder: (_, __) => SizedBox(width: 12.w),

                  itemBuilder: (context, index) {
                    final item = battleCategoryItems[index];

                    return CustomContainer(
                      width: 104.w,
                      height: 82.h,
                      backgroundColor: item.backgroundColor,
                      borderColor: item.borderColor,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          CustomImage(
                            imageSrc: item.icon,
                            height: 32.h,
                            width: 32.w,
                          ),
                          Gap(4.h),

                          CustomText(text: item.title, fontSize: 10),
                        ],
                      ),
                    );
                  },
                ),
              ),

              ///gain badge details section====================================================================
              Gap(24.h),

              CustomText(
                text: "Gained Badges",
                fontSize: 14,
                fontWeight: FontWeight.w500,
              ),
              Gap(8.h),

              ListView.separated(
                shrinkWrap: true,

                physics: NeverScrollableScrollPhysics(),

                itemCount: battleDetailItems.length,
                separatorBuilder: (_, __) => SizedBox(height: 8.h),

                itemBuilder: (context, index) {
                  final itemDetails = battleDetailItems[index];
                  return CustomContainer(
                    borderColor: AppColors.subPrimary,
                    width: double.infinity,
                    padding: 12,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        ///focus fighter text
                        Expanded(
                          child: Row(
                            children: [
                              Container(
                                height: 30.h,
                                width: 30.w,
                                alignment: Alignment.center,
                                decoration: BoxDecoration(
                                  color: itemDetails.backgroundColor,
                                  border: Border.all(
                                    color: itemDetails.borderColor,
                                  ),
                                  borderRadius: BorderRadius.circular(3),
                                ),
                                child: CustomImage(
                                  imageSrc: AppIcons.battlePng,
                                  height: 22.h,
                                  width: 22.w,
                                ),
                              ),
                              Gap(12.w),
                              CustomText(
                                text: itemDetails.title,
                                fontSize: 14,
                                fontWeight: FontWeight.w500,
                              ),
                            ],
                          ),
                        ),
                        Row(
                          children: [
                            Icon(
                              Icons.lock_outline,
                              size: 14,
                              color: Color(0xFFA1A1AA),
                            ),

                            Gap(4.w),
                            CustomText(
                              text: itemDetails.subTitle,
                              fontSize: 12,
                              fontWeight: FontWeight.w500,
                              color: Color(0xFFA1A1AA),
                            ),
                          ],
                        ),
                      ],
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}


