class EditProfileModel {
  final List<String> playerIds;
  final String id;
  final String fullName;
  final String email;
  final String role;
  final String? profileImage;
  final String password;
  final bool isBlocked;
  final int verifyCode;
  final bool isVerified;
  final bool isResetVerified;
  final String codeExpireIn;
  final bool isActive;
  final bool isDeleted;
  final String createdAt;
  final String updatedAt;
  final int v;
  final String passwordChangedAt;

  EditProfileModel({
    required this.playerIds,
    required this.id,
    required this.fullName,
    required this.email,
    required this.role,
    this.profileImage,
    required this.password,
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
  });

  // From JSON (API → Model)
  factory EditProfileModel.fromJson(Map<String, dynamic> json) {
    return EditProfileModel(
      playerIds: List<String>.from(json['playerIds'] ?? []),
      id: json['_id'] ?? '',
      fullName: json['fullName'] ?? '',
      email: json['email'] ?? '',
      role: json['role'] ?? '',
      profileImage: json['profileImage'],
      password: json['password'] ?? '',
      isBlocked: json['isBlocked'] ?? false,
      verifyCode: json['verifyCode'] ?? 0,
      isVerified: json['isVerified'] ?? false,
      isResetVerified: json['isResetVerified'] ?? false,
      codeExpireIn: json['codeExpireIn'] ?? '',
      isActive: json['isActive'] ?? false,
      isDeleted: json['isDeleted'] ?? false,
      createdAt: json['createdAt'] ?? '',
      updatedAt: json['updatedAt'] ?? '',
      v: json['__v'] ?? 0,
      passwordChangedAt: json['passwordChangedAt'] ?? '',
    );
  }

  // To JSON (Model → API)
  Map<String, dynamic> toJson() {
    return {
      'playerIds': playerIds,
      '_id': id,
      'fullName': fullName,
      'email': email,
      'role': role,
      'profileImage': profileImage,
      'password': password,
      'isBlocked': isBlocked,
      'verifyCode': verifyCode,
      'isVerified': isVerified,
      'isResetVerified': isResetVerified,
      'codeExpireIn': codeExpireIn,
      'isActive': isActive,
      'isDeleted': isDeleted,
      'createdAt': createdAt,
      'updatedAt': updatedAt,
      '__v': v,
      'passwordChangedAt': passwordChangedAt,
    };
  }
}
