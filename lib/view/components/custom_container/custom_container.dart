import 'package:flutter/material.dart';

class CustomContainer extends StatelessWidget {
  final Widget child; // Required
  final Color? backgroundColor;
  final Color? borderColor;
  final double? radius;
  final double? width;
  final double? height;
  final double? padding;
  final EdgeInsetsGeometry? margin;

  const CustomContainer({
    super.key,
    required this.child,
    this.backgroundColor,
    this.borderColor,
    this.radius,
    this.width,
    this.height,
    this.padding,
    this.margin,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(padding??8),
      width: width,
      height:height,
      margin: margin,
      decoration: BoxDecoration(
        color: backgroundColor ?? Colors.white,
        borderRadius: BorderRadius.circular(radius ?? 8),
        border: Border.all(
          color: borderColor ?? Colors.transparent,
        ),
      ),
      child: child,
    );
  }
}
