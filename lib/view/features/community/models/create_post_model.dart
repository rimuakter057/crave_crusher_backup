class CreatePostModel {
  String? authorId;       // user id
  String? content;
  List<String>? postImages;
  int? totalVotes;
  int? totalComments;
  bool? isDeleted;
  String? postId;

  CreatePostModel({
    this.authorId,
    this.content,
    this.postImages,
    this.totalVotes,
    this.totalComments,
    this.isDeleted,
    this.postId,
  });

  factory CreatePostModel.fromJson(Map<String, dynamic> json) {
    return CreatePostModel(
      authorId: json['authorId'],
      content: json['content'],
      postImages: json['post_images'] != null
          ? List<String>.from(json['post_images'])
          : [],
      totalVotes: json['totalVotes'],
      totalComments: json['totalComments'],
      isDeleted: json['isDeleted'],
      postId: json['_id'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'authorId': authorId,
      'content': content,
      'post_images': postImages,
      'totalVotes': totalVotes,
      'totalComments': totalComments,
      'isDeleted': isDeleted,
      '_id': postId,
    };
  }
}
