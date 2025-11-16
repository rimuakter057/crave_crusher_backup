import 'package:crave_crusher/view/components/custom_text/custom_text.dart';
import 'package:crave_crusher/view/components/custom_text_field/custom_text_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';


class InputFieldWithTitleWidget extends StatelessWidget {
  const InputFieldWithTitleWidget({
    super.key, required this.title, required this.hintText,
  });
  final String title;
  final String hintText;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CustomText(text: title,fontSize: 14.sp,fontWeight: FontWeight.w500,),
        Gap(8.h),
        CustomTextField(
          fillColor: Color(0xFFEEF2FF),
          hintText:hintText ,
          hintStyle: TextStyle(
              fontSize: 14.sp,
              color: Color(0xFFA1A1AA)
          ),


        ),
      ],
    );
  }
}