import 'package:crave_crusher/view/components/custom_text/custom_text.dart';
import 'package:crave_crusher/view/components/custom_text_field/custom_text_field.dart';
import 'package:flutter/material.dart';

class InputPasswordFieldWidget extends StatelessWidget {
  const InputPasswordFieldWidget({
    super.key,
    required this.title,
    this.hintText,
    this.controller,
    this.validator,
    this.isTablet = false,
  });

  final String title;
  final String? hintText;
  final TextEditingController? controller;
  final String? Function(String?)? validator;
  final bool isTablet;

  @override
  Widget build(BuildContext context) {
    final double titleFontSize = isTablet ? 16.0 : 14.0;
    final double hintFontSize = isTablet ? 16.0 : 14.0;
    final double gapSize = isTablet ? 10.0 : 8.0;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CustomText(
          text: title,
          fontSize: titleFontSize,
          fontWeight: FontWeight.w500,
        ),
        SizedBox(height: gapSize),
        CustomTextField(
          textEditingController: controller,
          validator: validator,
          isPassword: true,
          hintText: hintText ?? "Enter Your Password",
          fillColor: const Color(0xFFEEF2FF),
          hintStyle: TextStyle(
            fontSize: hintFontSize,
            color: const Color(0xFFA1A1AA),
          ),
        ),
      ],
    );
  }
}

// import 'package:crave_crusher/view/components/custom_text/custom_text.dart';
// import 'package:crave_crusher/view/components/custom_text_field/custom_text_field.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:gap/gap.dart';

// class InputPasswordFieldWidget extends StatelessWidget {
//   const InputPasswordFieldWidget({
//     super.key,
//     required this.title,
//     this.hintText,
//     this.controller,
//     this.validator,
//   });

//   final String title;
//   final String? hintText;
//   final TextEditingController? controller;
//   final String? Function(String?)? validator;

//   @override
//   Widget build(BuildContext context) {
//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         CustomText(text: title, fontSize: 14.sp, fontWeight: FontWeight.w500),
//         Gap(8.h),
//         CustomTextField(
//           textEditingController: controller,
//           validator: validator,
//           isPassword: true,
//           hintText: hintText ?? "Enter Your Password",
//           fillColor: Color(0xFFEEF2FF),
//           hintStyle: TextStyle(fontSize: 14, color: Color(0xFFA1A1AA)),
//         ),
//       ],
//     );
//   }
// }
