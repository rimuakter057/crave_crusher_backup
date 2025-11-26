

import 'package:crave_crusher/view/features/community/controllers/community_tab_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:crave_crusher/utils/app_colors/app_colors.dart';
import 'package:crave_crusher/view/components/custom_text/custom_text.dart';
import 'package:get/get.dart';


class CommunityTabSelector extends StatefulWidget {
  final Function(int)? onTabChanged; // callback for parent

  const CommunityTabSelector({super.key, this.onTabChanged});

  @override
  State<CommunityTabSelector> createState() => _CommunityTabSelectorState();
}

class _CommunityTabSelectorState extends State<CommunityTabSelector> {
  final List<String> _tabs = ["All Feed", "My Posts"];
  final CommunityTabController controller=Get.find<CommunityTabController>();
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
                controller.communityTabIndex.value=index;
              });
              if (widget.onTabChanged != null) {
                widget.onTabChanged!(index); // notify parent
              }
            },
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 200),
              height: 36.h,
              margin: EdgeInsets.symmetric(horizontal: 4.w),
              alignment: Alignment.center,
              decoration: BoxDecoration(
                color: isSelected ? AppColors.primary : AppColors.subPrimary.withAlpha(80),
                borderRadius: BorderRadius.circular(8.r),
                border: isSelected
                    ? null
                    : Border.all(
                  color: AppColors.subPrimary.withOpacity(0.5),
                  width: 1.w,
                ),
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