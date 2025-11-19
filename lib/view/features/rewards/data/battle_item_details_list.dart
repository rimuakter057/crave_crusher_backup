import 'dart:ui';

import 'package:crave_crusher/utils/app_icons/app_icons.dart';

class BattleItemDetailsModel {
  final String title;
  final String icon;
  final Color backgroundColor;
  final Color borderColor;
  final String subTitle;
  BattleItemDetailsModel({
    required this.title,
    required this.icon,
    required this.backgroundColor,
    required this.borderColor,
    required this.subTitle,

  });
}




final List<BattleItemDetailsModel> battleDetailItems = [
  BattleItemDetailsModel(

    title: "Focus Fighter",
    subTitle: "Day 15 of 15",
    icon: AppIcons.focusFighter,
    backgroundColor: Color(0xFFF7FEE7),
    borderColor: Color(0xFF84CC16),
  ),
  BattleItemDetailsModel(
    title: "Victory Streaker",
    subTitle: "Day 30",
    icon: AppIcons.victoryStreaker,
    backgroundColor: Color(0xFFECFDF5),
    borderColor: Color(0xFF10B981),
  ),
  BattleItemDetailsModel(
    title: "Milestone Achiever",
    subTitle: "Day 60",
    icon: AppIcons.milestoneAchiever,
    backgroundColor: Color(0xFFECFEFF),
    borderColor: Color(0xFF06B6D4),
  ),
  BattleItemDetailsModel(
    title: "Positive Powerhouse",
    subTitle: "Day 90",
    icon: AppIcons.positivePowerHouse,
    backgroundColor: Color(0xFFEFF6FF),
    borderColor: Color(0xFF3B82F6),
  ),

  BattleItemDetailsModel(
    title: "CC Legend",
    subTitle: "Day 100",
    icon: AppIcons.ccLegend,
    backgroundColor: Color(0xFFFAF5FF),
    borderColor: Color(0xFFA855F7),
  ),


];
