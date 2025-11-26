import 'package:crave_crusher/utils/app_images/app_images.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:crave_crusher/view/components/custom_app_bar/custom_app_bar.dart';
import 'package:crave_crusher/view/components/custom_nav_bar/navbar.dart';
import 'package:crave_crusher/view/features/community/controllers/community_tab_controller.dart';
import 'package:crave_crusher/view/features/community/controllers/post_show_controller.dart';
import 'package:crave_crusher/view/features/community/widgets/common%20comunity%20widget.dart';
import 'package:crave_crusher/view/features/community/widgets/community_tab_selector.dart';
import 'package:gap/gap.dart';

class CommunityAllFeedScreen extends StatelessWidget {
  CommunityAllFeedScreen({super.key});

  final CommunityTabController tabController = Get.find<CommunityTabController>();
  final PostShowController postController = Get.find<PostShowController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: NavBar(currentIndex: 2),
      appBar: CustomAppBar(
        title: 'Community',
        onActionPressed: () {
          // Navigate to CreatePostScreen
        },
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(16.w),
          child: Column(
            children: [
              SizedBox(height: 16.h),

              /// Tab selector using GetBuilder
              GetBuilder<CommunityTabController>(
                builder: (controller) {
                  return CommunityTabSelector(
                    onTabChanged: (index) {
                      controller.changeTab(index); // updates the selected tab
                    },
                  );
                },
              ),


              Gap(24.h),

              /// Posts list
              GetBuilder<PostShowController>(
                builder: (controller) {
                  if (controller.getPostsInProgress) {
                    return const Center(child: CircularProgressIndicator());
                  }

                  if (controller.errorMessage != null) {
                    return Center(
                      child: Text(
                        controller.errorMessage!,
                        style: const TextStyle(color: Colors.red),
                      ),
                    );
                  }

                  if (controller.posts.isEmpty) {
                    return const Center(child: Text('No posts available'));
                  }

                  // Display posts
                  return ListView.builder(
                    itemCount: controller.posts.length,
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemBuilder: (context, index) {
                      final post = controller.posts[index];
                      return Column(
                        children: [
                          CommonCommunityWidget(
                            profileTitle: post.author?.fullName ?? 'Unknown',
                            profileSubtitle: "27 Aug 2020 06:20 AM",
                            profileImage: AppImages.profileManImage, // replace with actual profile image
                            postText: post.content ?? '',
                            likesText: post.totalVotes.toString(),
                            commentsText: post.totalComments.toString(),
                            myPost: false, // set true if it's user's own post
                            index: 2, // number of images layout
                          ),
                          SizedBox(height: 8.h),
                        ],
                      );
                    },
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
