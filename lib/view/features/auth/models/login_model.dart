class LogInModel {
  final String email;
  final String password;

  LogInModel({required this.email, required this.password});

  // Convert JSON to Dart object
  factory LogInModel.fromJson(Map<String, dynamic> json) {
    return LogInModel(
      email: json['email'] ?? '',       // fallback to empty string if null
      password: json['password'] ?? '', // fallback to empty string if null
    );
  }


  // Convert Dart object to JSON
  Map<String, dynamic> toJson() {
    return {
      'email': email,
      'password': password,
    };
  }


}
