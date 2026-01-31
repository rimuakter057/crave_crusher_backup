import 'package:crave_crusher/utils/app_colors/app_colors.dart';
import 'package:crave_crusher/view/components/custom_button/custom_button.dart';
import 'package:crave_crusher/view/components/custom_image/custom_image.dart';
import 'package:crave_crusher/view/components/custom_text/custom_text.dart';
import 'package:flutter/material.dart';

class OnBoardingBodyWidget extends StatelessWidget {
  const OnBoardingBodyWidget({
    super.key,
    required this.imagePath,
    required this.title,
    required this.subTitle,
    required this.onTap,
    this.isTablet = false,
  });

  final String imagePath;
  final String title;
  final String subTitle;
  final void Function() onTap;
  final bool isTablet;

  @override
  Widget build(BuildContext context) {
    // Calculate responsive values
    final double horizontalPadding = isTablet ? 60.0 : 16.0;
    final double imageHeight = isTablet ? 350.0 : 238.0;
    final double imageWidth = isTablet ? 410.0 : 280.0;
    final double titleSize = isTablet ? 28.0 : 20.0;
    final double subtitleSize = isTablet ? 18.0 : 14.0;
    final double gap1 = isTablet ? 32.0 : 24.0;
    final double gap2 = isTablet ? 12.0 : 8.0;
    final double gap3 = isTablet ? 90.0 : 72.0;
    final double gap4 = isTablet ? 120.0 : 100.0;
    final double indicatorHeight = isTablet ? 8.0 : 6.0;
    final double indicatorWidth = isTablet ? 36.0 : 28.0;
    final double indicatorRadius = isTablet ? 24.0 : 20.0;
    final double maxContentWidth = isTablet ? 600.0 : double.infinity;

    return SafeArea(
      child: Center(
        child: SingleChildScrollView(
          child: ConstrainedBox(
            constraints: BoxConstraints(maxWidth: maxContentWidth),
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: horizontalPadding),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  if (isTablet) const SizedBox(height: 20),

                  ///image
                  CustomImage(
                    imageSrc: imagePath,
                    height: imageHeight,
                    width: imageWidth,
                  ),

                  SizedBox(height: gap1),

                  ///on boarding text
                  CustomText(
                    text: title,
                    fontSize: titleSize,
                    fontWeight: FontWeight.w500,
                    textAlign: TextAlign.center,
                  ),

                  SizedBox(height: gap2),

                  CustomText(
                    maxLines: 3,
                    text: subTitle,
                    fontSize: subtitleSize,
                    fontWeight: FontWeight.w400,
                    color: const Color(0xFF555555),
                    textAlign: TextAlign.center,
                  ),

                  SizedBox(height: gap3),

                  ///indicator
                  Container(
                    height: indicatorHeight,
                    width: indicatorWidth,
                    decoration: BoxDecoration(
                      color: AppColors.primary,
                      borderRadius: BorderRadius.circular(indicatorRadius),
                    ),
                  ),

                  SizedBox(height: gap4),

                  ///button
                  CustomButton(
                    title: "Next    >",
                    onTap: onTap,
                    height: isTablet ? 65 : 55,
                    fontSize: isTablet ? 16.0 : 14.0,
                  ),

                  if (isTablet) const SizedBox(height: 40),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

// import 'package:crave_crusher/utils/app_colors/app_colors.dart';
// import 'package:crave_crusher/view/components/custom_button/custom_button.dart';
// import 'package:crave_crusher/view/components/custom_image/custom_image.dart';
// import 'package:crave_crusher/view/components/custom_text/custom_text.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:gap/gap.dart';

// class OnBoardingBodyWidget extends StatelessWidget {
//   const OnBoardingBodyWidget({
//     super.key,
//     required this.imagePath,
//     required this.title,
//     required this.subTitle,
//     required this.onTap,
//   });

//   final String imagePath;
//   final String title;
//   final String subTitle;
//   final void Function() onTap;

//   @override
//   Widget build(BuildContext context) {
//     return Center(
//       child: Padding(
//         padding: EdgeInsets.symmetric(horizontal: 16.w),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.center,
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: [
//             ///image
//             CustomImage(imageSrc: imagePath, height: 238.h, width: 280.w),
//             Gap(24.h),

//             ///on boarding  text
//             CustomText(
//               text: title,
//               fontSize: 20.sp,
//               fontWeight: FontWeight.w500,
//             ),
//             Gap(8.h),
//             CustomText(
//               maxLines: 2,

//               text: subTitle,
//               fontSize: 14.sp,
//               fontWeight: FontWeight.w400,
//               color: Color(0xFF555555),
//             ),
//             Gap(72.h),

//             ///container
//             Container(
//               height: 6.h, // height
//               width: 28.w, // width
//               decoration: BoxDecoration(
//                 color: AppColors.primary, // background color
//                 borderRadius: BorderRadius.circular(20.r), // radius
//               ),
//             ),

//             Gap(100.h),

//             ///button
//             CustomButton(title: "Next    >", onTap: onTap),
//           ],
//         ),
//       ),
//     );
//   }
// }
