class VoteModel {
  final String id;
  final String userId;
  final String postId;
  final DateTime createdAt;

  VoteModel({
    required this.id,
    required this.userId,
    required this.postId,
    required this.createdAt,
  });

  factory VoteModel.fromJson(Map<String, dynamic> json) {
    return VoteModel(
      id: json['_id'],
      userId: json['userId'],
      postId: json['postId'],
      createdAt: DateTime.parse(json['createdAt']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      '_id': id,
      'userId': userId,
      'postId': postId,
      'createdAt': createdAt.toIso8601String(),
    };
  }
}
