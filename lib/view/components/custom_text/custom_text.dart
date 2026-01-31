// import 'package:flutter/material.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:google_fonts/google_fonts.dart';

// class CustomText extends StatelessWidget {
//   const CustomText({
//     super.key,
//     this.maxLines,
//     this.textAlign = TextAlign.center,
//     this.left = 0,
//     this.right = 0,
//     this.top = 0,
//     this.bottom = 0,
//     this.fontSize = 16,
//     this.fontWeight = FontWeight.w600,
//     this.color = Colors.black,
//     required this.text,
//     this.overflow = TextOverflow.ellipsis,
//     this.decoration,
//     this.textType,
//     this.textDecorationColor,
//   });

//   final double left;
//   final double right;
//   final double top;
//   final double bottom;
//   final double fontSize;
//   final FontWeight fontWeight;
//   final Color color;
//   final String text;
//   final TextAlign textAlign;
//   final int? maxLines;
//   final TextOverflow overflow;
//   final TextDecoration? decoration;
//   final TextType? textType;
//   final Color? textDecorationColor;

//   @override
//   Widget build(BuildContext context) {
//     return Padding(
//       padding: EdgeInsets.only(
//         left: left,
//         right: right,
//         top: top,
//         bottom: bottom,
//       ),
//       child: Text(
//         textAlign: textAlign,
//         text,
//         maxLines: maxLines,
//         overflow: overflow,
//         style: GoogleFonts.syne(
//           fontSize: textType != null ? setFontSize(textType!) : fontSize.w,
//           fontWeight: textType != null ? setFontWeight(textType!) : fontWeight,
//           color: color,
//           decoration: decoration,
//           decorationColor: textDecorationColor ?? Colors.black,
//           decorationThickness: 2,
//         ),
//       ),
//     );
//   }

//   double setFontSize(TextType type) {
//     switch (type) {
//       case TextType.title:
//         return 16.w;

//       case TextType.subTitle:
//         return 12.w;
//       case TextType.description:
//         return 10.w;
//       case TextType.small:
//         return 14.w;
//       case TextType.h5:
//         return 14.w;
//       case TextType.h6:
//         return 14.w;
//       case TextType.h15500:
//         return 15.w;
//       case TextType.h13500:
//         return 13.w;
//       case TextType.h12500:
//         return 12.w;
//       case TextType.h16600:
//         return 16.w;
//     }
//   }

//   setFontWeight(TextType type) {
//     switch (type) {
//       case TextType.title:
//         return FontWeight.w500;

//       case TextType.subTitle:
//         return FontWeight.w400;
//       case TextType.description:
//         return FontWeight.w400;
//       case TextType.small:
//         return FontWeight.w400;
//       case TextType.h5:
//         return FontWeight.w500;
//       case TextType.h6:
//         return FontWeight.w600;
//       case TextType.h15500:
//         return FontWeight.w500;
//       case TextType.h13500:
//         return FontWeight.w500;
//       case TextType.h12500:
//         return FontWeight.w500;
//       case TextType.h16600:
//         return FontWeight.w600;
//     }
//   }
// }

// enum TextType {
//   title,
//   subTitle,
//   description,
//   small,
//   h5,
//   h6,
//   h15500,
//   h13500,
//   h12500,
//   h16600,
// }
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class CustomText extends StatelessWidget {
  const CustomText({
    super.key,
    this.maxLines,
    this.textAlign = TextAlign.center,
    this.left = 0,
    this.right = 0,
    this.top = 0,
    this.bottom = 0,
    this.fontSize = 16,
    this.fontWeight = FontWeight.w600,
    this.color = Colors.black,
    required this.text,
    this.overflow = TextOverflow.ellipsis,
    this.decoration,
    this.textType,
    this.textDecorationColor,
  });

  final double left;
  final double right;
  final double top;
  final double bottom;
  final double fontSize;
  final FontWeight fontWeight;
  final Color color;
  final String text;
  final TextAlign textAlign;
  final int? maxLines;
  final TextOverflow overflow;
  final TextDecoration? decoration;
  final TextType? textType;
  final Color? textDecorationColor;

  /// Get responsive font size based on screen width
  double _getResponsiveFontSize(BuildContext context, double baseFontSize) {
    final screenWidth = MediaQuery.of(context).size.width;
    final isTablet = screenWidth > 600;

    if (!isTablet) {
      return baseFontSize;
    }

    // For tablets, scale up appropriately
    if (screenWidth > 800) {
      // iPad Pro
      return baseFontSize * 1.3;
    } else {
      // iPad mini/regular
      return baseFontSize * 1.15;
    }
  }

  @override
  Widget build(BuildContext context) {
    final responsiveFontSize =
        textType != null
            ? _getResponsiveFontSize(context, setFontSize(textType!))
            : _getResponsiveFontSize(context, fontSize);

    return Padding(
      padding: EdgeInsets.only(
        left: left,
        right: right,
        top: top,
        bottom: bottom,
      ),
      child: Text(
        textAlign: textAlign,
        text,
        maxLines: maxLines,
        overflow: overflow,
        style: GoogleFonts.syne(
          fontSize: responsiveFontSize,
          fontWeight: textType != null ? setFontWeight(textType!) : fontWeight,
          color: color,
          decoration: decoration,
          decorationColor: textDecorationColor ?? Colors.black,
          decorationThickness: 2,
        ),
      ),
    );
  }

  double setFontSize(TextType type) {
    switch (type) {
      case TextType.title:
        return 16;

      case TextType.subTitle:
        return 12;
      case TextType.description:
        return 10;
      case TextType.small:
        return 14;
      case TextType.h5:
        return 14;
      case TextType.h6:
        return 14;
      case TextType.h15500:
        return 15;
      case TextType.h13500:
        return 13;
      case TextType.h12500:
        return 12;
      case TextType.h16600:
        return 16;
    }
  }

  FontWeight setFontWeight(TextType type) {
    switch (type) {
      case TextType.title:
        return FontWeight.w500;

      case TextType.subTitle:
        return FontWeight.w400;
      case TextType.description:
        return FontWeight.w400;
      case TextType.small:
        return FontWeight.w400;
      case TextType.h5:
        return FontWeight.w500;
      case TextType.h6:
        return FontWeight.w600;
      case TextType.h15500:
        return FontWeight.w500;
      case TextType.h13500:
        return FontWeight.w500;
      case TextType.h12500:
        return FontWeight.w500;
      case TextType.h16600:
        return FontWeight.w600;
    }
  }
}

enum TextType {
  title,
  subTitle,
  description,
  small,
  h5,
  h6,
  h15500,
  h13500,
  h12500,
  h16600,
}
