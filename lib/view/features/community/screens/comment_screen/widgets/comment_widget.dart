import 'package:crave_crusher/helper/responsive_helper/responsive_helper.dart';
import 'package:crave_crusher/utils/app_const/app_const.dart';
import 'package:crave_crusher/view/components/common_profile/avatar_widget.dart';
import 'package:crave_crusher/view/components/custom_text/custom_text.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

class CommentWidget extends StatelessWidget {
  final String commentText;
  final String userName;
  const CommentWidget({
    super.key,
    required this.commentText,
    required this.userName,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: ResponsiveHelper.width(16),
        vertical: ResponsiveHelper.height(8),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          /// Profile avatar
          ProfileAvatarWidget(
            imagePath: AppConstants.unknown,
            heightA: ResponsiveHelper.height(40),
            widthA: ResponsiveHelper.width(40),
          ),

          Gap(ResponsiveHelper.width(8)),

          /// Column with title and subtitle
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                /// Username / title
                CustomText(text: userName),
                Gap(ResponsiveHelper.height(12)),
                CustomText(
                  fontWeight: FontWeight.w500,
                  textAlign: TextAlign.start,
                  fontSize: ResponsiveHelper.fontSize(13),
                  maxLines: 3,
                  overflow: TextOverflow.ellipsis,
                  color: Color(0xFFA1A1AA),
                  text: commentText,
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
