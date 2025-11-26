
import 'package:crave_crusher/utils/app_images/app_images.dart';
import 'package:crave_crusher/view/components/custom_app_bar/custom_app_bar.dart';
import 'package:crave_crusher/view/components/custom_nav_bar/navbar.dart';
import 'package:crave_crusher/view/features/community/controllers/community_tab_controller.dart';
import 'package:crave_crusher/view/features/community/controllers/post_show_controller.dart';
import 'package:crave_crusher/view/features/community/screens/create_post_screen/create_post_screen.dart';
import 'package:crave_crusher/view/features/community/widgets/common%20comunity%20widget.dart';
import 'package:crave_crusher/view/features/community/widgets/community_tab_selector.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';

class CommunityAllFeedScreen extends StatelessWidget {
  CommunityAllFeedScreen({super.key});

  final CommunityTabController tabController = Get.find<CommunityTabController>();
  final PostShowController postController = Get.find<PostShowController>();

  @override
  Widget build(BuildContext context) {
    // Fetch posts if not already fetched
    if (postController.posts.isEmpty) {
      Future.microtask(() => postController.fetchPosts());
    }

    return Scaffold(
      bottomNavigationBar: NavBar(currentIndex: 2),
      appBar: CustomAppBar(
        title: 'Community',
        onActionPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => CreatePostScreen()),
          );
        },
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(16.w),
          child: Obx(() {
            return Column(
              children: [
                SizedBox(height: 16.h),

                /// tab section
                CommunityTabSelector(),
                Gap(24.h),

                if (tabController.communityTabIndex.value == 0) ...[
                  ListView.builder(
                    physics: const BouncingScrollPhysics(),
                    scrollDirection: Axis.vertical,
                    itemCount: postController.posts.length,
                    shrinkWrap: true,
                    itemBuilder: (context, index) {
                      final post = postController.posts[index];
                      return Column(
                        children: [
                          CommonCommunityWidget(
                            profileTitle: "@${post.content}", // dynamic
                            profileSubtitle: "27 Aug 2020 06:20 AM", // static
                            profileImage: AppImages.profileManImage, // static
                            postText:
                            "Day 10 of my Smoking Battle! 🚭\nIt’s honestly been one of the toughest things I’ve done, "
                                "but waking up without that morning cough feels incredible. "
                                "I used to light up without thinking — now, I pause, breathe, and remind myself why I started this fight. "
                                "My monster still whispers sometimes, but it’s losing its voice. 💪🔥", // static
                            likesText: "${post.totalVotes}", // dynamic
                            commentsText: "${post.totalComments}", // dynamic
                            myPost: false, // static
                            index: 2, // static
                          ),

                          SizedBox(height: 8.h),
                        ],
                      );
                    },
                  ),
                ],

                if (tabController.communityTabIndex.value == 1) ...[
                  ListView.builder(
                    physics: const BouncingScrollPhysics(),
                    scrollDirection: Axis.vertical,
                    itemCount: postController.posts.length,
                    shrinkWrap: true,
                    itemBuilder: (context, index) {
                      final post = postController.posts[index];
                      return Column(
                        children: [
                          CommonCommunityWidget(
                            profileTitle: "@${post.content}", // dynamic
                            profileSubtitle: "27 Aug 2020 06:20 AM", // static
                            profileImage: AppImages.profileManImage, // static
                            postText:
                            "Day 10 of my Smoking Battle! 🚭\nIt’s honestly been one of the toughest things I’ve done, "
                                "but waking up without that morning cough feels incredible. "
                                "I used to light up without thinking — now, I pause, breathe, and remind myself why I started this fight. "
                                "My monster still whispers sometimes, but it’s losing its voice. 💪🔥", // static
                            likesText: "${post.totalVotes}", // dynamic
                            commentsText: "${post.totalComments}", // dynamic
                            myPost: false, // static
                            index: 2, // static
                          ),

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
    );
  }
}


















