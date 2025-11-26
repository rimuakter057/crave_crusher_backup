import 'package:crave_crusher/view/components/custom_nav_bar/navbar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:crave_crusher/view/features/community/controllers/post_show_controller.dart';
import 'package:crave_crusher/view/features/community/models/post_model.dart';

class PostScreen extends StatelessWidget {
  final PostShowController postController = Get.find<PostShowController>();

  PostScreen({super.key}) {
    // Screen open hole fetch koro
    if (postController.posts.isEmpty) {
      postController.fetchPosts();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Posts")),
      body: Obx(() {
        if (postController.isLoading.value) return const Center(child: CircularProgressIndicator());
        if (postController.posts.isEmpty) return const Center(child: Text("No posts found"));
        return ListView.builder(
          itemCount: postController.posts.length,
          itemBuilder: (context, index) {
            final post = postController.posts[index];
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

