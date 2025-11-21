// ignore_for_file: deprecated_member_use

import 'package:crave_crusher/utils/app_colors/app_colors.dart';
import 'package:crave_crusher/view/components/custom_text/custom_text.dart';
import 'package:crave_crusher/view/features/battle/controller/battle_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class BattleTabSelector extends StatefulWidget {
  const BattleTabSelector({super.key});

  @override
  State<BattleTabSelector> createState() => _BattleTabSelectorState();
}

class _BattleTabSelectorState extends State<BattleTabSelector> {

  final BattleController controller = Get.find<BattleController>();

  final List<String> _tabs = ["Active Battles", "Completed", "Canceled"];


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
                controller.battleTabIndex.value = index;

              });

            },
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 200),

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
