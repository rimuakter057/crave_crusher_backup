
class VerifyOtpModel{
  final String email;
  final String verifyCode;

  VerifyOtpModel({required this.email,required this.verifyCode});

  Map<String, dynamic> toJson() {
    return {
      "email": email,
      "verifyCode": int.tryParse(verifyCode) ?? 0, // convert string to int
    };
  }

}