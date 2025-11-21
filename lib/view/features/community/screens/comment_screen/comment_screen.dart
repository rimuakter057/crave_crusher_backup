
import 'package:crave_crusher/utils/app_colors/app_colors.dart';
import 'package:crave_crusher/utils/app_icons/app_icons.dart';
import 'package:crave_crusher/utils/app_images/app_images.dart';
import 'package:crave_crusher/view/components/common_profile/avater_widget.dart';

import 'package:crave_crusher/view/components/custom_container/custom_container.dart';
import 'package:crave_crusher/view/components/custom_image/custom_image.dart';

import 'package:crave_crusher/view/components/custom_text/custom_text.dart';

import 'package:crave_crusher/view/features/community/screens/comment_screen/widgets/comment_widget.dart';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';

class CommentScreen extends StatelessWidget {
  const CommentScreen({super.key});

  @override
  Widget build(BuildContext context) {

    return Scaffold(
     // bottomNavigationBar: NavBar(currentIndex: 2),

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
          text: "Comments",
          fontSize: 18.sp,
          fontWeight: FontWeight.w500,
        ),
      ),


      body: SingleChildScrollView(
        child: Padding(
          padding:  EdgeInsets.symmetric(horizontal: 16.w),
          child: Column(children: [
            /// write comment here


            CustomContainer(
              width: double.infinity,
              height: 150.h,
              backgroundColor: Colors.blue.shade50,
              borderColor: AppColors.primary,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [

                  /// Profile row
                  Row(
                    children: [
                      ProfileAvatarWidget(
                        imagePath: AppImages.profileManImage,
                        heightA: 25.h,
                        widthA: 25.w,
                      ),
                      Gap(4.w),
                      CustomText(
                        text: "@ Sheena",
                        fontSize: 14,
                      ),
                    ],
                  ),

                  /// Comment TextField (height fixed, UI same)
                  SizedBox(
                    height: 40.h,
                    child: TextField(
                      maxLines: 2,
                      controller: TextEditingController(),
                      decoration: InputDecoration(
                        contentPadding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 8.h),
                        border: OutlineInputBorder(
                        borderSide: BorderSide.none
                        ),
                      ),
                    ),
                  ),

                  /// Send button
                  GestureDetector(
                    onTap: (){},
                    child: CustomContainer(
                      backgroundColor: AppColors.primary,
                      padding: 2,
                      height: 32.h,
                      width: 81.w,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          CustomImage(imageSrc: AppIcons.send),
                          SizedBox(width: 2.w),
                          CustomText(text: "Send", color: AppColors.white),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),

            SizedBox(height: 24.h,),

            /// show comment text
         ListView.builder(
             itemCount: 3,
             shrinkWrap: true,
             itemBuilder: (context,index){
           return CommentWidget();

         }),



          ],),
        ),
      ),

    );
  }
}









