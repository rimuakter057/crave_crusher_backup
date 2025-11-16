import 'dart:ui';

import 'package:crave_crusher/utils/app_icons/app_icons.dart';

class BattleItemModel {
  final String title;
  final String icon;
  final Color backgroundColor;
  final Color borderColor;

  BattleItemModel({
    required this.title,
    required this.icon,
    required this.backgroundColor,
    required this.borderColor,
  });
}




final List<BattleItemModel> battleItems = [
  BattleItemModel(
    title: "Starter Spark",
    icon: AppIcons.battle,
    backgroundColor: Color(0xFFFEE2E2),
    borderColor: Color(0xFFEF4444),
  ),
  BattleItemModel(
    title: "Consistency\nChamp",
    icon: AppIcons.battle,
    backgroundColor: Color(0xFFFFF7ED),
    borderColor: Color(0xFFF97316),
  ),
  BattleItemModel(
    title: "Monster\nMaster",
    icon: AppIcons.battle,
    backgroundColor: Color(0xFFFEFCE8),
    borderColor: Color(0xFFFACC15),
  ),
  BattleItemModel(
    title: "Starter Spark",
    icon: AppIcons.battle,
    backgroundColor: Color(0xFFF7FEE7),
    borderColor: Color(0xFF84CC16),
  ),

];
