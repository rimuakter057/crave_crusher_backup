import 'package:crave_crusher/view/components/custom_text/custom_text.dart';
import 'package:crave_crusher/view/components/custom_text_field/custom_text_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../utils/app_colors/app_colors.dart';

class InputFieldWithTitleWidget extends StatelessWidget {
  const InputFieldWithTitleWidget({
    super.key,
    required this.title,
    required this.hintText,
    this.controller,
    this.validator,
    this.readOnly,
  });
  final String title;
  final String hintText;
  final TextEditingController? controller;
  final String? Function(String?)? validator;
  final bool? readOnly;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CustomText(text: title, fontSize: 14.sp, fontWeight: FontWeight.w500),
        Gap(8.h),
        CustomTextField(
          readOnly: readOnly ?? false,
          textEditingController: controller,
          fillColor: AppColors.naveBordar,
          hintText: hintText,
          hintStyle: GoogleFonts.syne(
            fontSize: 14.sp,
            color: Color(0xFFA1A1AA),
          ),
          validator: validator,
        ),
      ],
    );
  }
}
