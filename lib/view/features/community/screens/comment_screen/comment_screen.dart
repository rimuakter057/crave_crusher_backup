import 'package:crave_crusher/helper/imges_handler/image_handler.dart';
import 'package:crave_crusher/utils/app_colors/app_colors.dart';
import 'package:crave_crusher/utils/app_const/app_const.dart';
import 'package:crave_crusher/utils/app_icons/app_icons.dart';
import 'package:crave_crusher/utils/app_images/app_images.dart';
import 'package:crave_crusher/view/components/common_profile/avatar_widget.dart';
import 'package:crave_crusher/view/components/custom_container/custom_container.dart';
import 'package:crave_crusher/view/components/custom_image/custom_image.dart';
import 'package:crave_crusher/view/components/custom_loader/custom_loader.dart';
import 'package:crave_crusher/view/components/custom_refresh_indicator/custom_refresh_indicator.dart';
import 'package:crave_crusher/view/components/custom_svg_icon/custom_svg_icon.dart';
import 'package:crave_crusher/view/components/custom_text/custom_text.dart';
import 'package:crave_crusher/view/components/custom_text_field/custom_text_field.dart';
import 'package:crave_crusher/view/features/community/controllers/community_controller.dart';

import 'package:crave_crusher/view/features/community/screens/comment_screen/widgets/comment_widget.dart';
import 'package:crave_crusher/view/features/profile/controllers/profile_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';

import '../../models/comment_model.dart';

class CommentScreen extends StatefulWidget {
  final String postId;
  const CommentScreen({super.key, required this.postId});

  @override
  State<CommentScreen> createState() => _CommentScreenState();
}

class _CommentScreenState extends State<CommentScreen> {
  final CommunityController commentController = Get.find<CommunityController>();
  final TextEditingController _controller = TextEditingController();
  final ProfileController profileController = Get.find<ProfileController>();
  @override
  void initState() {
    super.initState();
    // Fetch comments after build
    WidgetsBinding.instance.addPostFrameCallback((_) {
      commentController.fetchCommentList(widget.postId);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
            child: IconButton(onPressed: (){Get.back();}, icon: CustomSvgIcon(icon: AppIcons.backButton))
          ),
        ),
        centerTitle: true,
        title: CustomText(
          text: "Comments",
          fontSize: 18.sp,
          fontWeight: FontWeight.w500,
        ),
      ),
      body: CustomRefreshIndicator(
        onRefresh: () async {
          await commentController.fetchCommentList(widget.postId);
        },
        child: Obx(() {
          if (commentController.isLoadingComment.value) {
            return Center(child: CustomLoader());
          }

          return ListView.builder(
            physics: AlwaysScrollableScrollPhysics(),
            itemCount: commentController.commentList.length + 1,
            itemBuilder: (context, index) {
              if (index == 0) {
                // Input field + Send button
                return Padding(
                  padding: EdgeInsets.all(16.w),
                  child: Obx(
                    () => CustomContainer(
                      width: double.infinity,

                      backgroundColor: Colors.blue.shade50,
                      borderColor: AppColors.primary,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,

                        children: [
                          // Profile row
                          Obx(() {
                            final profile = profileController.myProfile.value;
                            return SizedBox(
                              height: 38.h,
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  ProfileAvatarWidget(
                                    heightA: 35.h,
                                    widthA: 35.w,
                                    imagePath: ImageHandler.imagesHandle(
                                      profile?.profileImage,
                                      isProfile: true,
                                    ),
                                  ),
                                  Gap(4.w),
                                  CustomText(
                                    text:
                                        "@${profile?.fullName}" ?? "Empty Name",
                                    fontSize: 18,
                                  ),
                                ],
                              ),
                            );
                          }),

                          // Comment input
                          TextField(
                            maxLines: 2,
                            controller: _controller,
                            onChanged:
                                (val) =>
                                    commentController.commentText.value = val,
                            decoration: InputDecoration(
                              contentPadding: EdgeInsets.symmetric(
                                horizontal: 8.w,
                                vertical: 8.h,
                              ),
                              border: OutlineInputBorder(
                                borderSide: BorderSide.none,
                              ),
                            ),
                          ),

                          /// Send button
                          GestureDetector(
                            onTap:
                                commentController.isLoadingSend.value
                                    ? null
                                    : () async {
                                      if (commentController.commentText.value
                                          .trim()
                                          .isEmpty) {
                                        Get.snackbar(
                                          "Error",
                                          "Comment cannot be empty",
                                        );
                                        return;
                                      }
                                      bool isAllFeed =
                                          commentController
                                                      .communityTabIndex
                                                      .value ==
                                                  0
                                              ? true
                                              : false;
                                      await commentController.createComment(
                                        widget.postId,
                                        allFeed: isAllFeed,
                                      );

                                      _controller.clear();
                                    },
                            child:
                                commentController.isLoadingSend.value
                                    ? CustomLoader()
                                    : CustomContainer(
                                      backgroundColor: AppColors.primary,
                                      padding: 2,
                                      height: 32.h,
                                      width: 81.w,
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          CustomImage(imageSrc: AppIcons.send),
                                          SizedBox(width: 2.w),
                                          CustomText(
                                            text: "Send",
                                            color: AppColors.white,
                                          ),
                                        ],
                                      ),
                                    ),
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              } else {
                // Comments list
                RxList<CommentModel> commentList =
                    commentController.commentList.reversed.toList().obs;
                final comment = commentList[index - 1];
                return CommentWidget(
                  userName: "@${comment.authorName ?? "unknown"}",
                  commentText: comment.commentText ?? "no comment",
                );
              }
            },
          );
        }),
      ),
    );
  }
}
