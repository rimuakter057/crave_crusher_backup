// ignore_for_file: file_names, deprecated_member_use

import 'package:crave_crusher/helper/images_handler/image_handler.dart';
import 'package:crave_crusher/helper/responsive_helper/responsive_helper.dart';
import 'package:crave_crusher/utils/app_colors/app_colors.dart';
import 'package:crave_crusher/utils/app_icons/app_icons.dart';
import 'package:crave_crusher/view/components/common_profile/common_profile_widget.dart';
import 'package:crave_crusher/view/components/custom_image/custom_image.dart';
import 'package:crave_crusher/view/components/custom_network_image/custom_network_image.dart';
import 'package:crave_crusher/view/components/custom_svg_icon/custom_svg_icon.dart';
import 'package:crave_crusher/view/components/custom_text/custom_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:readmore/readmore.dart';

class CommonCommunityWidget extends StatefulWidget {
  final bool myPost; // Controls the edit button visibility
  final int index; // Determines image layout
  final String profileTitle; // Required profile name
  final String time; // Required subtitle (like date/time)
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
    required this.time,
    required this.profileImage,
    required this.postText,

    // required this.likesText,
    required this.commentsText,
    required this.onTapComment,
    this.onTapUpdate,
    required this.onTapImageShow,
    required this.onTapProfile,
    required this.favouriteWidget,
    required this.postImages,
  });

  @override
  State<CommonCommunityWidget> createState() => _CommonCommunityWidgetState();
}

class _CommonCommunityWidgetState extends State<CommonCommunityWidget> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(
        left: ResponsiveHelper.width(16),
        right: ResponsiveHelper.width(16),
        top: ResponsiveHelper.height(10),
        bottom: ResponsiveHelper.height(24),
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
                  subTitle: widget.time,
                  profileImage: widget.profileImage,
                ),
              ),
              if (widget.myPost)
                GestureDetector(
                  onTap: widget.onTapUpdate,
                  child: Container(
                    width: ResponsiveHelper.width(35),
                    height: ResponsiveHelper.height(35),
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

          Gap(8.h),

          /// Image Section
          GestureDetector(
            onTap: widget.onTapImageShow,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: _buildImages(),
            ),
          ),

          Gap(8.h),

          /// Text Section
          ReadMoreText(
            widget.postText,

            trimMode: TrimMode.Line,
            trimLines: 3,
            textAlign: TextAlign.justify,
            lessStyle: TextStyle(color: AppColors.primary),
            moreStyle: TextStyle(
              color: AppColors.primary,
              fontSize: ResponsiveHelper.fontSize(16),
              fontWeight: FontWeight.bold,
            ),
            style: TextStyle(
              fontSize: ResponsiveHelper.fontSize(13),
              color: Color(0xFF1E293B),
              fontWeight: FontWeight.w500,
            ),
            colorClickableText: Colors.pink,
            trimCollapsedText: 'See more',
            trimExpandedText: ' See less',
          ),

          Gap(8.h),

          /// Bottom Like & Comment Section
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              widget.favouriteWidget,

              Container(
                height: ResponsiveHelper.height(20),
                width: ResponsiveHelper.width(1.5),
                color: Color(0xFFCBD5E1),
              ),
              GestureDetector(
                onTap: widget.onTapComment,
                child: Row(
                  children: [
                    CustomSvgIcon(icon: AppIcons.comment),
                    Gap(ResponsiveHelper.width(4)),
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
      double screenWidth = MediaQuery.of(context).size.width;
      // Single image
      return [
        ClipRRect(
          borderRadius: BorderRadius.circular(6),
          child: CustomNetworkImage(
            height: ResponsiveHelper.height(180),
            width:
                screenWidth <= 360
                    ? ResponsiveHelper.width(260)
                    : ResponsiveHelper.width(280),

            // height: 180.h,
            // width: 160.w,
            imageUrl: ImageHandler.imagesHandle(images[0]),
          ),
        ),
      ];
    } else if (images.length == 2) {
      return [
        ClipRRect(
          borderRadius: BorderRadius.circular(6),
          child: CustomNetworkImage(
            imageUrl: ImageHandler.imagesHandle(images[0]),
            height: ResponsiveHelper.height(180),
            width: ResponsiveHelper.width(130),
          ),
        ),
        Gap(ResponsiveHelper.width(8)),
        Column(
          children: [
            CustomNetworkImage(
              imageUrl: ImageHandler.imagesHandle(images[1]),
              height: ResponsiveHelper.height(180),
              width: ResponsiveHelper.width(130),
              borderRadius: BorderRadius.circular(
                ResponsiveHelper.borderRadius(6),
              ),
            ),
          ],
        ),
      ];
    } else if (images.length == 3) {
      return [
        ClipRRect(
          borderRadius: BorderRadius.circular(6),
          child: CustomNetworkImage(
            imageUrl: ImageHandler.imagesHandle(images[0]),
            height: ResponsiveHelper.height(180),
            width: ResponsiveHelper.width(130),
          ),
        ),
        Gap(8.w),
        Column(
          children: [
            CustomNetworkImage(
              imageUrl: ImageHandler.imagesHandle(images[1]),
              height: ResponsiveHelper.height(90),
              width: ResponsiveHelper.width(100),
              borderRadius: BorderRadius.circular(
                ResponsiveHelper.borderRadius(6),
              ),
            ),
            Gap(8.h),
            CustomNetworkImage(
              imageUrl: ImageHandler.imagesHandle(images[2]),
              height: ResponsiveHelper.height(90),
              width: ResponsiveHelper.width(100),
              borderRadius: BorderRadius.circular(
                ResponsiveHelper.borderRadius(6),
              ),
            ),
          ],
        ),
      ];
    } else {
      // Multiple images
      return [
        ClipRRect(
          borderRadius: BorderRadius.circular(ResponsiveHelper.borderRadius(6)),
          child: CustomNetworkImage(
            imageUrl: ImageHandler.imagesHandle(images[0]),
            height: ResponsiveHelper.height(180),
            width: ResponsiveHelper.width(160),
          ),
        ),
        Gap(ResponsiveHelper.width(8)),
        Column(
          children: [
            CustomNetworkImage(
              imageUrl: ImageHandler.imagesHandle(images[1]),
              height: ResponsiveHelper.height(90),
              width: ResponsiveHelper.width(85),
              borderRadius: BorderRadius.circular(
                ResponsiveHelper.borderRadius(6),
              ),
            ),

            if (images.length > 3) ...[
              Gap(8.h),
              CustomNetworkImage(
                imageUrl: ImageHandler.imagesHandle(images[2]),
                height: ResponsiveHelper.height(90),
                width: ResponsiveHelper.width(100),
                borderRadius: BorderRadius.circular(
                  ResponsiveHelper.borderRadius(6),
                ),
                child:
                    images.length > 3
                        ? Center(
                          child: Container(
                            height: ResponsiveHelper.height(90),
                            width: ResponsiveHelper.width(100),
                            alignment: Alignment.center,
                            decoration: BoxDecoration(
                              color: AppColors.white.withAlpha(99),
                              borderRadius: BorderRadius.circular(
                                ResponsiveHelper.borderRadius(6),
                              ),
                            ),
                            child: CustomText(
                              text: '+${images.length - 3}',
                              fontSize: ResponsiveHelper.fontSize(24),
                            ),
                          ),
                        )
                        : SizedBox(),
              ),
            ],
          ],
        ),
      ];
    }
  }
}
