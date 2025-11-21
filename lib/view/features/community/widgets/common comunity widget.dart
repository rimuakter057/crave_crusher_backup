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

class CommonCommunityWidget extends StatefulWidget {
  final bool myPost; // Controls the edit button visibility
  final int index; // Determines image layout
  const CommonCommunityWidget({super.key, this.myPost = false, this.index = 2});

  @override
  State<CommonCommunityWidget> createState() => _CommonCommunityWidgetState();
}

class _CommonCommunityWidgetState extends State<CommonCommunityWidget> {



  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(left: 16.w, right: 16.w, top: 10.h, bottom: 24.h),
      width: double.infinity,
      alignment: Alignment.center,
      decoration: BoxDecoration(
        color: AppColors.white,
        border: Border.all(color: AppColors.subPrimary),
        borderRadius: BorderRadius.all(Radius.circular(8)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [

          /// Profile Section
          Row(
            children: [
              Expanded(
                child: CommonProfileWidget(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (_) => CommunityProfileScreen()),
                    );
                  },
                  title: "@Sheena s",
                  subTitle: "27 Aug 2020 06:20 AM",
                  image: AppImages.profileManImage,
                ),
              ),
              if (widget.myPost)
                GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (_) => UpdatePostScreen()),
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
                    child: CustomImage(imageSrc: AppIcons.edit),
                  ),
                ),
            ],
          ),

          Gap(16.h),

          /// Image Section
          GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => CommunityImageShowScreen()),
              );
            },
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: buildImages(),
            ),
          ),

          Gap(24.h),

          /// Text Section
          CustomText(
            fontWeight: FontWeight.w500,
            textAlign: TextAlign.start,
            maxLines: 3,
            text:
            "“Day 10 of my Smoking Battle! 🚭\nIt’s honestly been one of the toughest things I’ve done, but waking up without that morning cough feels incredible. I used to light up without thinking — now, I pause, breathe, and remind myself why I started this fight. My monster still whispers sometimes, but it’s losing its voice. 💪🔥",
          ),
          CustomText(text: "See More...", color: AppColors.primary),

          Gap(24.h),

          /// Bottom Like & Comment Section
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Icon(Icons.favorite_border, color: AppColors.red, size: 20.w),
                  Gap(4.w),
                  CustomText(text: "120"),
                ],
              ),
              Container(height: 20.h, width: 1.5.w, color: Color(0xFFCBD5E1)),
              GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (_) => CommentScreen()),
                  );
                },
                child: Row(
                  children: [
                    Icon(Icons.message_outlined, color: AppColors.primary, size: 20.w),
                    Gap(4.w),
                    CustomText(text: "120"),
                  ],
                ),
              ),
            ],
          ),

        ],
      ),
    );
  }










  /// Builds the image widgets dynamically based on index
  List<Widget> buildImages() {
    List<String> images;

    // Assign images based on index
    switch (widget.index) {
      case 0:
        images = [AppImages.imageOne];
        break;
      case 1:
        images = [AppImages.imageOne, AppImages.imageTwo];
        break;
      case 2:
        images = [AppImages.imageOne, AppImages.imageTwo, AppImages.imageThree];
        break;
      default:
        images = [AppImages.imageOne];
    }

    if (images.length == 1) {
      return [
        ClipRRect(
          borderRadius: BorderRadius.circular(6),
          child: CustomImage(
            imageSrc: images[0],
            height: 180.h,
            width: 180.w,
            fit: BoxFit.cover,
          ),
        )
      ];
    } else {
      return [
        ClipRRect(
          borderRadius: BorderRadius.circular(6),
          child: CustomImage(
            imageSrc: images[0],
            height: 180.h,
            width: 180.w,
            fit: BoxFit.cover,
          ),
        ),
        Gap(4.w),
        Column(
          children: images.sublist(1).map((img) => Padding(
            padding: EdgeInsets.only(bottom: 4.h),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(6),
              child: CustomImage(
                imageSrc: img,
                height: 90.h,
                width: 90.w,
                fit: BoxFit.cover,
              ),
            ),
          )).toList(),
        )
      ];
    }
  }


}
