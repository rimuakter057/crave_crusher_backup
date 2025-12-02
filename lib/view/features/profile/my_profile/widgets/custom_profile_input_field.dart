import 'package:crave_crusher/utils/app_colors/app_colors.dart';
import 'package:crave_crusher/view/components/custom_text/custom_text.dart';
import 'package:crave_crusher/view/components/custom_text_field/custom_text_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

class CustomProfileInputField extends StatelessWidget {
  const CustomProfileInputField({
    super.key, required this.title, required this.text,
  });

  final String title;
final String text;


  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 82.h,
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
           SizedBox(height: 8.h,),
          CustomText(
            text: text,

            color: Colors.grey.shade400,
          ),
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