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
import '../../controllers/create_post_controller.dart';
import '../../controllers/get_post_controller.dart';
import '../../widgets/common comunity widget.dart';
import '../../widgets/community_tab_selector.dart';

class CommunityAllFeedScreen extends StatelessWidget {
  CommunityAllFeedScreen({super.key});

  final CommunityTabController tabController =
  Get.find<CommunityTabController>();
  final GetPostController getPostController = Get.find<GetPostController>();
  final AddPostController addPostController = Get.find<AddPostController>();

  @override
  Widget build(BuildContext context) {
    /// TAB CHANGE HOILE API AUTO CALL HOBE
    tabController.communityTabIndex.listen((index) {
      if (index == 0) {
        getPostController.fetchAllPosts();
      } else {
        getPostController.fetchMyPost();
      }
    });

    /// FIRST TIME ONLY ALL POST LOAD
    if (getPostController.allPostList.isEmpty) {
      Future.microtask(() => getPostController.fetchAllPosts());
    }

    return Scaffold(
      bottomNavigationBar: NavBar(currentIndex: 2),
      appBar: CustomAppBar(
        title: 'Community',
        onActionPressed: () {
          Get.to(CreatePostScreen());
        },
      ),
      body: RefreshIndicator(
        onRefresh: () async {
          if (tabController.communityTabIndex.value == 0) {
            await getPostController.fetchAllPosts();
          } else {
            await getPostController.fetchMyPost();
          }
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

                  /// POST LIST
                  ListView.builder(
                    physics: const BouncingScrollPhysics(),
                    scrollDirection: Axis.vertical,
                    shrinkWrap: true,
                    itemCount: tabController.communityTabIndex.value == 0
                        ? getPostController.allPostList.length
                        : getPostController.myPostList.length,
                    itemBuilder: (context, index) {
                      /// ----------------------------------
                      /// TAB: ALL POST (index = 0)
                      /// ----------------------------------
                      if (tabController.communityTabIndex.value == 0) {
                        final post = getPostController.allPostList[index];

                        return Column(
                          children: [
                            CommonCommunityWidget(
                              onTapUpdate: () {
                                Get.to(() => UpdatePostScreen());
                              },
                              onTapImageShow: () {
                                Get.to(() => CommunityImageShowScreen());
                              },
                              onTapProfile: () {
                                Get.to(() => ProfileScreen());
                              },
                              profileTitle:
                              post.author?.fullName ?? 'Unknown',
                              profileSubtitle: DateConverter.formattedTime(
                                DateTime.parse(post.createdAt ??
                                    DateTime.now().toString()),
                              ),
                              profileImage: post.author?.profileImage ??
                                  AppImages.profileManImage,
                              postText: post.content ?? "",
                              likesText: "${post.totalVotes ?? 0}",
                              commentsText: "${post.totalComments ?? 0}",
                              myPost: false,
                              index: index,

                              /// COMMENT NAVIGATION
                              onTapComment: () {
                                Get.to(() =>
                                    CommentScreen(postId: post.sId ?? ''));
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
                        final myPost = getPostController.myPostList[index];

                        return Column(
                          children: [
                            CommonCommunityWidget(
                              profileTitle: "@You",
                              profileSubtitle:
                              DateConverter.formattedTime(DateTime.now()),
                              profileImage: AppImages.profileManImage,
                              postText: myPost.content.toString(),
                              likesText: "0",
                              commentsText: "0",
                              myPost: true,
                              index: index,

                              /// COMMENT
                              onTapComment: () {
                                final postId = myPost.id;
                                if (postId != null) {
                                  Get.to(() =>
                                      CommentScreen(postId: postId));
                                }
                              },

                              onTapUpdate: () {
                                Get.to(() => UpdatePostScreen());
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
