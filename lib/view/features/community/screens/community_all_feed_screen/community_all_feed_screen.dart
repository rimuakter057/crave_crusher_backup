import 'package:crave_crusher/utils/app_colors/app_colors.dart';
import 'package:crave_crusher/view/components/custom_text/custom_text.dart';
import 'package:crave_crusher/view/features/community/controllers/community_controller.dart';
import 'package:crave_crusher/view/features/community/screens/comment_screen/comment_screen.dart';
import 'package:crave_crusher/view/features/community/screens/community_image_show_screen/community_image_show_screen.dart';
import 'package:crave_crusher/view/features/community/screens/create_post_screen/create_post_screen.dart';
import 'package:crave_crusher/view/features/community/screens/update_post_screen/update_post_screen.dart';
import 'package:crave_crusher/view/features/profile/profile_screen/profile_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:gap/gap.dart';
import '../../../../../helper/time_converter/date_converter.dart';
import '../../../../../utils/app_images/app_images.dart';
import '../../../../components/custom_app_bar/custom_app_bar.dart';
import '../../../../components/custom_nav_bar/navbar.dart';
import '../../controllers/community_tab_controller.dart';
import '../../controllers/post_controller.dart';
import '../../widgets/common comunity widget.dart';
import '../../widgets/community_tab_selector.dart';

class CommunityAllFeedScreen extends StatelessWidget {
  CommunityAllFeedScreen({super.key});

  final CommunityTabController tabController =
      Get.find<CommunityTabController>();
  final PostController postController = Get.find<PostController>();
  final CommunityController communityController =
      Get.find<CommunityController>();

  @override
  Widget build(BuildContext context) {
    /// TAB CHANGE HOILE API AUTO CALL HOBE
    tabController.communityTabIndex.listen((index) {
      if (index == 0) {
        postController.fetchAllPosts();
      } else {
        postController.fetchMyPost();
      }
    });

    final postId=postController.allPostList.map((e) => e.sId!).toString();


    // Load posts and votes once
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
      body: RefreshIndicator(
        onRefresh: () async {
          if (tabController.communityTabIndex.value == 0) {
            await postController.fetchAllPosts();
          } else {
            await postController.fetchMyPost();
          }
          await postController.fetchMyPost();
        },
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.all(16.w),
            child: Obx(() {
              return Column(
                children: [
                  SizedBox(height: 16.h),

                  /// TAB SELECTOR
                  CommunityTabSelector(),
                  Gap(24.h),

                  if(tabController.communityTabIndex.value == 0)...[],

                  /// POST LIST
                  ListView.builder(
                    physics: const BouncingScrollPhysics(),
                    scrollDirection: Axis.vertical,
                    shrinkWrap: true,
                    itemCount:
                        tabController.communityTabIndex.value == 0
                            ? postController.allPostList.length
                            : postController.myPostList.length,
                    itemBuilder: (context, index) {
                      /// ----------------------------------
                      /// TAB: ALL POST (index = 0)
                      /// ----------------------------------
                      if (tabController.communityTabIndex.value == 0) {
                        final post = postController.allPostList[index];

                        return Column(
                          children: [
                            CommonCommunityWidget(
                              // Favourite widget
                              favouriteWidget: Obx(() {
                                final postId = post.sId!;
                                final isLiked = communityController.userVotedPosts.contains(postId);
                             return Row(
                                  children: [
                                    IconButton(
                                      onPressed: () {
                                        communityController.addVote(postId);
                                      },
                                      icon: Icon(
                                        isLiked ? Icons.favorite : Icons.favorite_border,
                                        color: AppColors.red,
                                        size: 20.w,
                                      ),
                                    ),
                                    SizedBox(width: 4.w),
                                    CustomText(text:"${post.totalVotes ?? 00}",),
                                  ],
                                );
                              }),



                              onTapImageShow: () {
                                Get.to(() => CommunityImageShowScreen());
                              },
                              onTapProfile: () {
                                Get.to(() => ProfileScreen());
                              },

                              profileTitle: post.author?.fullName ?? 'Unknown',
                              profileSubtitle: DateConverter.formattedTime(
                                DateTime.parse(
                                  post.createdAt ?? DateTime.now().toString(),
                                ),
                              ),
                              profileImage:
                                  post.author?.profileImage ??
                                  AppImages.profileManImage,
                              postText: post.content ?? "",
                              commentsText: "${post.totalComments ?? 00}",
                              myPost: false,
                              index: index,

                              /// COMMENT NAVIGATION
                              onTapComment: () {
                                Get.to(
                                  () => CommentScreen(postId: post.sId ?? ''),
                                );
                              },
                            ),
                            SizedBox(height: 8.h),
                          ],
                        );
                      }
                      /// ----------------------------------
                      /// TAB: MY POST (index = 1)
                      /// ----------------------------------
                      else {
                        final myPost = postController.myPostList[index];

                        return Column(
                          children: [
                            CommonCommunityWidget(
                              profileTitle: "@You",
                              profileSubtitle: DateConverter.formattedTime(
                                DateTime.now(),
                              ),
                              profileImage: AppImages.profileManImage,
                              postText: myPost.content.toString(),
                              favouriteWidget: Obx(() {
                                final postId = myPost.id;
                                final isLiked = communityController.userVotedPosts.contains(postId);
                                final totalLikes =
                                    communityController.votesNumberPerPost[postId] ?? myPost.totalVotes ?? 0;

                                return Row(
                                  children: [
                                    IconButton(
                                      onPressed: () {
                                        communityController.addVote(myPost.id.toString());
                                      },
                                      icon: Icon(
                                        isLiked ? Icons.favorite : Icons.favorite_border,
                                        color: AppColors.red,
                                        size: 20.w,
                                      ),
                                    ),
                                    SizedBox(width: 4.w),
                                    CustomText(text: totalLikes.toString()),
                                  ],
                                );
                              }),

                              commentsText: "0",
                              myPost: true,
                              index: index,

                              /// COMMENT
                              onTapComment: () {
                                final postId = myPost.id;
                                if (postId != null) {
                                  Get.to(() => CommentScreen(postId: postId));
                                }
                              },

                              onTapUpdate: () {
                                 final content=myPost.content;
                                final postId = myPost.id;
                                if (postId != null && content != null) {
                                  Get.to(() => UpdatePostScreen(postId: postId,content: content,));
                                }
                                // Get.to(
                                //   () => UpdatePostScreen(),
                                //   arguments: {
                                //     "id": myPost.id,
                                //     "content": myPost.content,
                                //   },
                                // );
                              },
                              onTapImageShow: () {
                                Get.to(() => CommunityImageShowScreen());
                              },
                              onTapProfile: () {
                                Get.to(() => ProfileScreen());
                              },
                            ),
                            SizedBox(height: 8.h),
                          ],
                        );
                      }
                    },
                  ),
                ],
              );
            }),
          ),
        ),
      ),
    );
  }
}
