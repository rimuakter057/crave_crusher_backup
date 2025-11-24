class ApiUrl {
  static const String primaryUrl = "http://10.10.20.45:5555";

  static const String baseUrl = "$primaryUrl/api/v1";
  // static const String baseUrl = "https://sta-map-point-2.onrender.com/api/v1";
  static const String imageUrl = "$primaryUrl/api/v1";


  //=================================== Auth ============================= //
  static const String signUpUrl="$baseUrl/user/signup";
  static const String userVerifyOtp="$baseUrl/user/verify-code";
  static const String userResendVerifyOtp="$baseUrl/user/resend-verify-code";
  //user login section
  static const String signInUrl="$baseUrl/auth/signin";
  static const String forgetPass="$baseUrl/auth/forget-password";
  static const String verifyOtp="$baseUrl/auth/verify-reset-otp";
  static const String resendResetOtp="$baseUrl/auth/resend-reset-code";
  static const String resetPassword="$baseUrl/auth/reset-password";
  static const String changePassword="$baseUrl/auth/change-password";

}
