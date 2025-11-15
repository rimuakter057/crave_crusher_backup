import 'package:crave_crusher/utils/app_colors/app_colors.dart';
import 'package:crave_crusher/view/components/custom_container/custom_container.dart';
import 'package:crave_crusher/view/components/custom_text/custom_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';



class ProfileStatusContainer extends StatelessWidget {
  const ProfileStatusContainer({
    super.key, required this.number, required this.title,
  });
  final int number;
  final String title;
  @override
  Widget build(BuildContext context) {
    return CustomContainer(
      width: 102.w,
      height: 64.h,
      backgroundColor: Colors.blue.shade50,
      borderColor: AppColors.primary,
      child: Column(
        children: [
          CustomText(text: number.toString(),fontWeight: FontWeight.w600,),
          CustomText(text: title,
            fontSize: 10,
            color:Color(0xFFA1A1AA),
          ),
        ],
      ),);
  }
}