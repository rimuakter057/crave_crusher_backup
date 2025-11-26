import 'package:crave_crusher/view/features/community/controllers/community_tab_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:crave_crusher/utils/app_colors/app_colors.dart';
import 'package:crave_crusher/view/components/custom_text/custom_text.dart';
import 'package:get/get.dart';

class CommunityTabSelector extends StatelessWidget {
  final Function(int)? onTabChanged; // callback for parent
  final List<String> _tabs = ["All Feed", "My Posts"];

  CommunityTabSelector({super.key, this.onTabChanged});

  @override
  Widget build(BuildContext context) {
    final CommunityTabController controller = Get.find<CommunityTabController>();

    return GetBuilder<CommunityTabController>(
      builder: (_) {
        return Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: List.generate(_tabs.length, (index) {
            final isSelected = index == controller.communityTabIndex;
            final tabTitle = _tabs[index];

            return Expanded(
              child: GestureDetector(
                onTap: () {
                  controller.changeTab(index); // update controller
                  if (onTabChanged != null) {
                    onTabChanged!(index); // notify parent
                  }
                },
                child: AnimatedContainer(
                  duration: const Duration(milliseconds: 200),
                  height: 36.h,
                  margin: EdgeInsets.symmetric(horizontal: 4.w),
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    color: isSelected
                        ? AppColors.primary
                        : AppColors.subPrimary.withAlpha(80),
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
                    fontWeight:
                    isSelected ? FontWeight.w600 : FontWeight.w500,
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
      },
    );
  }
}
