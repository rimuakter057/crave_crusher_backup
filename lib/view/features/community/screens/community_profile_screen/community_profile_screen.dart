import 'package:crave_crusher/utils/app_colors/app_colors.dart';
import 'package:crave_crusher/utils/app_const/app_const.dart';
import 'package:crave_crusher/utils/app_images/app_images.dart';
import 'package:crave_crusher/view/components/common_profile/avater_widget.dart';
import 'package:crave_crusher/view/components/custom_nav_bar/navbar.dart';
import 'package:crave_crusher/view/components/custom_text/custom_text.dart';
import 'package:crave_crusher/view/features/community/screens/comment_screen/comment_screen.dart';
import 'package:crave_crusher/view/features/community/screens/community_image_show_screen/community_image_show_screen.dart';
import 'package:crave_crusher/view/features/community/screens/community_profile_screen/widgets/profile_status_container.dart';
import 'package:crave_crusher/view/features/community/screens/update_post_screen/update_post_screen.dart';
import 'package:crave_crusher/view/features/community/widgets/common%20comunity%20widget.dart';
import 'package:crave_crusher/view/features/profile/profile_screen/profile_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

class CommunityProfileScreen extends StatelessWidget {
  const CommunityProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: NavBar(currentIndex: 2),
      // appBar: ,
      appBar: AppBar(
        surfaceTintColor: AppColors.backgroundColor,
        backgroundColor: AppColors.backgroundColor,
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
          text: "Community",
          fontSize: 18.sp,
          fontWeight: FontWeight.w500,
        ),
      ),

      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.w),
          child: Column(
            children: [
              ///profile image
              ProfileAvatarWidget(
                imagePath: AppConstants.unknown,
                heightA: 100.h,
                widthA: 100.w,
                borderColor: Colors.blue.shade100,
              ),
              Gap(16.h),
              CustomText(text: "@habitbreaker"),
              Gap(24.h),

              /// profile details section
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  ProfileStatusContainer(number: 120, title: 'Posts'),
                  ProfileStatusContainer(number: 879, title: 'Reaction'),
                  ProfileStatusContainer(number: 3, title: 'badge'),
                ],
              ),

              Gap(24.h),

              ///common community widget
              CommonCommunityWidget(

                onTapUpdate: () {
                  Get.to(() => UpdatePostScreen);
                },
                onTapImageShow: () {
                  Get.to(() => CommunityImageShowScreen());
                },
                onTapProfile: () {
                  Get.to(() => ProfileScreen());
                },
                favouriteWidget: Row(
                  children: [
                    IconButton(
                      onPressed: () {},
                      icon: Icon(
                        Icons.favorite_border,
                        color: AppColors.red,
                        size: 20.w,
                      ),
                    ),

                    Gap(4.w),
                    CustomText(text: "000"),
                  ],
                ),
                profileTitle: "@Sheena S",
                profileSubtitle: "27 Aug 2020 06:20 AM",
                profileImage:
                    AppImages.profileManImage, // replace with your image path
                postText:
                    "Day 10 of my Smoking Battle! 🚭\nIt’s honestly been one of the toughest things I’ve done, "
                    "but waking up without that morning cough feels incredible. "
                    "I used to light up without thinking — now, I pause, breathe, and remind myself why I started this fight. "
                    "My monster still whispers sometimes, but it’s losing its voice. 💪🔥",

                commentsText: "45",
                myPost:
                    false, // set true if this is the user's post to show edit button
                index: 2,
                onTapComment: () {
                  // Get.to(CommentScreen(postId: postId));
                },
                postImages: [], // number of images layout (0,1,2)
              ),
              Gap(24.h),
              CommonCommunityWidget(
                onTapUpdate: () {
                  Get.to(() => UpdatePostScreen);
                },
                onTapImageShow: () {
                  Get.to(() => CommunityImageShowScreen());
                },
                onTapProfile: () {
                  Get.to(() => ProfileScreen());
                },

                profileTitle: "@Sheena S",
                profileSubtitle: "27 Aug 2020 06:20 AM",
                profileImage:
                    AppImages.profileManImage, // replace with your image path
                postText:
                    "Day 10 of my Smoking Battle! 🚭\nIt’s honestly been one of the toughest things I’ve done, "
                    "but waking up without that morning cough feels incredible. "
                    "I used to light up without thinking — now, I pause, breathe, and remind myself why I started this fight. "
                    "My monster still whispers sometimes, but it’s losing its voice. 💪🔥",

                commentsText: "45",
                myPost:
                    false, // set true if this is the user's post to show edit button
                index: 2,
                onTapComment: () {
                  // Get.to(CommentScreen(postId: postId));
                },
                favouriteWidget: Row(
                  children: [
                    IconButton(
                      onPressed: () {},
                      icon: Icon(
                        Icons.favorite_border,
                        color: AppColors.red,
                        size: 20.w,
                      ),
                    ),

                    Gap(4.w),
                    CustomText(text: "000"),
                  ],
                ),
                postImages: [],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
