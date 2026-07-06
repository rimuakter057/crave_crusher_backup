import 'package:crave_crusher/helper/responsive_helper/responsive_helper.dart';
import 'package:crave_crusher/utils/app_colors/app_colors.dart';
import 'package:crave_crusher/utils/app_const/app_const.dart';
import 'package:crave_crusher/view/components/common_empty/common_empty_widget.dart';
import 'package:crave_crusher/view/components/custom_refresh_indicator/custom_refresh_indicator.dart';
import 'package:crave_crusher/view/components/custom_text/custom_text.dart';
import 'package:crave_crusher/view/features/community/controllers/community_controller.dart';
import 'package:crave_crusher/view/features/community/models/post_update_model.dart';
import 'package:crave_crusher/view/features/community/screens/comment_screen/comment_screen.dart';
import 'package:crave_crusher/view/features/community/screens/community_image_show_screen/community_image_show_screen.dart';
import 'package:crave_crusher/view/features/community/screens/create_post_screen/create_post_screen.dart';
import 'package:crave_crusher/view/features/community/screens/update_post_screen/update_post_screen.dart';
import 'package:crave_crusher/view/features/community/widgets/shimmer_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import '../../../../../helper/time_converter/date_converter.dart';
import '../../../../../utils/app_icons/app_icons.dart';
import '../../../../components/custom_app_bar/custom_app_bar.dart';
import '../../../../components/custom_nav_bar/navbar.dart';
import '../../controllers/post_controller.dart';
import '../../widgets/common comunity widget.dart';
import '../../widgets/community_tab_selector.dart';
import '../community_user_profile_screen/community_profile_screen.dart';

class CommunityAllFeedScreen extends StatefulWidget {
  final int initialTabIndex;
  const CommunityAllFeedScreen({super.key, this.initialTabIndex = 0});

  @override
  State<CommunityAllFeedScreen> createState() => _CommunityAllFeedScreenState();
}

class _CommunityAllFeedScreenState extends State<CommunityAllFeedScreen> {
  final PostController postController = Get.find<PostController>();
  final CommunityController communityController =
      Get.find<CommunityController>();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      communityController.communityTabIndex.value = widget.initialTabIndex;

