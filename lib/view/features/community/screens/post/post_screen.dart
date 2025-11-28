import 'package:crave_crusher/view/components/custom_nav_bar/navbar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:crave_crusher/view/features/community/controllers/get_post_controller.dart';
import 'package:crave_crusher/view/features/community/models/post_model.dart';

class PostScreen extends StatelessWidget {
  final GetPostController postController = Get.find<GetPostController>();

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
        if (postController.isLoading.value) return const Center(child: CircularProgressIndicator());
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

