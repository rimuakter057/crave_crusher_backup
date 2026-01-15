import 'package:crave_crusher/utils/app_colors/app_colors.dart';
import 'package:crave_crusher/utils/app_strings/app_strings.dart';
import 'package:flutter/material.dart';

Color getBadgeBorderColor(String title) {
  switch (title) {
    case AppStrings.ccLegend:
      return AppColors.ccBoarder;
    case AppStrings.positivePowerhouse:
      return AppColors.positiveBoarder;
    case AppStrings.milestoneAchiever:
      return AppColors.milestoneBoarder;
    case AppStrings.victoryStreaker:
      return AppColors.victoryBoarder;
    case AppStrings.focusFighter:
      return AppColors.focusBoarder;
    case AppStrings.monsterMaster:
      return AppColors.monsterBoarder;
    case AppStrings.consistencyChamp:
      return AppColors.consistencyBoarder;
    case AppStrings.starterSpark:
      return AppColors.starterBoarder;
    default:
      return Colors.grey.shade100;
  }
}

Color getBadgeBgColor(String title) {
  switch (title) {
    case AppStrings.ccLegend:
      return AppColors.ccBg;
    case AppStrings.positivePowerhouse:
      return AppColors.positiveBg;
    case AppStrings.milestoneAchiever:
      return AppColors.milestoneBg;
    case AppStrings.victoryStreaker:
      return AppColors.victoryBg;
    case AppStrings.focusFighter:
      return AppColors.focusBg;
    case AppStrings.monsterMaster:
      return AppColors.monsterBg;
    case AppStrings.consistencyChamp:
      return AppColors.ccBg;
    case AppStrings.starterSpark:
      return AppColors.ccBg;
    default:
      return Colors.grey.shade100;
  }
}
