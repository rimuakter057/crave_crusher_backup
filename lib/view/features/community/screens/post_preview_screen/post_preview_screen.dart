import 'dart:io';

import 'package:flutter/material.dart';

class PostPreviewScreen extends StatelessWidget {
  final String postText;
  final String? imagePath;

  const PostPreviewScreen({
    Key? key,
    required this.postText,
    this.imagePath,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Post Preview")),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Text(postText, style: TextStyle(fontSize: 16)),
            SizedBox(height: 20),
            if (imagePath != null && imagePath!.isNotEmpty)
              Image.file(
                File(imagePath!),
                width: double.infinity,
                height: 200,
                fit: BoxFit.cover,
              ),
          ],
        ),
      ),
    );
  }
}
