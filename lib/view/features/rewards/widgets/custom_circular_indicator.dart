import 'package:crave_crusher/utils/app_colors/app_colors.dart';
import 'package:crave_crusher/view/components/custom_text/custom_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';



class CustomCircularIndicator extends StatelessWidget {
  const CustomCircularIndicator({
    super.key, required this.percentText, required this.percent,
  });

  final String percentText;
  final double percent;


  @override
  Widget build(BuildContext context) {
    return CircularPercentIndicator(
      radius: 55,
      lineWidth: 12,
      percent: percent,              //  percentage
      center: CustomText(text: percentText,color: AppColors.primary,fontSize: 18.sp,fontWeight: FontWeight.w700,),

      // IMPORTANT — gradient
      linearGradient: const LinearGradient(
        colors: [
          Color(0xFF6C63FF),  // Start color
          Color(0xFF1E293B),  // End color
        ],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ),

      backgroundColor: Color(0xFFE2E8F0), // হালকা gray background
      circularStrokeCap: CircularStrokeCap.round,
      startAngle: 160,
    );
  }
}