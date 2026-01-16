import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class CustomImage extends StatelessWidget {
  final String imageSrc;
  final Color? imageColor;
  final double? height;
  final double? scale;
  final double? width;
  final double? sizeWidth;

  final BoxFit? fit;
  final double horizontal;
  final double vertical;
  final BoxFit? boxFit;

  final AlignmentGeometry alignment;
  final EdgeInsetsGeometry? padding;
  final Widget? child;

  const CustomImage({
    super.key,
    required this.imageSrc,
    this.imageColor,
    this.sizeWidth,
    this.fit,
    this.scale,
    this.horizontal = 0.0,
    this.vertical = 0.0,
    this.boxFit,
    this.height,
    this.width,
    this.alignment = Alignment.center, // Default: Center
    this.padding,
    this.child,
  });

  Widget _buildImageWidget() {
    if (imageSrc.toLowerCase().endsWith('.svg')) {
      return SvgPicture.asset(
        imageSrc,
        // ignore: deprecated_member_use
        color: imageColor,
        height: height,
        width: width,
        fit: boxFit ?? BoxFit.contain,
      );
    }

    return Image.asset(
      imageSrc,
      color: imageColor,
      height: height,
      width: width,
      scale: scale ?? 1,
      fit: fit ?? BoxFit.contain,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: horizontal, vertical: vertical),
      padding: padding,

      width: sizeWidth ?? width,
      height: height,

      child: Stack(
        alignment: alignment as Alignment,
        children: [_buildImageWidget(), if (child != null) child!],
      ),
    );
  }
}
