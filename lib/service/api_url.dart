class ApiUrl {
  static const String primaryUrl = "http://10.10.20.45:5555";

  static const String baseUrl = "$primaryUrl/api/v1";
  // static const String baseUrl = "https://sta-map-point-2.onrender.com/api/v1";
  static const String imageUrl = "$primaryUrl/";


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
  //community section
  static const String createPost="/community-post/create-post";
  static const String getSinglePost="/community-post/post/6925890de1d7dae96182e1df";
  static const String getAllPost="/community-post/posts";
  static const String getMyPost="/community-post/my-posts";
  static  String updatePost(String postId){return "/community-post/update-post/$postId";}
  static const String deletePost="/community-post/post/6925890de1d7dae96182e1df";
  static  String addVote(String postId){return "/community-vote/vote/$postId";}
  static  String getAllVote(String postId){return "/community-vote/votes/$postId";}
  static String createComment(String userId) {
    return "/community-comment/comment/$userId";
  }

  static const String editComment="/community-comment/comment/6925b7bca0423a01b0dcf43b";
  static const String deleteComment="/community-comment/comment/6925b7bca0423a01b0dcf43b";
  static String getAllComment(String postId) {
    return "/community-comment/comment/$postId";
  }


///profile section==================================================================
  static const String getMyProfile="/user/get-my-profile";
  static const String updateProfile="/user/update-profile";

  ///terms faq privacy

  static const String termsCondition="/manage-web/get-terms-conditions";
  static const String privacyPolicy="/manage-web/get-privacy-policy";
  static const String help="/manage-web/get-faq";
///battle=======================================================================

static const String createBattle="/battle/battles";

  static String myBattle(String status) {
    return "/battle/battles?status=$status";
  }
  static  String singleBattle(String battleId){return "/battle/battles/$battleId";}
}
