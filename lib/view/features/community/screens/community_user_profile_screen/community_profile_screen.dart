// ignore_for_file: deprecated_member_use

import 'package:crave_crusher/helper/images_handler/image_handler.dart';
import 'package:crave_crusher/helper/responsive_helper/responsive_helper.dart';
import 'package:crave_crusher/helper/time_converter/date_converter.dart';
import 'package:crave_crusher/utils/app_colors/app_colors.dart';
import 'package:crave_crusher/utils/app_const/app_const.dart';
import 'package:crave_crusher/utils/app_icons/app_icons.dart';
import 'package:crave_crusher/view/components/common_empty/common_empty_widget.dart';
import 'package:crave_crusher/view/components/common_profile/avatar_widget.dart';
import 'package:crave_crusher/view/components/custom_nav_bar/navbar.dart';
import 'package:crave_crusher/view/components/custom_svg_icon/custom_svg_icon.dart';
import 'package:crave_crusher/view/components/custom_text/custom_text.dart';
import 'package:crave_crusher/view/features/community/controllers/community_controller.dart';
import 'package:crave_crusher/view/features/community/controllers/post_controller.dart';
import 'package:crave_crusher/view/features/community/models/post_update_model.dart';
import 'package:crave_crusher/view/features/community/screens/comment_screen/comment_screen.dart';
import 'package:crave_crusher/view/features/community/screens/community_user_profile_screen/widgets/profile_status_container.dart';
import 'package:crave_crusher/view/features/community/screens/update_post_screen/update_post_screen.dart';
import 'package:crave_crusher/view/features/community/widgets/common%20comunity%20widget.dart';
import 'package:crave_crusher/view/features/community/widgets/shimmer_widget.dart';
import 'package:crave_crusher/view/features/profile/controllers/profile_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';

import '../community_image_show_screen/community_image_show_screen.dart';

class CommunityProfileScreen extends StatefulWidget {
  const CommunityProfileScreen({
    super.key,
    required this.userId,
    required this.profileName,
    this.profileImage,
  });

  final String userId;
  final String profileName;
  final String? profileImage;

  @override
  State<CommunityProfileScreen> createState() => _CommunityProfileScreenState();
}

class _CommunityProfileScreenState extends State<CommunityProfileScreen> {
  final PostController postController = Get.find<PostController>();
  final ProfileController profileController = Get.find<ProfileController>();

  @override
  void initState() {
    super.initState();
    debugPrint("userId:============================== ${widget.userId}");
    WidgetsBinding.instance.addPostFrameCallback((_) {
      postController.fetchSingleUserProfile(widget.userId);
    });
  }

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
            width: ResponsiveHelper.width(50),
            height: ResponsiveHelper.height(50),
            alignment: Alignment.center,
            decoration: BoxDecoration(
              color: AppColors.subPrimary.withOpacity(.3),
              shape: BoxShape.circle,
              border: Border.all(color: AppColors.subPrimary),
            ),
            child: IconButton(
              onPressed: () {
                Get.back();
              },
              icon: CustomSvgIcon(icon: AppIcons.backButton),
            ),
          ),
        ),
        centerTitle: true,
        title: CustomText(
          text: "Community",
          fontSize: ResponsiveHelper.fontSize(18),
          fontWeight: FontWeight.w500,
        ),
      ),

      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: ResponsiveHelper.width(16)),
          child: Column(
            children: [
              ///profile image
              Obx(() {
                //  final profile = profileController.myProfile.value;

                return Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    ProfileAvatarWidget(
                      imagePath: ImageHandler.imagesHandle(
                        widget.profileImage,
                        isProfile: true,
                      ),
                    ),

                    Gap(ResponsiveHelper.height(16)),
                    CustomText(
                      text: widget.profileName,
                      fontWeight: FontWeight.w600,
                      fontSize: ResponsiveHelper.fontSize(18),
                    ),
                  ],
                );
              }),

              Gap(24.h),

              /// profile details section
              Obx(() {
                return Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    ProfileStatusContainer(
                      number: postController.totalPost.value,
                      title: "Posts",
                    ),
                    ProfileStatusContainer(
                      number: postController.totalReaction.value,
                      title: 'Reaction',
                    ),
                    ProfileStatusContainer(
                      number: postController.totalBadge.value,
                      title: 'badge',
                    ),
                  ],
                );
              }),

              Gap(24.h),

              Obx(() {
                if (postController.isLoadingSingleUser.value) {
                  return const PostShimmerLoader();
                } else if (postController.singleUserProfileList.isEmpty) {
                  return EmptyWidget(title: "Post is not available");
                } else {
                  return ListView.builder(
                    physics: const BouncingScrollPhysics(),
                    scrollDirection: Axis.vertical,
                    shrinkWrap: true,
                    itemCount: postController.singleUserProfileList.length,
                    itemBuilder: (context, index) {
                      final myPost =
                          postController.singleUserProfileList.reversed
                              .toList()[index];
                      final CommunityController communityController =
                          Get.find<CommunityController>();
                      final postId = myPost.id ?? '';
                      return Column(
                        children: [
                          CommonCommunityWidget(
                            profileTitle: myPost.author?.fullName ?? '...',
                            time: DateConverter.formattedTime(
                              myPost.createdAt ?? DateTime.now(),
                            ),
                            profileImage:
                                myPost.author?.profileImage ??
                                AppConstants.unknown,
                            postImages: myPost.postImages,
                            postText: myPost.content ?? "",
                            commentsText: "${myPost.totalComments ?? 0}",
                            favouriteWidget: Row(
                              children: [
                                IconButton(
                                  onPressed:
                                      () => communityController.addVote(
                                        postId: postId,
                                        index: index,
                                        isMyPost: true,
                                        hasVoted: myPost.hasVoted.value,
                                      ),

                                  icon: SvgPicture.asset(
                                    myPost.hasVoted.value
                                        ? AppIcons
                                            .favorite // filled heart svg
                                        : AppIcons
                                            .favoriteOutline, // outline heart svg
                                    width: ResponsiveHelper.width(18),
                                    height: ResponsiveHelper.height(18),
                                    colorFilter: ColorFilter.mode(
                                      AppColors.red,
                                      BlendMode.srcIn,
                                    ),
                                  ),
                                ),
                                SizedBox(width: ResponsiveHelper.width(4)),
                                CustomText(text: "${myPost.totalVotes.value}"),
                              ],
                            ),

                            index: index,

                            /// COMMENT
                            onTapComment: () {
                              Get.to(
                                () => CommentScreen(postId: myPost.id ?? ''),
                              );
                            },
                            onTapUpdate: () {
                              final content = myPost.content;
                              final postId = myPost.id;
                              if (postId != null && content != null) {
                                PostUpdateModel model = PostUpdateModel(
                                  postId: postId,
                                  content: content,
                                  images: myPost.postImages,
                                );

                                Get.to(
                                  () => UpdatePostScreen(updatePostData: model),
                                );
                              }
                            },
                            onTapImageShow: () {
                              Get.to(
                                () => CommunityImageShowScreen(
                                  images: myPost.postImages,
                                ),
                              );
                            },
                            onTapProfile: () {},
                          ),

                          SizedBox(height: ResponsiveHelper.height(8)),
                        ],
                      );
                    },
                  );
                }
              }),
            ],
          ),
        ),
      ),
    );
  }
}
