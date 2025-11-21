// ignore_for_file: deprecated_member_use

import 'package:crave_crusher/utils/app_colors/app_colors.dart';
import 'package:crave_crusher/utils/app_icons/app_icons.dart';
import 'package:crave_crusher/view/components/custom_image/custom_image.dart';
import 'package:crave_crusher/view/features/battle/battle_screen.dart';
import 'package:crave_crusher/view/features/community/screens/community_all_feed_screen/community_all_feed_screen.dart';

import 'package:crave_crusher/view/features/home/home_screen.dart';
import 'package:crave_crusher/view/features/profile/profile_screen/profile_screen.dart';
import 'package:crave_crusher/view/features/rewards/rewards_screen.dart';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class NavBar extends StatefulWidget {
  final int currentIndex;

  const NavBar({required this.currentIndex, super.key});

  @override
  State<NavBar> createState() => _NavBarState();
}

class _NavBarState extends State<NavBar> {
  var bottomNavIndex = 0;

  List<String> unselectedIcon = [
    AppIcons.home,
    AppIcons.battle,
    AppIcons.community,
    AppIcons.reward,
    AppIcons.profile,
  ];

  List<IconData> icons = [Icons.language, Icons.person];
  List<IconData> icons2 = [Icons.language_outlined, Icons.person_outline];

  List<String> selectedIcon = [
    AppIcons.selectHome,
    AppIcons.selectedBattale,
    AppIcons.selectCommunity,
    AppIcons.selectReward,
    AppIcons.selectProfile,
  ];
  final List<String> userNavText = [
    // AppStrings.home,
    // AppStrings.rewards,
    // AppStrings.donation,
    // AppStrings.profile
  ];

  @override
  void initState() {
    bottomNavIndex = widget.currentIndex;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(left: 16.0.w, right: 16.w, bottom: 20.h),
      child: Container(
        height: 92.h,
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: Colors.transparent, // AppColors.naveWhite.withOpacity(.6),
          border: Border.all(width: 2, color: AppColors.naveBordar),
          borderRadius: BorderRadius.circular(100.r),
          // borderRadius: BorderRadius.only(topLeft: Radius.circular(15),topRight: Radius.circular(15))
        ),
        width: MediaQuery.of(context).size.width,
        padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 0.h),
        // alignment: Alignment.center,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: List.generate(
            unselectedIcon.length,
            (index) => GestureDetector(
              onTap: () => onTap(index),
              child: Container(
                height: 56.h,
                width: 56.w,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color:
                      index == bottomNavIndex
                          ? AppColors.subPrimary
                          : AppColors.naveWhite,
                ),
                child: CustomImage(
                  imageSrc:
                      index == bottomNavIndex
                          ? selectedIcon[index]
                          : unselectedIcon[index],
                  height: 20.h,
                  width: 20.w,
                  imageColor:
                      index == bottomNavIndex
                          ? AppColors.primary
                          : AppColors.black,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  void onTap(int index) {
    if (index == 0 && widget.currentIndex != 0) {
      Get.offAll(() => HomeScreen());
    } else if (index == 1 && widget.currentIndex != 1) {
      Get.to(() => BattleScreen());
    } else if (index == 2 && widget.currentIndex != 2) {
      Get.to(() => CommunityAllFeedScreen());
    } else if (index == 3 && widget.currentIndex != 3) {
      Get.to(() => RewardsScreen());
    } else if (index == 4 && widget.currentIndex != 4) {
     // Get.to(() => ProfileScreen());
      Get.to(() => ProfileScreen());
    }
  }
}
