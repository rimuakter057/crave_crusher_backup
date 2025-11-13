// ignore_for_file: deprecated_member_use

import 'package:crave_crusher/utils/app_colors/app_colors.dart';
import 'package:crave_crusher/view/components/custom_text/custom_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class BattleTabSelector extends StatefulWidget {
  const BattleTabSelector({super.key});

  @override
  State<BattleTabSelector> createState() => _BattleTabSelectorState();
}

class _BattleTabSelectorState extends State<BattleTabSelector> {
  // Available tab options
  final List<String> _tabs = ["Active Battles", "Completed", "Canceled"];

  // Currently selected tab index (Default to 'Active Battles')
  int _selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: List.generate(_tabs.length, (index) {
        final isSelected = index == _selectedIndex;
        final tabTitle = _tabs[index];

        return Expanded(
          child: GestureDetector(
            onTap: () {
              setState(() {
                _selectedIndex = index;
              });
              // Ekhane apni chaile kono callback function add korte paren
              // jeta parent widget-ke janabe kon tab select hoyeche.
            },
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 200),
              // Design e tab gulo besh choto, tai height 36.h dewa holo
              height: 36.h,
              margin: EdgeInsets.symmetric(horizontal: 4.w),
              alignment: Alignment.center,
              decoration: BoxDecoration(
                color:
                    isSelected
                        ? AppColors.primary
                        : AppColors.subPrimary.withAlpha(80),
                borderRadius: BorderRadius.circular(8.r),
                border:
                    isSelected
                        ? null
                        : Border.all(
                          color: AppColors.subPrimary.withOpacity(0.5),
                          width: 1.w,
                        ), // Unselected tab-e halka border
              ),
              child: CustomText(
                text: tabTitle,
                // Font size choto hobe jate shob 3 ta tab shoman jaygaye dhore
                fontSize: 12.sp,
                fontWeight: isSelected ? FontWeight.w600 : FontWeight.w500,
                color: isSelected ? AppColors.white : AppColors.black,
                textAlign: TextAlign.center,
                left: 0,
                right: 0,
              ),
            ),
          ),
        );
      }),
    );
  }
}
