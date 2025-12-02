class UserModel {
  final String id;
  final String fullName;
  final String email;
  final String password;
  final String role;
  final String? profileImage;
  final bool isBlocked;
  final int verifyCode;
  final bool isVerified;
  final bool isResetVerified;
  final String codeExpireIn;
  final bool isActive;
  final bool isDeleted;
  final String createdAt;
  final String updatedAt;

  UserModel({
    required this.id,
    required this.fullName,
    required this.email,
    required this.password,
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
  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      id: json['_id'] ?? "",
      fullName: json['fullName'] ?? "",
      email: json['email'] ?? "",
      password: json['password'] ?? "",
      role: json['role'] ?? "user",
      profileImage: json['profileImage'],
      isBlocked: json['isBlocked'] ?? false,
      verifyCode: json['verifyCode'] ?? 0,
      isVerified: json['isVerified'] ?? false,
      isResetVerified: json['isResetVerified'] ?? false,
      codeExpireIn: json['codeExpireIn'] ?? "",
      isActive: json['isActive'] ?? false,
      isDeleted: json['isDeleted'] ?? false,
      createdAt: json['createdAt'] ?? "",
      updatedAt: json['updatedAt'] ?? "",
    );
  }

  Map<String, dynamic> toJson() {
    return {
      '_id': id,
      'fullName': fullName,
      'email': email,
      'password': password,
      'role': role,
      'profileImage': profileImage,
      'isBlocked': isBlocked,
      'verifyCode': verifyCode,
      'isVerified': isVerified,
      'isResetVerified': isResetVerified,
      'codeExpireIn': codeExpireIn,
      'isActive': isActive,
      'isDeleted': isDeleted,
      'createdAt': createdAt,
      'updatedAt': updatedAt,
    };
  }
}
