import 'package:crave_crusher/utils/app_colors/app_colors.dart';
import 'package:crave_crusher/utils/app_images/app_images.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class BottomAvatar extends StatelessWidget {
  final String imagePath; // image path (asset/network)


   const BottomAvatar({
    super.key,
    required this.imagePath,

  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 60.h,
      width: 60.w,
      alignment: Alignment.center,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        // boxShadow: [
        //   BoxShadow(
        //     color: Colors.blue.withOpacity(0.5), // নীল glow
        //     blurRadius: 100, // আলো ছড়ানোর পরিমাণ
        //     spreadRadius: 1,
        //     offset: const Offset(0, 10), // নিচের দিকে আলোর অবস্থান
        //   ),
        // ],
        border: Border.all(
          color: AppColors.subPrimary,
          width: 1,
        ),
        color: Colors.white,
      ),
      child: Stack(
        alignment: Alignment.bottomCenter,
        children: [
          // নিচের দিকে ইমেজ থাকবে
          Align(
            alignment: Alignment.bottomCenter,
            child: ClipOval(
              child: Image.asset(
                AppImages.profileManImage,
                width: 60.w*0.8,
                height: 60.h*0.8,
                fit: BoxFit.cover,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
