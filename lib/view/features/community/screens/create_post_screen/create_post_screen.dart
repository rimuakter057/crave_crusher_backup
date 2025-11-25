
import 'dart:io';

import 'package:crave_crusher/utils/app_colors/app_colors.dart';
import 'package:crave_crusher/utils/app_icons/app_icons.dart';

import 'package:crave_crusher/view/components/custom_container/custom_container.dart';
import 'package:crave_crusher/view/components/custom_image/custom_image.dart';

import 'package:crave_crusher/view/components/custom_text/custom_text.dart';
import 'package:crave_crusher/view/features/community/controllers/image_picker_controller.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';

class CreatePostScreen extends StatelessWidget {
   CreatePostScreen({super.key});


  final ImagePickerController imagePickerController = Get.find<ImagePickerController>();


  @override
  Widget build(BuildContext context) {

    return Scaffold(


      appBar:  AppBar(
        surfaceTintColor: AppColors.backgroundColor,
        backgroundColor:AppColors.backgroundColor,
        leading: Center(
          child: Container(
            width: 50.w,
            height: 50.h,
            alignment: Alignment.center,
            decoration: BoxDecoration(
              color: AppColors.subPrimary.withOpacity(.3),
              shape: BoxShape.circle,
              border: Border.all(color: AppColors.subPrimary),
            ),
            child: BackButton(color: AppColors.primary),
          ),
        ),
        centerTitle: true,
        title: CustomText(
          text: "Create Post",
          fontSize: 18.sp,
          fontWeight: FontWeight.w500,
        ),
      ),

      body: SingleChildScrollView(
        child: Padding(
          padding:  EdgeInsets.symmetric(horizontal: 16.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [


            /// write comment here
            CustomText(text: "What’s on your mind today?",fontSize: 14.sp,
            fontWeight: FontWeight.w500,
            ),
              Gap(8.h),
            CustomContainer(
              width: double.infinity,
              height: 120.h,
              backgroundColor: AppColors.subPrimary.withOpacity(.5),
              child: SizedBox(
                height: 90.h,
                child: TextField(
                  maxLines: 4,
                  controller: TextEditingController(),
                  decoration: InputDecoration(
                    hintText: "Share your progress, thoughts, or a victory moment…", // <-- Add your hint text
                    hintStyle: TextStyle(
                      color: AppColors.black.withOpacity(0.5), // optional style
                      fontSize: 14.sp,
                    ),
                    contentPadding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 8.h),
                    border: OutlineInputBorder(
                      borderSide: BorderSide.none,
                    ),
                  ),
                ),
              ),
            ),





           Gap(24.h),

            /// add photo
              CustomText(text: "Add a photo or moment (optional)",fontSize: 14.sp,
                fontWeight: FontWeight.w500,
              ),
              Gap(8.h),

              GetBuilder<ImagePickerController>(
                builder: (controller) {
                  return GestureDetector(
                    onTap: (){
                      controller.getImage();
                    },
                    child:controller.imagePath.isNotEmpty?
                    CustomContainer(
                      padding: 0,
                      width: double.infinity,
                      height: 120.h,
                      backgroundColor: AppColors.subPrimary.withOpacity(.5),
                      child: Center(child: Image.file(
                        File(controller.imagePath),
                        width: double.infinity,
                        height: 120.h,
                        fit: BoxFit.cover,
                      ),)
                    ):      CustomContainer(
                        width: double.infinity,
                        height: 120.h,
                        backgroundColor: AppColors.subPrimary.withOpacity(.5),
                        child: Center(child: CustomImage(imageSrc: AppIcons.addImage),),
                    )
                  );
                }
              ),



              Gap(12.h),
              ///post now button
              GestureDetector(
                onTap: (){},
                child: CustomContainer(
                  backgroundColor: AppColors.primary,
                  padding: 4,
                  height: 36.h,
                  width: 100.w,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [

                      CustomText(text: "Post Now", color: AppColors.white),
                    ],
                  ),
                ),
              ),



            ],),
        ),
      ),

    );
  }
}









