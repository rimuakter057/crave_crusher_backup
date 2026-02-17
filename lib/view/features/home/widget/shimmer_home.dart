import 'package:crave_crusher/helper/responsive_helper/responsive_helper.dart';
import 'package:crave_crusher/utils/app_colors/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:shimmer/shimmer.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class HomeShimmerLoader extends StatelessWidget {
  const HomeShimmerLoader({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      physics: const BouncingScrollPhysics(),
      scrollDirection: Axis.vertical,
      shrinkWrap: true,
      itemCount: 5,
      itemBuilder: (context, index) {
        return Padding(
          padding: EdgeInsets.symmetric(vertical: ResponsiveHelper.fontSize(14)),
          child: Shimmer.fromColors(
            baseColor: Colors.grey[300]!,
            highlightColor: Colors.grey[100]!,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // first Row
                _buildSkeleton(ResponsiveHelper.width(80), ResponsiveHelper.height(10)),
                Gap(ResponsiveHelper.height(12)),

                // 2nd Row
                _buildSkeleton(ResponsiveHelper.width(80), ResponsiveHelper.height(10)),
                Gap(ResponsiveHelper.height(8)),

                // line
                _buildSkeleton(double.infinity, ResponsiveHelper.height(14)),

                Gap(ResponsiveHelper.height(8)),
                _buildSkeleton(ResponsiveHelper.width(200), ResponsiveHelper.height(14)),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildSkeleton(double width, double height, {bool isCircle = false}) {
    return Container(
      width: width,
      height: height,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(6.r),
        color: AppColors.white,
        shape: isCircle ? BoxShape.circle : BoxShape.rectangle,
      ),
    );
  }
}
