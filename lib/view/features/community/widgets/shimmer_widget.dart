import 'package:crave_crusher/helper/responsive_helper/responsive_helper.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:shimmer/shimmer.dart';

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
          padding: EdgeInsets.symmetric(vertical: ResponsiveHelper.height(8)),
          child: Shimmer.fromColors(
            baseColor: Colors.grey[300]!,
            highlightColor: Colors.grey[100]!,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Profile Row
                Row(
                  children: [
                    _buildSkeleton(
                      ResponsiveHelper.width(50),
                      ResponsiveHelper.height(50),
                      isCircle: true,
                    ), // Avatar
                    SizedBox(width: ResponsiveHelper.width(12)),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        _buildSkeleton(
                          ResponsiveHelper.width(120),
                          ResponsiveHelper.height(14),
                        ), // Name
                        Gap(ResponsiveHelper.height(6)),
                        _buildSkeleton(
                          ResponsiveHelper.width(80),
                          ResponsiveHelper.height(12),
                        ), // Post time
                      ],
                    ),
                  ],
                ),
                Gap(ResponsiveHelper.height(12)),

                // Post Image Placeholder
                _buildSkeleton(double.infinity, ResponsiveHelper.height(160)),
                Gap(ResponsiveHelper.height(8)),

                // Post Text Placeholder (2 lines)
                _buildSkeleton(double.infinity, ResponsiveHelper.height(14)),
                Gap(ResponsiveHelper.height(6)),
                _buildSkeleton(
                  ResponsiveHelper.width(200),
                  ResponsiveHelper.height(14),
                ),
                Gap(ResponsiveHelper.height(8)),

                // Footer Row (Like & Comment)
                Row(
                  children: [
                    _buildSkeleton(
                      ResponsiveHelper.width(20),
                      ResponsiveHelper.height(20),
                    ),
                    SizedBox(width: ResponsiveHelper.width(6)),
                    _buildSkeleton(
                      ResponsiveHelper.width(30),
                      ResponsiveHelper.height(14),
                    ),
                    SizedBox(width: ResponsiveHelper.width(20)),
                    _buildSkeleton(
                      ResponsiveHelper.width(20),
                      ResponsiveHelper.height(20),
                    ),
                    SizedBox(width: ResponsiveHelper.width(6)),
                    _buildSkeleton(
                      ResponsiveHelper.width(30),
                      ResponsiveHelper.height(14),
                    ),
                  ],
                ),
                SizedBox(height: ResponsiveHelper.height(12)),
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
