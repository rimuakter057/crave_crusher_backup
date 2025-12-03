// To parse this JSON data, do
//
//     final postModel = postModelFromJson(jsonString);

import 'dart:convert';

PostModel postModelFromJson(String str) => PostModel.fromJson(json.decode(str));

String postModelToJson(PostModel data) => json.encode(data.toJson());

class PostModel {
  final String? id;
  final String? content;
  final List<String>? postImages;
  final int? totalVotes;
  final int? totalComments;
  final bool? isDeleted;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final bool? hasVoted;
  final Author? author;

  PostModel({
    this.id,
    this.content,
    this.postImages,
    this.totalVotes,
    this.totalComments,
    this.isDeleted,
    this.createdAt,
    this.updatedAt,
    this.hasVoted,
    this.author,
  });

  factory PostModel.fromJson(Map<String, dynamic> json) => PostModel(
    id: json["_id"],
    content: json["content"],
    postImages: json["post_images"] == null ? [] : List<String>.from(json["post_images"]!.map((x) => x)),
    totalVotes: json["totalVotes"],
    totalComments: json["totalComments"],
    isDeleted: json["isDeleted"],
    createdAt: json["createdAt"] == null ? null : DateTime.parse(json["createdAt"]),
    updatedAt: json["updatedAt"] == null ? null : DateTime.parse(json["updatedAt"]),
    hasVoted: json["hasVoted"],
    author: json["author"] == null ? null : Author.fromJson(json["author"]),
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
    "author": author?.toJson(),
  };
}

class Author {
  final String? id;
  final String? fullName;
  final String? email;
  final dynamic profileImage;

  Author({
    this.id,
    this.fullName,
    this.email,
    this.profileImage,
  });

  factory Author.fromJson(Map<String, dynamic> json) => Author(
    id: json["_id"],
    fullName: json["fullName"],
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
