import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:crave_crusher/view/features/community/controllers/post_show_controller.dart';
import 'package:crave_crusher/view/features/community/models/post_model.dart';

class PostScreen extends StatefulWidget {
  const PostScreen({super.key});

  @override
  State<PostScreen> createState() => _PostScreenState();
}

class _PostScreenState extends State<PostScreen> {
  final PostShowController controller = Get.find<PostShowController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Community Posts')),
      body: GetBuilder<PostShowController>(
        builder: (_) {
          // Show loader
          if (controller.getPostsInProgress) {
            return const Center(child: CircularProgressIndicator());
          }

          // Show error
          if (controller.errorMessage != null) {
            return Center(
              child: Text(
                controller.errorMessage!,
                style: const TextStyle(color: Colors.red),
              ),
            );
          }

          // No posts
          if (controller.posts.isEmpty) {
            return const Center(child: Text('No posts available'));
          }

          // Display posts
          return ListView.builder(
            itemCount: controller.posts.length,
            itemBuilder: (context, index) {
              final Data post = controller.posts[index];
              return Card(
                margin: const EdgeInsets.all(8),
                child: Padding(
                  padding: const EdgeInsets.all(12),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        post.author?.fullName ?? 'Unknown',
                        style: const TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 16),
                      ),
                      const SizedBox(height: 6),
                      Text(post.content ?? ''),
                      const SizedBox(height: 6),
                      if (post.postImages != null && post.postImages!.isNotEmpty)
                        SizedBox(
                          height: 100,
                          child: ListView.builder(
                            scrollDirection: Axis.horizontal,
                            itemCount: post.postImages!.length,
                            itemBuilder: (context, imgIndex) {
                              return Padding(
                                padding: const EdgeInsets.only(right: 8),
                                child: Image.network(
                                  post.postImages![imgIndex],
                                  width: 100,
                                  height: 100,
                                  fit: BoxFit.cover,
                                  errorBuilder: (_, __, ___) =>
                                  const Icon(Icons.broken_image),
                                ),
                              );
                            },
                          ),
                        ),
                      const SizedBox(height: 6),
                      Text(
                          'Votes: ${post.totalVotes} | Comments: ${post.totalComments}'),
                    ],
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
