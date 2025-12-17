import 'package:crave_crusher/view/components/custom_loader/custom_loader.dart';
import 'package:crave_crusher/view/components/custom_nav_bar/navbar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:crave_crusher/view/features/community/controllers/post_controller.dart';
import 'package:crave_crusher/view/features/community/models/all_post_model.dart';

class PostScreen extends StatelessWidget {
  final PostController postController = Get.find<PostController>();

  PostScreen({super.key}) {
    // Screen open hole fetch koro
    if (postController.allPostList.isEmpty) {
      postController.fetchAllPosts();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Posts")),
      body: Obx(() {
        if (postController.isLoadingAllPost.value) return const Center(child: CustomLoader());
        if (postController.allPostList.isEmpty) return const Center(child: Text("No posts found"));
        return ListView.builder(
          itemCount: postController.allPostList.length,
          itemBuilder: (context, index) {
            final post = postController.allPostList[index];
            return ListTile(
              title: Text(post.content ?? ""),
              subtitle: Text("Votes: ${post.totalVotes} | Comments: ${post.totalComments}"),
            );
          },
        );
      })

    );
  }
}

