// ignore_for_file: deprecated_member_use

import 'package:crave_crusher/utils/app_colors/app_colors.dart';
import 'package:crave_crusher/utils/app_icons/app_icons.dart';
import 'package:crave_crusher/view/components/custom_app_bar/custom_app_bar.dart';
import 'package:crave_crusher/view/components/custom_button/custom_button.dart';
import 'package:crave_crusher/view/components/custom_image/custom_image.dart';
import 'package:crave_crusher/view/components/custom_text/custom_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:get/get.dart';
import '../../../components/custom_loader/custom_loader.dart';
import '../battle_screen.dart';
import '../controller/battle_controller.dart';


class UpdateBattleScreen extends StatefulWidget {
  const UpdateBattleScreen({super.key, required this.battleId});
final String battleId;
  @override
  State<UpdateBattleScreen> createState() => _StartNewBattleScreenState();
}

class _StartNewBattleScreenState extends State<UpdateBattleScreen> {
  String? _selectedType;
  String? _selectedLevel;
  final TextEditingController _daysController = TextEditingController();
  final TextEditingController _reasonController = TextEditingController();
  bool? _sendReminder = true; // Default to Yes
  final BattleController controller = Get.find<BattleController>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
      appBar: CustomAppBar(title: 'Update Battle', actions: []),
      body: SingleChildScrollView(
        padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 16.h),
        child:Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            /// 1. Addiction Type Dropdown=========================================================================
            _CustomDropdownField(
              label: "Addiction Type",
              hint: "Select an addiction to battle",
              items: controller.addictionTypes,
              selectedValue: controller.selectedType.value,
              onChanged: (val) => controller.selectedType.value = val,
            ),

            /// 2. Addiction Level Dropdown===============================================================
            _CustomDropdownField(
              label: "Addiction Level",
              hint: "Select an addiction level",
              items: controller.addictionLevels,
              selectedValue: controller.selectedLevel.value,
              onChanged: (val) => controller.selectedLevel.value = val,
            ),

            /// 3. Battle Duration Input=========================================================
            CustomText(
              text: "How Many Days Will This Battle Last?",
              fontWeight: FontWeight.w600,
              fontSize: 16,
              bottom: 8.h,
            ),

            ///day selected================================================================
            TextField(
              controller: controller.daysController,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                hintText: "Enter number of days (e.g., 7, 14, 30)",
                hintStyle: GoogleFonts.syne(
                  color: AppColors.softWhite,
                  fontSize: 14.sp,
                ),
                contentPadding: EdgeInsets.symmetric(
                  horizontal: 16.w,
                  vertical: 12.h,
                ),
                filled: true,
                fillColor: AppColors.subPrimary.withOpacity(0.4),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10.r),
                  borderSide: BorderSide.none,
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10.r),
                  borderSide: BorderSide.none,
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10.r),
                  borderSide: BorderSide(color: AppColors.primary, width: 2.w),
                ),
              ),
            ),

            SizedBox(height: 24.h),

            /// 4. Send Reminder Radio Group
            Obx(() {
              return _ReminderRadioGroup(
                selectedValue: controller.sendReminder.value,
                onChanged: (val) => controller.sendReminder.value = val!,
              );
            }),

            /// 5. Reason Text Area==============================================================
            CustomText(
              text: "Why Are You Starting This Battle?",
              fontWeight: FontWeight.w600,
              fontSize: 16,
              bottom: 8.h,
            ),
            TextField(
              controller: controller.reasonController,
              decoration: InputDecoration(
                hintText: "I want to feel healthier and more focused.",
                hintStyle: GoogleFonts.syne(
                  color: AppColors.softWhite,
                  fontSize: 14.sp,
                ),
                contentPadding: EdgeInsets.all(16.w),
                filled: true,
                fillColor: AppColors.subPrimary.withOpacity(0.4),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10.r),
                  borderSide: BorderSide.none,
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10.r),
                  borderSide: BorderSide.none,
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10.r),
                  borderSide: BorderSide(color: AppColors.primary, width: 2.w),
                ),
              ),
            ),
            SizedBox(height: 40.h),

            ///button section======================================
            Obx(() {
              return GestureDetector(
                onTap:
                controller.isLoadingCancelBattle.value
                    ? null
                    : () async {
                  final success = await controller.cancelBattle(widget.battleId);
                  if (success){
                    Get.to(BattleScreen());
                    controller.fetchAllBattle("active");
                  }
                },
                child:
                controller.isLoadingCancelBattle.value
                    ? CustomLoader()
                    : _buildButtonContainer(
                              bgColor: AppColors.red100,
                              text: "Cancel Battle",
                              icon: AppIcons.battle, textColor: AppColors.red500, iconColor: AppColors.red500,
                            ),
              );







            }),

            SizedBox(height: 20.h),
          ],
        ),


      ),
    );
  }

  Container _buildButtonContainer({
    required Color bgColor,
    required String text,
    required String icon,
    required Color textColor,
    required Color iconColor,
  }) {
    return Container(
      height: 40.h,
      width: 140.w,
      decoration: BoxDecoration(
        color: bgColor,
        borderRadius: BorderRadius.circular(8.r),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          CustomImage(
            imageSrc: icon,
            imageColor: iconColor,
          ),
          CustomText(
            text: text,
            fontSize: 12.w,
            fontWeight: FontWeight.w600,
            color:textColor,
            bottom: 0,
            top: 0,
          ),
        ],
      ),
    );
  }

}

