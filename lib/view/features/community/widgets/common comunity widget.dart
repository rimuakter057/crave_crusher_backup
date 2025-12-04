import 'package:crave_crusher/helper/imges_handler/image_handler.dart';
import 'package:crave_crusher/utils/app_colors/app_colors.dart';
import 'package:crave_crusher/utils/app_icons/app_icons.dart';
import 'package:crave_crusher/utils/app_images/app_images.dart';
import 'package:crave_crusher/view/components/common_profile/common_profile_widget.dart';
import 'package:crave_crusher/view/components/custom_image/custom_image.dart';
import 'package:crave_crusher/view/components/custom_netwrok_image/custom_network_image.dart';
import 'package:crave_crusher/view/components/custom_text/custom_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';

class CommonCommunityWidget extends StatefulWidget {
  final bool myPost; // Controls the edit button visibility
  final int index; // Determines image layout
  final String profileTitle; // Required profile name
  final String profileSubtitle; // Required subtitle (like date/time)
  final String profileImage; // Required profile image
  final String postText; // Required post text
  final void Function() onTapComment;
  final void Function()? onTapUpdate;
  final void Function() onTapImageShow;
  final void Function() onTapProfile;
  //  final String likesText; // Required likes count text
  final String commentsText; // Required comments count text
  final Widget favouriteWidget;
  final List<String> postImages;
  const CommonCommunityWidget({
    super.key,
    this.myPost = false,
    this.index = 2,
    required this.profileTitle,
    required this.profileSubtitle,
   required this.profileImage,
    required this.postText,

    // required this.likesText,
    required this.commentsText,
    required this.onTapComment,
     this.onTapUpdate,
    required this.onTapImageShow,
    required this.onTapProfile,
    required this.favouriteWidget, required this.postImages,
  });

  @override
  State<CommonCommunityWidget> createState() => _CommonCommunityWidgetState();
}

class _CommonCommunityWidgetState extends State<CommonCommunityWidget> {
  @override
  Widget build(BuildContext context) {
    return Container(

      padding: EdgeInsets.only(
        left: 16.w,
        right: 16.w,
        top: 10.h,
        bottom: 24.h,
      ),
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
                  onTap: widget.onTapProfile,
                  title: widget.profileTitle,
                  subTitle: widget.profileSubtitle,
                  profileImage: widget.profileImage,
                ),
              ),
              if (widget.myPost)
                GestureDetector(
                  onTap: widget.onTapUpdate,
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

         // Gap(4.h),

          /// Image Section
      GestureDetector(
              onTap: widget.onTapImageShow,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: _buildImages(),
              ),
            ),


          Gap(4.h),

          /// Text Section
          CustomText(
            fontWeight: FontWeight.w500,
            textAlign: TextAlign.start,
            maxLines: 3,
            text: widget.postText,
          ),
          CustomText(text: "see more", color: AppColors.primary),

          Gap(24.h),

          /// Bottom Like & Comment Section
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              widget.favouriteWidget,

              Container(height: 20.h, width: 1.5.w, color: Color(0xFFCBD5E1)),
              GestureDetector(
                onTap: widget.onTapComment,
                child: Row(
                  children: [
                    Icon(
                      Icons.message_outlined,
                      color: AppColors.primary,
                      size: 20.w,
                    ),
                    Gap(4.w),
                    CustomText(text: widget.commentsText),
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
  List<Widget> _buildImages() {
    final images = widget.postImages;

    if (images.isEmpty) return [];

    if (images.length == 1) {
      // Single image
      return [
        ClipRRect(
          borderRadius: BorderRadius.circular(6),
          child: CustomNetworkImage(

            height: 180.h,
            width: 160.w,
           imageUrl: ImageHandler.imagesHandle(images[0]),
          ),
        ),
      ];
    }  else if(images.length == 2){
      return [
      ClipRRect(
        borderRadius: BorderRadius.circular(6),
        child: CustomNetworkImage(
          imageUrl:ImageHandler.imagesHandle( images[0]),
          height: 180.h,
          width: 160.w,

        ),
      ),
    Gap(4.w),
    Column(
    children: [

    CustomNetworkImage(
    imageUrl: ImageHandler.imagesHandle( images[1]),
    height: 180.h,
    width: 160.w,
    borderRadius: BorderRadius.circular(6),

    ),
      ])];
    }




    else {
      // Multiple images
      return [
        ClipRRect(
          borderRadius: BorderRadius.circular(6),
          child: CustomNetworkImage(
            imageUrl:ImageHandler.imagesHandle( images[0]),
            height: 180.h,
            width: 160.w,

          ),
        ),
        Gap(4.w),
        Column(
          children: [

    CustomNetworkImage(
            imageUrl: ImageHandler.imagesHandle( images[1]),
            height: 90.h,
            width: 85.w,
      borderRadius: BorderRadius.circular(6),

          ),


            if(images.length > 2)...[
              Gap(4.h),
              CustomNetworkImage(
                imageUrl: ImageHandler.imagesHandle( images[2]),
                height: 90.h,
                width: 85.w,
                borderRadius: BorderRadius.circular(6), 
                child: images.length > 3?
                Center(
                  child: CustomText(text: '+${images.length - 3}'),
                ) : SizedBox(),

              ),
            ]
          ]

        ),
      ];
    }
  }

}
