class VerifyAccountOtpModel {
  final String email;
  final String verifyCode;

  VerifyAccountOtpModel({required this.email, required this.verifyCode});

  Map<String, dynamic> toJson() {
    return {"email": email, "verifyCode": int.tryParse(verifyCode) ?? 0};
  }
}
