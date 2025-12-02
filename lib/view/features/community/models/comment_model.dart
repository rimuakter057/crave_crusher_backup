// To parse this JSON data, do
//
//     final commentModel = commentModelFromJson(jsonString);

import 'dart:convert';

CommentModel commentModelFromJson(String str) => CommentModel.fromJson(json.decode(str));

String commentModelToJson(CommentModel data) => json.encode(data.toJson());

class CommentModel {
  final String? id;
  final String? postId;
  final String? authorId;
  final String? commentText;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final int? v;

  CommentModel({
    this.id,
    this.postId,
    this.authorId,
    this.commentText,
    this.createdAt,
    this.updatedAt,
    this.v,
  });

  factory CommentModel.fromJson(Map<String, dynamic> json) => CommentModel(
    id: json["_id"],
    postId: json["postId"],
    authorId: json["authorId"],
    commentText: json["commentText"],
    createdAt: json["createdAt"] == null ? null : DateTime.parse(json["createdAt"]),
    updatedAt: json["updatedAt"] == null ? null : DateTime.parse(json["updatedAt"]),
    v: json["__v"],
  );

  Map<String, dynamic> toJson() => {
    "_id": id,
    "postId": postId,
    "authorId": authorId,
    "commentText": commentText,
    "createdAt": createdAt?.toIso8601String(),
    "updatedAt": updatedAt?.toIso8601String(),
    "__v": v,
  };
}
