import 'package:crave_crusher/utils/app_colors/app_colors.dart';
import 'package:crave_crusher/utils/app_strings/app_strings.dart';
import 'package:flutter/material.dart';

Color getBadgeBorderColor(String title) {
  switch (title) {
    case AppText.ccLegend:
      return AppColors.ccBoarder;
    case AppText.positivePowerhouse:
      return AppColors.positiveBoarder;
    case AppText.milestoneAchiever:
      return AppColors.milestoneBoarder;
    case AppText.victoryStreaker:
      return AppColors.victoryBoarder;
    case AppText.focusFighter:
      return AppColors.focusBoarder;
    case AppText.monsterMaster:
      return AppColors.monsterBoarder;
    case AppText.consistencyChamp:
      return AppColors.consistencyBoarder;
    case AppText.starterSpark:
      return AppColors.starterBoarder;
    default:
      return Colors.grey.shade100;
  }
}

Color getBadgeBgColor(String title) {
  switch (title) {
    case AppText.ccLegend:
      return AppColors.ccBg;
    case AppText.positivePowerhouse:
      return AppColors.positiveBg;
    case AppText.milestoneAchiever:
      return AppColors.milestoneBg;
    case AppText.victoryStreaker:
      return AppColors.victoryBg;
    case AppText.focusFighter:
      return AppColors.focusBg;
    case AppText.monsterMaster:
      return AppColors.monsterBg;
    case AppText.consistencyChamp:
      return AppColors.ccBg;
    case AppText.starterSpark:
      return AppColors.ccBg;
    default:
      return Colors.grey.shade100;
  }
}
