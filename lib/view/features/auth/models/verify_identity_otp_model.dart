class VerifyIdentityOtpModel {
  final String email;
  final String resetCode;

  VerifyIdentityOtpModel({required this.email, required this.resetCode});

  Map<String, dynamic> toJson() {
    return {"email": email, "resetCode": int.tryParse(resetCode) ?? 0};
  }
}
