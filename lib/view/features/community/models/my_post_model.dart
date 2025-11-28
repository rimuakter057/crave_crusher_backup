class MyPostModel {
  final String? id;
  final String? content;
  final List<String>? postImages;
  final int? totalVotes;
  final int? totalComments;
  final bool? isDeleted;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final bool? hasVoted;

  MyPostModel({
    this.id,
    this.content,
    this.postImages,
    this.totalVotes,
    this.totalComments,
    this.isDeleted,
    this.createdAt,
    this.updatedAt,
    this.hasVoted,
  });

  factory MyPostModel.fromJson(Map<String, dynamic> json) => MyPostModel(
    id: json["_id"],
    content: json["content"],
    postImages: json["post_images"] == null ? [] : List<String>.from(json["post_images"]!.map((x) => x)),
    totalVotes: json["totalVotes"],
    totalComments: json["totalComments"],
    isDeleted: json["isDeleted"],
    createdAt: json["createdAt"] == null ? null : DateTime.parse(json["createdAt"]),
    updatedAt: json["updatedAt"] == null ? null : DateTime.parse(json["updatedAt"]),
    hasVoted: json["hasVoted"],
  );

  Map<String, dynamic> toJson() => {
    "_id": id,
    "content": content,
    "post_images": postImages == null ? [] : List<dynamic>.from(postImages!.map((x) => x)),
    "totalVotes": totalVotes,
    "totalComments": totalComments,
    "isDeleted": isDeleted,
    "createdAt": createdAt?.toIso8601String(),
    "updatedAt": updatedAt?.toIso8601String(),
    "hasVoted": hasVoted,
  };
}


