import 'package:crave_crusher/helper/responsive_helper/responsive_helper.dart';
import 'package:crave_crusher/utils/app_colors/app_colors.dart';
import 'package:crave_crusher/view/components/custom_text/custom_text.dart';
import 'package:flutter/material.dart';

class CustomProfileInputField extends StatelessWidget {
  const CustomProfileInputField({
    super.key,
    required this.title,
    required this.text,
  });

  final String title;
  final String text;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: ResponsiveHelper.height(82),
      padding: EdgeInsets.symmetric(
        horizontal: ResponsiveHelper.padding(12),
        vertical: ResponsiveHelper.padding(8),
      ),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey.shade200), // Grey border
        borderRadius: BorderRadius.circular(
          ResponsiveHelper.borderRadius(8),
        ), // Rounded corners
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CustomText(text: title, color: AppColors.primary),
          SizedBox(height: ResponsiveHelper.height(8)),
          CustomText(text: text, color: Colors.grey.shade400),

          // CustomTextField(
          //   onChanged:onChanged ,
          //   hintText:hintText,
          //   hintStyle: TextStyle(color: Colors.grey.shade400),
          //   fillColor: Colors.transparent,
          // )
        ],
      ),
    );
  }
}
