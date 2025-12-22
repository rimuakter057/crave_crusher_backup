class CommentModel {
  final String? id;
  final String? postId;
  final String? authorId;
  final String? authorName;
  final String? commentText;
  final DateTime? createdAt;
  final DateTime? updatedAt;

  CommentModel({
    this.id,
    this.postId,
    this.authorId,
    this.authorName,
    this.commentText,
    this.createdAt,
    this.updatedAt,
  });

  factory CommentModel.fromJson(Map<String, dynamic> json) {
    return CommentModel(
      id: json['_id'],
      postId: json['postId'],
      authorId: json['authorId']?['_id'],
      authorName: json['authorId']?['fullName'],
      commentText: json['commentText'],
      createdAt: json['createdAt'] != null
          ? DateTime.parse(json['createdAt'])
          : null,
      updatedAt: json['updatedAt'] != null
          ? DateTime.parse(json['updatedAt'])
          : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      '_id': id,
      'postId': postId,
      'authorId': {
        '_id': authorId,
        'fullName': authorName,
      },
      'commentText': commentText,
      'createdAt': createdAt?.toIso8601String(),
      'updatedAt': updatedAt?.toIso8601String(),
    };
  }
}
