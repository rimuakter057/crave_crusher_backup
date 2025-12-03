import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:shimmer/shimmer.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class PostShimmerLoader extends StatelessWidget {
  const PostShimmerLoader({super.key});

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
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Profile Row
                Row(
                  children: [
                    _buildSkeleton(50.w, 50.h, isCircle: true), // Avatar
                    SizedBox(width: 12.w),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        _buildSkeleton(120.w, 14.h), // Name
                        Gap(6.h),
                        _buildSkeleton(80.w, 12.h), // Post time
                      ],
                    ),
                  ],
                ),
                Gap(12.h),

                // Post Image Placeholder
                _buildSkeleton(double.infinity, 160.h),
                Gap(8.h),

                // Post Text Placeholder (2 lines)
                _buildSkeleton(double.infinity, 14.h),
                Gap(6.h),
                _buildSkeleton(200.w, 14.h),
                Gap(8.h),

                // Footer Row (Like & Comment)
                Row(
                  children: [
                    _buildSkeleton(20.w, 20.h),
                    SizedBox(width: 6.w),
                    _buildSkeleton(30.w, 14.h),
                    SizedBox(width: 20.w),
                    _buildSkeleton(20.w, 20.h),
                    SizedBox(width: 6.w),
                    _buildSkeleton(30.w, 14.h),
                  ],
                ),
                SizedBox(height: 12.h),
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
        color: Colors.white,
        shape: isCircle ? BoxShape.circle : BoxShape.rectangle,
      ),
    );
  }
}
