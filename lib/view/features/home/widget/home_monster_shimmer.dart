import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:shimmer/shimmer.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class HomeMonsterShimmerLoader extends StatelessWidget {
  const HomeMonsterShimmerLoader({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      physics: const BouncingScrollPhysics(),
      scrollDirection: Axis.vertical,
      shrinkWrap: true,
      itemCount: 5,
      itemBuilder: (context, index) {
        return Padding(
          padding: EdgeInsets.symmetric(vertical: 8.h),
          child: Shimmer.fromColors(
            baseColor: Colors.grey[300]!,
            highlightColor: Colors.grey[100]!,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                // first Row
                _buildSkeleton(286.w,300.h,),

                Gap(12.h),

                // 2nd Row
                _buildSkeleton(300.w, 52.h,),
                Gap(8.h),



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
        color: Colors.white,
        shape: isCircle ? BoxShape.circle : BoxShape.rectangle,
      ),
    );
  }
}
