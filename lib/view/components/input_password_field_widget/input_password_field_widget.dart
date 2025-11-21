import 'package:crave_crusher/view/components/custom_text/custom_text.dart';
import 'package:crave_crusher/view/components/custom_text_field/custom_text_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';


class InputPasswordFieldWidget extends StatelessWidget {
  const InputPasswordFieldWidget({
    super.key, required this.title, this.hintText,
  });

  final String title;
 final String ?hintText;
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CustomText(text: title,fontSize: 14.sp,fontWeight: FontWeight.w500,),
        Gap(8.h),
        CustomTextField(
          isPassword: true,
          hintText:hintText?? "Enter Your Password",
          fillColor: Color(0xFFEEF2FF),
          hintStyle: TextStyle(
            fontSize: 14,
            color: Color(0xFFA1A1AA),
          ),
        ),

      ],
    );
  }
}