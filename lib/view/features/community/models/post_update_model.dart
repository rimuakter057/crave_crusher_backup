class PostUpdateModel {
  final String postId;
  final String content;
  final List<String> images; // API theke je image URL gulo asbe

  PostUpdateModel({
    required this.postId,
    required this.content,
    required this.images,
  });

  // JSON theke model e convert korar jonno
  factory PostUpdateModel.fromJson(Map<String, dynamic> json) {
    return PostUpdateModel(
      postId: json['postId'] ?? '',
      content: json['content'] ?? '',
      images: List<String>.from(json['images'] ?? []),
    );
  }

  // Model ke JSON e convert korar jonno
  Map<String, dynamic> toJson() {
    return {
      'postId': postId,
      'content': content,
      'images': images,
    };
  }
}
