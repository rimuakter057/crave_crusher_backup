class PostUpdateModel {
  final String postId;
  final String content;
  final List<String> images;

  PostUpdateModel({
    required this.postId,
    required this.content,
    required this.images,
  });


  factory PostUpdateModel.fromJson(Map<String, dynamic> json) {
    return PostUpdateModel(
      postId: json['postId'] ?? '',
      content: json['content'] ?? '',
      images: List<String>.from(json['images'] ?? []),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'postId': postId,
      'content': content,
      'images': images,
    };
  }
}
