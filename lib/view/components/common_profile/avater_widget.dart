import 'package:crave_crusher/utils/app_colors/app_colors.dart';
import 'package:crave_crusher/utils/app_images/app_images.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ProfileAvatarWidget extends StatelessWidget {
  final String imagePath;
  final Color? borderColor;
  final double? heightA;
  final double? widthA;

  const ProfileAvatarWidget({
    super.key,
    required this.imagePath,
    this.borderColor,
    this.heightA,
    this.widthA,
  });

  @override
  Widget build(BuildContext context) {
    final double avatarHeight = heightA ?? 60.h;
    final double avatarWidth  = widthA ?? 60.w;

    // 👇 Fixed 80% rule (just like your UI)
    final double imageHeight = avatarHeight * 0.8;
    final double imageWidth  = avatarWidth * 0.8;

    return Container(
      height: avatarHeight,
      width: avatarWidth,
      alignment: Alignment.center,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        border: Border.all(
          color: borderColor ?? AppColors.subPrimary,
          width: 1,
        ),
        color: Colors.white,
      ),
      child: Stack(
        alignment: Alignment.bottomCenter,
        children: [
          Align(
            alignment: Alignment.bottomCenter,
            child: ClipOval(
              child: Image.asset(
                imagePath,
                width: imageWidth,   // 👈 dynamically fixed
                height: imageHeight, // 👈 dynamically fixed
                fit: BoxFit.cover,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

