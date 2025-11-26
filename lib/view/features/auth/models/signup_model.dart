class SignUpModel {
  final String fullName;
  final String email;
  final String password;

  SignUpModel({
    required this.fullName,
    required this.email,
    required this.password,
  });

  factory SignUpModel.fromJson(Map<String, dynamic> json) {
    return SignUpModel(
      fullName: json['fullName'] ?? "empty fullName",
      email: json['email'] ?? "empty email",
      password: json['password'] ?? "empty password",
    );
  }

  Map<String, dynamic> toJson() {
    return {'fullName': fullName, 'email': email, "password": password};
  }
}
