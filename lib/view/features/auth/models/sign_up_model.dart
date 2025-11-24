// class UserModel {
//   final String fullName;
//   final String email;
//   final String password;
//   final String confirmedPassword;
//   UserModel({
//     required this.fullName,
//     required this.email,
//     required this.password,
//     required this.confirmedPassword,
//   });
//
//   factory UserModel.fromJson(Map<String, dynamic> json) {
//     return UserModel(
//       fullName: json['fullName'] ?? "empty fullName",
//       email: json['email'] ?? "empty email",
//       password: json['password'] ?? "empty password",
//       password: json['password'] ?? "empty password",
//     );
//   }
//
//   Map<String, dynamic> toJson() {
//     return {'fullName': fullName, 'email': email, "password": password};
//   }
// }
