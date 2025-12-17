import 'package:crave_crusher/utils/app_const/app_const.dart';
import 'package:crave_crusher/utils/app_images/app_images.dart';
import 'package:crave_crusher/view/components/common_profile/avater_widget.dart';
import 'package:crave_crusher/view/components/custom_text/custom_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';

class CommentWidget extends StatelessWidget {
final String commentText;
final String userName;
  const CommentWidget({
    super.key, required this.commentText, required this.userName,

  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [

          /// Profile avatar
          ProfileAvatarWidget(    imagePath: AppConstants.unknown,heightA: 40.h,widthA: 40.w,),

           Gap(8.w),

          /// Column with title and subtitle
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                /// Username / title
                CustomText(text: userName),
              Gap(12.h),
                CustomText(
                  fontWeight: FontWeight.w500,
                  textAlign: TextAlign.start,
                  fontSize: 13.sp,
                  maxLines: 3,
                  overflow: TextOverflow.ellipsis,
                  color: Color(0xFFA1A1AA),
                  text:commentText,
                  //'Love This Energy! It\'s Amazing How Small Wins Every Day Start To Change Everything. Keep Going – Your Monster Doesn\'t Stand A Chance 🏗️🎶',
                ),

              ],
            ),
          ),
        ],
      ),
    );
  }
}
