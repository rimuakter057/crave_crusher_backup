import 'package:crave_crusher/utils/app_colors/app_colors.dart';
import 'package:crave_crusher/view/components/custom_text/custom_text.dart';
import 'package:crave_crusher/view/components/custom_text_field/custom_text_field.dart';
import 'package:flutter/material.dart';

class CustomProfileInputField extends StatelessWidget {
  const CustomProfileInputField({
    super.key, required this.title, required this.hintText, this.onChanged,
  });

  final String title;
  final String hintText;
  final void Function(String)? onChanged;
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey.shade200), // Grey border
        borderRadius: BorderRadius.circular(8),           // Rounded corners
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CustomText(
            text: title,
            color: AppColors.primary,
          ),
          CustomTextField(
            onChanged:onChanged ,
            hintText:hintText,
            hintStyle: TextStyle(color: Colors.grey.shade400),
            fillColor: Colors.transparent,
          )


        ],
      ),
    );
  }
}