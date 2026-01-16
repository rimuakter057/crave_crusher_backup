import 'dart:convert';

import 'package:get/get.dart';

PostModel postModelFromJson(String str) => PostModel.fromJson(json.decode(str));

String postModelToJson(PostModel data) => json.encode(data.toJson());

class PostModel {
  final String? id;
  final String? content;
  final List<String> postImages;
  final String? totalReaction;
  final String? totalBadge;
  final String? totalPost;

  RxInt totalVotes;

  final int? totalComments;
  final bool? isDeleted;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  RxBool hasVoted;
  final Author? author;

  PostModel({
    this.totalBadge,
    this.totalPost,
    this.totalReaction,
    this.id,
    this.content,
    List<String>? postImages,
    RxInt? totalVotes,
    this.totalComments,
    this.isDeleted,
    this.createdAt,
    this.updatedAt,
    RxBool? hasVoted,
    this.author,
  }) : postImages = postImages ?? [],
       totalVotes = totalVotes ?? 0.obs,
       hasVoted = hasVoted ?? false.obs;

  factory PostModel.fromJson(Map<String, dynamic> json) {
    return PostModel(
      totalBadge: json["totalBadge"],
      totalPost: json["totalPost"],
      totalReaction: json["totalReaction"],
      id: json["_id"],
      content: json["content"],
      postImages:
          json["post_images"] == null
              ? []
              : List<String>.from(json["post_images"]),
      totalVotes: RxInt(json["totalVotes"] ?? 0),
      totalComments: json["totalComments"],
      isDeleted: json["isDeleted"],
      createdAt:
          json["createdAt"] == null ? null : DateTime.parse(json["createdAt"]),
      updatedAt:
          json["updatedAt"] == null ? null : DateTime.parse(json["updatedAt"]),
      hasVoted: RxBool(json["hasVoted"] ?? false),
      author: json["author"] == null ? null : Author.fromJson(json["author"]),
    );
  }

  Map<String, dynamic> toJson() => {
    "totalBadge": totalBadge,
    "totalPost": totalPost,
    "totalReaction": totalReaction,
    "_id": id,
    "content": content,
    "post_images": postImages,
    "totalVotes": totalVotes.value,
    "totalComments": totalComments,
    "isDeleted": isDeleted,
    "createdAt": createdAt?.toIso8601String(),
    "updatedAt": updatedAt?.toIso8601String(),
    "hasVoted": hasVoted.value,
    "author": author?.toJson(),
  };
}

class Author {
  final String? id;
  final String? fullName;
  final String? email;
  final dynamic profileImage;

  Author({this.id, this.fullName, this.email, this.profileImage});

  factory Author.fromJson(Map<String, dynamic> json) => Author(
    id: json["_id"],
    fullName: json["fullName"] ?? 'Unknown',
    email: json["email"],
    profileImage: json["profileImage"],
  );

  Map<String, dynamic> toJson() => {
    "_id": id,
    "fullName": fullName,
    "email": email,
    "profileImage": profileImage,
  };
}