      if (widget.initialTabIndex == 0) {
        postController.fetchAllPosts();
      } else {
        postController.fetchMyPost();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    communityController.communityTabIndex.listen((index) {
      if (index == 0) {
        postController.fetchAllPosts();
      } else if (index == 1) {
        postController.fetchMyPost();
      }
    });

    // Load posts once
    if (postController.allPostList.isEmpty) {
      Future.microtask(() async {
        await postController.fetchAllPosts();
      });
    }

    return Scaffold(
      bottomNavigationBar: NavBar(currentIndex: 2),
      appBar: CustomAppBar(
        title: 'Community',
        onActionPressed: () {
          Get.to(() => CreatePostScreen());
        },
      ),
      body: CustomRefreshIndicator(
        onRefresh: () async {
          if (communityController.communityTabIndex.value == 0) {
            await postController.fetchAllPosts();
          } else if (communityController.communityTabIndex.value == 1) {
            await postController.fetchMyPost();
          }
        },
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.all(ResponsiveHelper.width(16)),
            child: Obx(() {
              final currentTab = communityController.communityTabIndex.value;

              return Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(height: ResponsiveHelper.height(16)),
                  CommunityTabSelector(),
                  Gap(24.h),

                  /// All Posts
                  if (currentTab == 0) ...[
                    if (postController.isLoadingAllPost.value)
                      const PostShimmerLoader()
                    else if (postController.allPostList.isEmpty)
                      EmptyWidget(title: "No posts available yet")
                    else
                      ListView.builder(
                        physics: const BouncingScrollPhysics(),
                        scrollDirection: Axis.vertical,
                        shrinkWrap: true,
                        itemCount: postController.allPostList.length,
                        itemBuilder: (context, index) {
                          final postList =
                              postController.allPostList.reversed.toList();
                          final post = postList[index];

                          return Column(
                            children: [
                              Obx(() {
                                final postId = post.id ?? "";

                                return CommonCommunityWidget(
                                  profileTitle: "@${post.author?.fullName}",
                                  time: DateConverter.dateYearTimeUtc(
                                    post.createdAt.toString(),
                                  ),
                                  postImages: post.postImages,
                                  postText: post.content ?? "",
                                  commentsText: "${post.totalComments ?? 0}",
                                  favouriteWidget: Row(
                                    children: [
                                      IconButton(
                                        onPressed: () async {
                                          communityController.addVote(
                                            postId: postId,
                                            index: index,
                                            isMyPost: false,
                                            hasVoted: post.hasVoted.value,
                                          );
                                          await postController.fetchMyPost();
                                        },
                                        icon: SvgPicture.asset(
                                          post.hasVoted.value
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
                                      SizedBox(
                                        width: ResponsiveHelper.width(4),
                                      ),
                                      CustomText(
                                        text: "${post.totalVotes.value}",
                                      ),
                                    ],
                                  ),
                                  profileImage:
                                      post.author?.profileImage ??
                                      AppConstants.unknown,
                                  onTapProfile: () {
                                    Get.to(
                                      () => CommunityProfileScreen(
                                        userId: post.author?.id ?? '',
                                        profileName: "${post.author?.fullName}",
                                        profileImage: post.author?.profileImage,
                                      ),
                                    );
                                  },
                                  onTapImageShow:
                                      () => Get.to(
                                        () => CommunityImageShowScreen(
                                          images: post.postImages,
                                        ),
                                      ),
                                  onTapComment:
                                      () => Get.to(
                                        () => CommentScreen(
                                          postId: post.id ?? '',
                                        ),
                                      ),
                                  myPost: false,
                                  index: index,
                                );
                              }),
                              SizedBox(height: ResponsiveHelper.height(8)),
                            ],
                          );
                        },
                      ),
                  ],

                  /// My Posts
                  if (currentTab == 1) ...[
                    if (postController.isLoadingPost.value)
                      const PostShimmerLoader()
                    else if (postController.getMyPostList.isEmpty)
                      SizedBox(

                          height: MediaQuery.of(context).size.height * 0.5,
                          child: EmptyWidget(title: "No post available yet."))
                    else
                      ListView.builder(
                        physics: const BouncingScrollPhysics(),
                        scrollDirection: Axis.vertical,
                        shrinkWrap: true,
                        itemCount: postController.getMyPostList.length,
                        itemBuilder: (context, index) {
                          final myPost =
                              postController.getMyPostList.reversed
                                  .toList()[index];

                          return Column(
                            children: [
                              Obx(() {
                                final postId = myPost.id ?? '';

                                return CommonCommunityWidget(
                                  profileTitle: "@${myPost.author?.fullName}",
                                  time: DateConverter.dateYearTimeUtc(
                                    myPost.createdAt.toString(),
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
                                      SizedBox(
                                        width: ResponsiveHelper.width(4),
                                      ),
                                      CustomText(
                                        text: "${myPost.totalVotes.value}",
                                      ),
                                    ],
                                  ),
                                  myPost: true,
                                  index: index,
                                  onTapComment: () {
                                    Get.to(
                                      () => CommentScreen(
                                        postId: myPost.id ?? '',
                                      ),
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
                                        () => UpdatePostScreen(
                                          updatePostData: model,
                                        ),
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
                                  onTapProfile: () {
                                    Get.to(
                                      () => CommunityProfileScreen(
                                        userId: myPost.author?.id ?? '',
                                        profileName:
                                            "${myPost.author?.fullName}",
                                        profileImage:
                                            myPost.author?.profileImage,
                                      ),
                                    );
                                  },
                                );
                              }),
                              SizedBox(height: ResponsiveHelper.height(8)),
                            ],
                          );
                        },
                      ),
                  ],
                ],
              );
            }),
          ),
        ),
      ),
    );
  }
}
