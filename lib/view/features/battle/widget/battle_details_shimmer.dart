import 'package:crave_crusher/helper/responsive_helper/responsive_helper.dart';
import 'package:flutter/material.dart';

class BattleDetailsShimmerLoader extends StatelessWidget {
  const BattleDetailsShimmerLoader({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: EdgeInsets.only(bottom: ResponsiveHelper.height(12)),
              child: Container(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    // Icon, Title, and Description
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        _buildSkeleton(
                          height: ResponsiveHelper.iconSize(30),
                          width: ResponsiveHelper.iconSize(30),
                        ),
                        SizedBox(width: ResponsiveHelper.width(8)),
                        SizedBox(
                          width: ResponsiveHelper.width(150),

                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              _buildSkeleton(
                                height: ResponsiveHelper.height(10),
                                width: ResponsiveHelper.width(205),
                              ),
                              SizedBox(height: ResponsiveHelper.height(2)),
                              _buildSkeleton(
                                height: ResponsiveHelper.height(10),
                                width: ResponsiveHelper.width(100),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    // Status Badge
                    _buildSkeleton(
                      height: ResponsiveHelper.height(25),
                      width: ResponsiveHelper.width(100),
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(height: ResponsiveHelper.spacing(32)),
            // Monster Image
            Center(
              child: _buildSkeleton(
                height: ResponsiveHelper.height(250),
                width: ResponsiveHelper.width(250),
              ),
            ),
            SizedBox(height: ResponsiveHelper.spacing(32)),

            // Monster Status Container
            _buildSkeleton(
              height: ResponsiveHelper.height(52),
              width: double.infinity,
            ),
          ],
        ),

        SizedBox(height: ResponsiveHelper.height(32)),

        _buildSkeleton(
          height: ResponsiveHelper.height(200),
          width: double.infinity,
        ),
      ],
    );
  }

  Widget _buildSkeleton({
    required double width,
    required double height,
    bool isCircle = false,
  }) {
    return Container(
      width: width,
      height: height,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(ResponsiveHelper.borderRadius(6)),
        color: Colors.grey.shade300,
        shape: isCircle ? BoxShape.circle : BoxShape.rectangle,
      ),
    );
  }
}
