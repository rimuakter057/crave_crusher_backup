import 'package:crave_crusher/utils/app_colors/app_colors.dart';
import 'package:crave_crusher/utils/app_images/app_images.dart';
import 'package:crave_crusher/view/components/custom_button/custom_button.dart';
import 'package:crave_crusher/view/components/custom_container/custom_container.dart';
import 'package:crave_crusher/view/components/custom_image/custom_image.dart';
import 'package:crave_crusher/view/components/custom_text/custom_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';


class OnBoardingScreen extends StatefulWidget {
  const OnBoardingScreen({super.key});

  @override
  State<OnBoardingScreen> createState() => _OnBoardingScreenState();
}

class _OnBoardingScreenState extends State<OnBoardingScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 8.0),
            child: TextButton(onPressed: (){}, child: CustomText(text: "Skip",color: AppColors.primary,)),
          )
        ],
      ),
      body: Center(
        child:Padding(
          padding:  EdgeInsets.symmetric(horizontal:16.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
          ///image
              CustomImage(imageSrc: AppImages.onBoardingOne,height: 238.h,
              width: 280.w,
              ),
              Gap(24.h),
              ///on boarding  text
              CustomText(

                text: "Face Your Monster",fontSize: 20.sp,fontWeight: FontWeight.w500,),
              Gap(8.h),
              CustomText(
                maxLines: 2,

                text: "Spot your addictions and get ready to battle them — one step at a time.",fontSize: 14.sp,fontWeight: FontWeight.w400,
                color: Color(0xFF555555),
              ),
              Gap(72.h),
              ///container
              Container(
                height: 6.h, // height
                width: 28.w, // width
                decoration: BoxDecoration(
                  color: AppColors.primary,// background color
                  borderRadius: BorderRadius.circular(20.r), // radius
                ),
              ),

              Gap(100.h),
              ///button
              CustomButton(
                  title: "Next    >",
                  onTap: (){}),
          ],),
        ),
      ),
    );
  }
}
