import 'package:crave_crusher/utils/app_colors/app_colors.dart';
import 'package:crave_crusher/utils/app_const/app_const.dart';
import 'package:crave_crusher/view/components/custom_text/custom_text.dart';
import 'package:crave_crusher/view/features/community/controllers/community_controller.dart';
import 'package:crave_crusher/view/features/community/screens/comment_screen/comment_screen.dart';
import 'package:crave_crusher/view/features/community/screens/community_image_show_screen/community_image_show_screen.dart';
import 'package:crave_crusher/view/features/community/screens/create_post_screen/create_post_screen.dart';
import 'package:crave_crusher/view/features/community/screens/update_post_screen/update_post_screen.dart';
import 'package:crave_crusher/view/features/community/widgets/shimmer_widget.dart';
import 'package:crave_crusher/view/features/profile/profile_screen/profile_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import '../../../../../helper/time_converter/date_converter.dart';
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
      } else if (index == 1) {
        postController.fetchMyPost();
      }
    });

    // final postId = postController.allPostList.map((e) => e.id??'').toString();

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
          } else if (tabController.communityTabIndex.value == 1) {
            await postController.fetchMyPost();
          }
          // await postController.fetchMyPost();
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

                  if (tabController.communityTabIndex.value == 0) ...[
                    if (postController.isLoadingAllPost.value)
                      const PostShimmerLoader()
                    else if (postController.allPostList.isEmpty)
                      Center(
                        child: Padding(
                          padding: EdgeInsets.symmetric(vertical: 50.h),
                          child: CustomText(text: "No posts available"),
                        ),
                      )
                    else
                      ListView.builder(
                        physics: const BouncingScrollPhysics(),
                        scrollDirection: Axis.vertical,
                        shrinkWrap: true,
                        itemCount: postController.allPostList.length,
                        itemBuilder: (context, index) {
                          final post = postController.allPostList[index];
                          return Column(
                            children: [
                              Obx(() {
                                final postId = post.id ?? "";
                                final isLiked = communityController
                                    .userVotedPosts
                                    .contains(postId);
                                return CommonCommunityWidget(
                                  profileTitle: post.author?.fullName ?? '...',
                                  profileSubtitle: DateConverter.formattedTime(
                                    post.createdAt ?? DateTime.now(),
                                  ),
                                  profileImage: AppConstants.unknown,
                                  postImages: post.postImages ?? [],
                                  postText: post.content ?? "",
                                  onTapProfile:
                                      () => Get.to(() => ProfileScreen()),
                                  onTapImageShow:
                                      () => Get.to(
                                        () => CommunityImageShowScreen(),
                                      ),
                                  favouriteWidget: Row(
                                    children: [
                                      IconButton(
                                        onPressed:
                                            () => communityController.addVote(
                                              postId,
                                            ),
                                        icon: Icon(
                                          isLiked
                                              ? Icons.favorite
                                              : Icons.favorite_border,
                                          color: AppColors.red,
                                          size: 20.w,
                                        ),
                                      ),
                                      SizedBox(width: 4.w),
                                      CustomText(
                                        text: "${post.totalVotes ?? 0}",
                                      ),
                                    ],
                                  ),
                                  onTapComment:
                                      () => Get.to(
                                        () => CommentScreen(
                                          postId: post.id ?? '',
                                        ),
                                      ),
                                  commentsText: "${post.totalComments ?? 0}",
                                  myPost: false,
                                  index: index,
                                );
                              }),
                              SizedBox(height: 8.h),
                            ],
                          );
                        },
                      ),
                  ],

                  if (tabController.communityTabIndex.value == 1) ...[
                    if (postController.isLoadingPost.value)
                      const PostShimmerLoader()
                    else if (postController.myPostList.isEmpty)
                      Center(
                        child: Padding(
                          padding: EdgeInsets.symmetric(vertical: 50.h),
                          child: CustomText(text: "No posts available"),
                        ),
                      )
                    else
                      ListView.builder(
                        physics: const BouncingScrollPhysics(),
                        scrollDirection: Axis.vertical,
                        shrinkWrap: true,
                        itemCount: postController.myPostList.length,
                        itemBuilder: (context, index) {
                          final myPost = postController.myPostList[index];

                          return Column(
                            children: [
                             Obx((){
                               final postId = myPost.id;
                               final isLiked = communityController
                                   .userVotedPosts
                                   .contains(postId);

                               final totalLikes =
                                   communityController
                                       .votesNumberPerPost[postId] ??
                                       myPost.totalVotes ??
                                       000;

                               return                             CommonCommunityWidget(
                                 profileTitle: myPost.totalVotes.toString(),
                                 profileSubtitle: DateConverter.formattedTime(
                                   DateTime.now(),
                                 ),
                                 profileImage: AppConstants.unknown,
                                 postImages: myPost.postImages ?? [],
                                 postText: myPost.content.toString(),
                                 favouriteWidget:


                                   Row(
                                     children: [
                                       IconButton(
                                         onPressed: () {
                                           communityController.addVote(
                                             myPost.id.toString(),
                                           );
                                         },
                                         icon: Icon(
                                           isLiked
                                               ? Icons.favorite
                                               : Icons.favorite_border,
                                           color: AppColors.red,
                                           size: 20.w,
                                         ),
                                       ),
                                       SizedBox(width: 4.w),
                                       CustomText(text: totalLikes.toString()),
                                     ],
                                   ),













                                 commentsText: myPost.totalComments.toString(),
                                 myPost: true,
                                 index: index,

                                 /// COMMENT
                                 onTapComment: () {
                                   Get.to(
                                         () =>
                                         CommentScreen(postId: myPost.id ?? ''),
                                   );
                                 },

                                 onTapUpdate: () {
                                   final content = myPost.content;
                                   final postId = myPost.id;
                                   if (postId != null && content != null) {
                                     Get.to(
                                           () => UpdatePostScreen(
                                         postId: postId,
                                         content: content,
                                       ),
                                     );
                                   }
                                 },
                                 onTapImageShow: () {
                                   Get.to(() => CommunityImageShowScreen());
                                 },
                                 onTapProfile: () {
                                   Get.to(() => ProfileScreen());
                                 },
                               );

                             }),
                              SizedBox(height: 8.h),
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
