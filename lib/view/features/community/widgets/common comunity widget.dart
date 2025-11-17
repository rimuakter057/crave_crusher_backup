import 'package:crave_crusher/utils/app_colors/app_colors.dart';
import 'package:crave_crusher/utils/app_icons/app_icons.dart';
import 'package:crave_crusher/utils/app_images/app_images.dart';
import 'package:crave_crusher/view/components/common_profile/common_profile_widget.dart';
import 'package:crave_crusher/view/components/custom_image/custom_image.dart';
import 'package:crave_crusher/view/components/custom_text/custom_text.dart';
import 'package:crave_crusher/view/features/community/screens/comment_screen/comment_screen.dart';
import 'package:crave_crusher/view/features/community/screens/community_image_show_screen/community_image_show_screen.dart';
import 'package:crave_crusher/view/features/community/screens/community_profile_screen/community_profile_screen.dart';
import 'package:crave_crusher/view/features/community/screens/update_post_screen/update_post_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
class CommonCommunityWidget extends StatelessWidget {
  const CommonCommunityWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
        padding: EdgeInsets.only(left:16.w,right: 16.w,top: 10.h,bottom: 24.h),
        width: double.infinity,
        alignment: Alignment.center,
        decoration: BoxDecoration(
            color: AppColors.white,
            border: Border.all(color: AppColors.subPrimary),
            borderRadius: BorderRadius.all(Radius.circular(8))
        ),
        child:Column(
          crossAxisAlignment: CrossAxisAlignment.start,

          children: [
            ///profile section
            Row(
              children: [
                Expanded(
                  child: CommonProfileWidget(
                      onTap: (){
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => CommunityProfileScreen(),   // তোমার যাওয়ার screen
                          ),
                        );
                      },
                      title: "@Sheena s", subTitle: "27 Aug 2020 06:20 AM", image: AppImages.profileManImage),
                ),


                GestureDetector(
                  onTap: (){

                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) =>  UpdatePostScreen()),
                    );

                  },
                  child: Container(
                    width: 35.w,
                    height: 35.h,
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      color: AppColors.subPrimary.withOpacity(.3),
                      shape: BoxShape.circle,
                      border: Border.all(color: AppColors.subPrimary),
                    ),
                    child:    CustomImage(imageSrc: AppIcons.edit),
                  ),
                ),



              ],
            ),

            Gap(16.h),
            ///image section
            GestureDetector(
              onTap: (){
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => CommunityImageShowScreen(),   // তোমার যাওয়ার screen
                  ),
                );
              },
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(6),
                    child: CustomImage(
                      imageSrc: AppImages.imageOne,
                      height: 200.h,
                      width: 200.w,
                    ),
                  ),
                  Gap(8.w),
                  Column(
                    // crossAxisAlignment: CrossAxisAlignment.start,
                    // mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                    CustomImage(
                      imageSrc: AppImages.imageTwo,
                      height: 190.h,
                      width: 100.w,
                    ),
                    Gap(4.h),
                    CustomImage(
                      imageSrc: AppImages.imageThree,
                      height: 120.h,
                      width: 100.w,
                    ),
                  ],)
                ],
              ),
            ),
            Gap(24.h),
            /// text section
            CustomText(
              fontWeight: FontWeight.w500,
                textAlign: TextAlign.start,
                maxLines: 3,
                text: "“Day 10 of my Smoking Battle! 🚭\nIt’s honestly been one of the toughest things I’ve done, but waking up without that morning cough feels incredible. I used to light up without thinking — now, I pause, breathe, and remind myself why I started this fight. My monster still whispers sometimes, but it’s losing its voice. 💪🔥"),
            CustomText(text: "See More...",color: AppColors.primary,),

            Gap(24.h),

            ///bottom comment and react section
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,

              children: [
                Row(
                  children: [
                    Icon(Icons.favorite_border,color: AppColors.red,size: 20.w,),
                    Gap(4.w),
                    CustomText(text: "120"),
                  ],
                ),
                Container(
                  height: 20.h,
                  width: 1.5.w,
                  color: Color(0xFFCBD5E1),
                ),

                GestureDetector(
                  onTap: (){
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => CommentScreen(),   // তোমার যাওয়ার screen
                      ),
                    );
                  },
                  child: Row(
                    children: [
                      Icon(Icons.message_outlined,color: AppColors.primary,size: 20.w,),
                      Gap(4.w),
                      CustomText(text: "120"),
                    ],
                  ),
                ),

              ],),


          ],
        )
    );
  }
}