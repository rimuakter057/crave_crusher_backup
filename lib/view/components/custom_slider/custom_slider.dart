// ignore_for_file: deprecated_member_use

import 'package:crave_crusher/helper/responsive_helper/responsive_helper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../utils/app_colors/app_colors.dart';

class CustomSlider extends StatefulWidget {
  const CustomSlider({
    super.key,
    this.min,
    this.max,
    this.currentValue,
    this.height,
    this.currentWidth,
  });

  final double? min;
  final double? max;
  final double? currentValue;
  final double? height;
  final double? currentWidth;

  @override
  State<CustomSlider> createState() => _CustomSliderState();
}

class _CustomSliderState extends State<CustomSlider> {
  double width = 0;

  @override
  Widget build(BuildContext context) {
    createMethod();
    return Stack(
      children: [
        Container(
          width: widget.currentWidth ?? MediaQuery.sizeOf(context).width / 3,
          height: widget.height ?? ResponsiveHelper.height(7),
          decoration: BoxDecoration(
            color: AppColors.primary,
            borderRadius: BorderRadius.circular(ResponsiveHelper.borderRadius(10),),
          ),
        ),
        Container(
          height: widget.height ?? ResponsiveHelper.height(7),
          width: width,
          decoration: BoxDecoration(
            color:
                widget.currentValue == null || widget.currentValue == 0
                    ? AppColors.primary
                    : AppColors.subPrimary,
            borderRadius:  BorderRadius.only(
              bottomLeft: Radius.circular(ResponsiveHelper.borderRadius(10),),
              topLeft: Radius.circular(ResponsiveHelper.borderRadius(10),),
            ),
          ),
        ),
      ],
    );
  }

  void createMethod() {
    if (widget.max != null &&
        widget.min != null &&
        widget.currentValue != null) {
      double minMax = widget.max! - widget.min!;

      double percent = minMax / widget.currentValue!;

      double mediaHeight =
          widget.currentWidth ?? MediaQuery.sizeOf(context).width / 3;

      width = mediaHeight / percent;

      setState(() {});
    }
  }
}
