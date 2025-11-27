import 'package:crave_crusher/view/features/community/screens/create_post_screen/create_post_screen.dart';
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
import '../../controllers/post_show_controller.dart';

import '../../widgets/common comunity widget.dart';
import '../../widgets/community_tab_selector.dart';


class CommunityAllFeedScreen extends StatelessWidget {
  CommunityAllFeedScreen({super.key});

  final CommunityTabController tabController = Get.find<CommunityTabController>();
  final PostShowController postController = Get.find<PostShowController>();
  final AddPostController addPostController = Get.find<AddPostController>();

  @override
  Widget build(BuildContext context) {
    if (postController.posts.isEmpty) {
      Future.microtask(() => postController.fetchPosts());
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
          await postController.fetchPosts();
        },
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.all(16.w),
            child: Obx(() {
              return Column(
                children: [
                  SizedBox(height: 16.h),

                  /// Tab Section
                  CommunityTabSelector(),
                  Gap(24.h),

                  // Post List
                  ListView.builder(
                    physics: const BouncingScrollPhysics(),
                    scrollDirection: Axis.vertical,
                    shrinkWrap: true,
                    itemCount: tabController.communityTabIndex.value == 0
                        ? postController.posts.length
                        : addPostController.myPosts.length,
                    itemBuilder: (context, index) {
                      if (tabController.communityTabIndex.value == 0) {
                        final post = postController.posts[index];
                        return Column(
                          children: [
                            CommonCommunityWidget(
                              profileTitle: post.author?.fullName ?? 'Unknown',
                              profileSubtitle: DateConverter.formattedTime(
                                  DateTime.parse(post.createdAt ?? DateTime.now().toString())),
                              profileImage: post.author?.profileImage ?? AppImages.profileManImage,
                              postText: post.content ?? "",
                              likesText: "${post.totalVotes ?? 0}",
                              commentsText: "${post.totalComments ?? 0}",
                              myPost: false,
                              index: index,
                            ),
                            SizedBox(height: 8.h),
                          ],
                        );
                      } else {
                        final post = addPostController.myPosts[index];
                        return Column(
                          children: [
                            CommonCommunityWidget(
                              profileTitle: "@You",
                              profileSubtitle: DateConverter.formattedTime(DateTime.now()),
                              profileImage: AppImages.profileManImage,
                              postText: post['content'] ?? "",
                              likesText: "0",
                              commentsText: "0",
                              myPost: true,
                              index: index,
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
