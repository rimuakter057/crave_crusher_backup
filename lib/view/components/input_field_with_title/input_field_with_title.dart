import 'package:crave_crusher/view/components/custom_text/custom_text.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../utils/app_colors/app_colors.dart';
import '../custom_text_field/custom_text_field.dart';

class InputPasswordFieldWidget extends StatefulWidget {
  const InputPasswordFieldWidget({
    super.key,
    required this.title,
    this.controller,
    this.validator,
    this.readOnly,
    this.isTablet = false,
    this.hintText,
  });

  final String title;
  final TextEditingController? controller;
  final String? Function(String?)? validator;
  final bool? readOnly;
  final bool isTablet;
  final String? hintText;

  @override
  State<InputPasswordFieldWidget> createState() =>
      _InputPasswordFieldWidgetState();
}

class _InputPasswordFieldWidgetState extends State<InputPasswordFieldWidget> {
  bool _obscureText = true;

  @override
  Widget build(BuildContext context) {
    final double titleFontSize = widget.isTablet ? 16.0 : 14.0;
    final double hintFontSize = widget.isTablet ? 16.0 : 14.0;
    final double gapSize = widget.isTablet ? 10.0 : 8.0;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CustomText(
          text: widget.title,
          fontSize: titleFontSize,
          fontWeight: FontWeight.w500,
        ),
        Gap(gapSize),
        CustomTextField(
          readOnly: widget.readOnly ?? false,
          textEditingController: widget.controller,
          fillColor: AppColors.naveBordar,
          isPassword: _obscureText,
          hintText: widget.hintText ?? "Enter Your Password",
          hintStyle: GoogleFonts.syne(
            fontSize: hintFontSize,
            color: const Color(0xFFA1A1AA),
          ),
          validator: widget.validator,
          suffixIcon: IconButton(
            onPressed: () {
              setState(() {
                _obscureText = !_obscureText;
              });
            },
            icon: Icon(
              _obscureText ? Icons.visibility_off : Icons.visibility,
              color: Colors.grey,
            ),
          ),
        ),
      ],
    );
  }
}

class InputFieldWithTitleWidget extends StatelessWidget {
  const InputFieldWithTitleWidget({
    super.key,
    required this.title,
    required this.hintText,
    this.controller,
    this.validator,
    this.readOnly,
    this.isTablet = false,
  });

  final String title;
  final String hintText;
  final TextEditingController? controller;
  final String? Function(String?)? validator;
  final bool? readOnly;
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
        Gap(gapSize),
        CustomTextField(
          readOnly: readOnly ?? false,
          textEditingController: controller,
          fillColor: AppColors.naveBordar,
          hintText: hintText,
          hintStyle: GoogleFonts.syne(
            fontSize: hintFontSize,
            color: const Color(0xFFA1A1AA),
          ),
          validator: validator,
        ),
      ],
    );
  }
}

// class InputFieldWithTitleWidget extends StatelessWidget {
//   const InputFieldWithTitleWidget({
//     super.key,
//     required this.title,
//     required this.hintText,
//     this.controller,
//     this.validator,
//     this.readOnly,
//   });
//   final String title;
//   final String hintText;
//   final TextEditingController? controller;
//   final String? Function(String?)? validator;
//   final bool? readOnly;

//   @override
//   Widget build(BuildContext context) {
//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         CustomText(text: title, fontSize: 14.sp, fontWeight: FontWeight.w500),
//         Gap(8.h),
//         CustomTextField(
//           readOnly: readOnly ?? false,
//           textEditingController: controller,
//           fillColor: AppColors.naveBordar,
//           hintText: hintText,
//           hintStyle: GoogleFonts.syne(
//             fontSize: 14.sp,
//             color: Color(0xFFA1A1AA),
//           ),
//           validator: validator,
//         ),
//       ],
//     );
//   }
// }
