// To parse this JSON data, do
//
//     final editProfileModel = editProfileModelFromJson(jsonString);

import 'dart:convert';

EditProfileModel editProfileModelFromJson(String str) =>
    EditProfileModel.fromJson(json.decode(str));

String editProfileModelToJson(EditProfileModel data) =>
    json.encode(data.toJson());

class EditProfileModel {
  final String? id;
  final String? fullName;
  final String? email;
  final String? role;
  final dynamic profileImage;
  final String? password;
  final bool? isBlocked;
  final int? verifyCode;
  final bool? isVerified;
  final bool? isResetVerified;
  final DateTime? codeExpireIn;
  final bool? isActive;
  final bool? isDeleted;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final int? v;
  final DateTime? passwordChangedAt;
  final List<dynamic>? playerIds;

  EditProfileModel({
    this.id,
    this.fullName,
    this.email,
    this.role,
    this.profileImage,
    this.password,
    this.isBlocked,
    this.verifyCode,
    this.isVerified,
    this.isResetVerified,
    this.codeExpireIn,
    this.isActive,
    this.isDeleted,
    this.createdAt,
    this.updatedAt,
    this.v,
    this.passwordChangedAt,
    this.playerIds,
  });

  factory EditProfileModel.fromJson(
    Map<String, dynamic> json,
  ) => EditProfileModel(
    id: json["_id"],
    fullName: json["fullName"],
    email: json["email"],
    role: json["role"],
    profileImage: json["profileImage"],
    password: json["password"],
    isBlocked: json["isBlocked"],
    verifyCode: json["verifyCode"],
    isVerified: json["isVerified"],
    isResetVerified: json["isResetVerified"],
    codeExpireIn:
        json["codeExpireIn"] == null
            ? null
            : DateTime.parse(json["codeExpireIn"]),
    isActive: json["isActive"],
    isDeleted: json["isDeleted"],
    createdAt:
        json["createdAt"] == null ? null : DateTime.parse(json["createdAt"]),
    updatedAt:
        json["updatedAt"] == null ? null : DateTime.parse(json["updatedAt"]),
    v: json["__v"],
    passwordChangedAt:
        json["passwordChangedAt"] == null
            ? null
            : DateTime.parse(json["passwordChangedAt"]),
    playerIds:
        json["playerIds"] == null
            ? []
            : List<dynamic>.from(json["playerIds"]!.map((x) => x)),
  );

  Map<String, dynamic> toJson() => {
    "_id": id,
    "fullName": fullName,
    "email": email,
    "role": role,
    "profileImage": profileImage,
    "password": password,
    "isBlocked": isBlocked,
    "verifyCode": verifyCode,
    "isVerified": isVerified,
    "isResetVerified": isResetVerified,
    "codeExpireIn": codeExpireIn?.toIso8601String(),
    "isActive": isActive,
    "isDeleted": isDeleted,
    "createdAt": createdAt?.toIso8601String(),
    "updatedAt": updatedAt?.toIso8601String(),
    "__v": v,
    "passwordChangedAt": passwordChangedAt?.toIso8601String(),
    "playerIds":
        playerIds == null ? [] : List<dynamic>.from(playerIds!.map((x) => x)),
  };
}
