class UserProfileModel {
  String id;
  String fullName;
  String email;
  String role;
  String profileImage;
  bool isBlocked;
  int verifyCode;
  bool isVerified;
  bool isResetVerified;
  DateTime codeExpireIn;
  bool isActive;
  bool isDeleted;
  DateTime createdAt;
  DateTime updatedAt;
  int v;
  DateTime passwordChangedAt;
  final Monster? monster;
  UserProfileModel({
    required this.id,
    required this.fullName,
    required this.email,
    required this.role,
    required this.profileImage,
    required this.isBlocked,
    required this.verifyCode,
    required this.isVerified,
    required this.isResetVerified,
    required this.codeExpireIn,
    required this.isActive,
    required this.isDeleted,
    required this.createdAt,
    required this.updatedAt,
    required this.v,
    required this.passwordChangedAt,
    this.monster,
  });

  factory UserProfileModel.fromJson(Map<String, dynamic> json) {
    return UserProfileModel(
      id: json['_id'] ?? '',
      fullName: json['fullName'] ?? '',
      email: json['email'] ?? '',
      role: json['role'] ?? '',
      profileImage: json['profileImage'] ?? '',
      isBlocked: json['isBlocked'] ?? false,
      verifyCode: json['verifyCode'] ?? 0,
      isVerified: json['isVerified'] ?? false,
      isResetVerified: json['isResetVerified'] ?? false,
      codeExpireIn: json['codeExpireIn'] != null
          ? DateTime.parse(json['codeExpireIn'])
          : DateTime.now(),
      isActive: json['isActive'] ?? false,
      isDeleted: json['isDeleted'] ?? false,
      createdAt: json['createdAt'] != null
          ? DateTime.parse(json['createdAt'])
          : DateTime.now(),
      updatedAt: json['updatedAt'] != null
          ? DateTime.parse(json['updatedAt'])
          : DateTime.now(),
      v: json['__v'] ?? 0,
      passwordChangedAt: json['passwordChangedAt'] != null
          ? DateTime.parse(json['passwordChangedAt'])
          : DateTime.now(),

      monster: json['monster'] != null ? Monster.fromJson(json['monster']) : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      '_id': id,
      'fullName': fullName,
      'email': email,
      'role': role,
      'profileImage': profileImage,
      'isBlocked': isBlocked,
      'verifyCode': verifyCode,
      'isVerified': isVerified,
      'isResetVerified': isResetVerified,
      'codeExpireIn': codeExpireIn.toIso8601String(),
      'isActive': isActive,
      'isDeleted': isDeleted,
      'createdAt': createdAt.toIso8601String(),
      'updatedAt': updatedAt.toIso8601String(),
      '__v': v,
      'passwordChangedAt': passwordChangedAt.toIso8601String(),
      'monster': monster?.toJson(),
    };
  }
}




class Monster {
  final String? monsterImage;
final String?monsterMessage;

  Monster({this.monsterImage,this.monsterMessage});

  factory Monster.fromJson(Map<String, dynamic> json) {
    return Monster(monsterImage: json["monster_image"],
    monsterMessage: json['monster_message']
    );
  }

  Map<String, dynamic> toJson() => {"monster_image": monsterImage,
  "monster_message":monsterMessage
  };
}