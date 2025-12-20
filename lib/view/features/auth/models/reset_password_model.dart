class ResetPasswordModel {
  final String email;
  final String password;
  final String confirmPassword;

  ResetPasswordModel({
    required this.email,
    required this.password,
    required this.confirmPassword,
  });

  factory ResetPasswordModel.fromJson(Map<String, dynamic> jsonData) {
    return ResetPasswordModel(
      email: jsonData['email'],
      password: jsonData['password'],
      confirmPassword: jsonData['confirmPassword'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'email': email,
      'password': password,
      "confirmPassword": confirmPassword,
    };
  }
}
