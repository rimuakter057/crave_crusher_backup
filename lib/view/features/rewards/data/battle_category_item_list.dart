import 'dart:ui';

import 'package:crave_crusher/utils/app_icons/app_icons.dart';

class BattleCategoryItemModel {
  final String title;
  final String icon;
  final Color backgroundColor;
  final Color borderColor;

  BattleCategoryItemModel({
    required this.title,
    required this.icon,
    required this.backgroundColor,
    required this.borderColor,
  });
}

final List<BattleCategoryItemModel> battleCategoryItems = [
  BattleCategoryItemModel(
    title: "Starter Spark",
    icon: AppIcons.battle,
    backgroundColor: Color(0xFFFEE2E2),
    borderColor: Color(0xFFEF4444),
  ),
  BattleCategoryItemModel(
    title: "Consistency\nChamp",
    icon: AppIcons.consistencyChamp,
    backgroundColor: Color(0xFFFFF7ED),
    borderColor: Color(0xFFF97316),
  ),
  BattleCategoryItemModel(
    title: "Monster\nMaster",
    icon: AppIcons.monsterMaster,
    backgroundColor: Color(0xFFFEFCE8),
    borderColor: Color(0xFFFACC15),
  ),
  BattleCategoryItemModel(
    title: "Starter Spark",
    icon: AppIcons.starSpark,
    backgroundColor: Color(0xFFF7FEE7),
    borderColor: Color(0xFF84CC16),
  ),
];