// --- DYNAMIC DATA LISTS ---
const List<String> addictionTypes = [
  'Smoking Detox',
  'Saving Money Battle',
  'Social Media Detox',
  'Toxic Relationship Battle',
  'Shopping Detox',
  'Junk Food Battle',
];

const List<String> addictionLevels = [
  'Very Low',
  'Low',
  'Medium',
  'High',
  'Very High',
];

// --- CUSTOM WIDGETS ---

/// Custom Dropdown Field
class _CustomDropdownField extends StatelessWidget {
  final String label;
  final String hint;
  final List<String> items;
  final String? selectedValue;
  final ValueChanged<String?> onChanged;

  const _CustomDropdownField({
    required this.label,
    required this.hint,
    required this.items,
    required this.selectedValue,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CustomText(
          text: label,
          fontWeight: FontWeight.w600,
          fontSize: 16,
          bottom: 8.h,
        ),
        DropdownButtonFormField<String>(
          value: selectedValue,
          decoration: InputDecoration(
            hintText: hint,
            hintStyle: TextStyle(color: AppColors.softWhite, fontSize: 14.sp),
            contentPadding: EdgeInsets.symmetric(
              horizontal: 16.w,
              vertical: 12.h,
            ),
            filled: true,
            fillColor: AppColors.subPrimary.withOpacity(0.4),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10.r),
              borderSide: BorderSide.none,
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10.r),
              borderSide: BorderSide.none,
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10.r),
              borderSide: BorderSide(color: AppColors.primary, width: 2.w),
            ),
          ),
          isExpanded: true,
          icon: Icon(
            Icons.keyboard_arrow_down,
            color: AppColors.primary,
            size: 24.w,
          ),
          items:
          items.map((String value) {
            return DropdownMenuItem<String>(
              value: value,
              child: CustomText(
                text: value,
                fontSize: 15,
                fontWeight: FontWeight.w500,
                color: AppColors.appTitle,
                bottom: 0,
                top: 0,
              ),
            );
          }).toList(),
          onChanged: onChanged,
        ),
        SizedBox(height: 24.h),
      ],
    );
  }
}

class _ReminderRadioGroup extends StatelessWidget {
  final bool? selectedValue;
  final ValueChanged<bool?> onChanged;

  const _ReminderRadioGroup({
    required this.selectedValue,
    required this.onChanged,
  });

  Widget _buildRadioOption(BuildContext context, bool value, String text) {
    bool isSelected = selectedValue == value;
    return Expanded(
      child: GestureDetector(
        onTap: () => onChanged(value),
        child: Container(
          height: 50.h,
          alignment: Alignment.center,
          decoration: BoxDecoration(
            color:
            isSelected
                ? AppColors.subPrimary
                : AppColors.subPrimary.withOpacity(0.4),
            borderRadius: BorderRadius.circular(10.r),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Radio<bool>(
                value: value,
                groupValue: selectedValue,
                onChanged: onChanged,
                activeColor: AppColors.primary,
                fillColor: MaterialStateProperty.all(
                  isSelected ? AppColors.primary : AppColors.softWhite,
                ),
              ),
              CustomText(
                text: text,
                fontWeight: isSelected ? FontWeight.w600 : FontWeight.w500,
                fontSize: 16,
                color: AppColors.appTitle,
                bottom: 0,
                top: 0,
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CustomText(
          text: "Send Reminder For Battle",
          fontWeight: FontWeight.w600,
          fontSize: 16,
          bottom: 12.h,
        ),
        Row(
          children: [
            _buildRadioOption(context, true, "Yes"),
            SizedBox(width: 16.w),
            _buildRadioOption(context, false, "No"),
          ],
        ),
        SizedBox(height: 24.h),
      ],
    );
  }
}
