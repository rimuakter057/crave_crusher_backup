import 'dart:convert';
import 'package:crave_crusher/utils/app_const/app_const.dart';
import 'package:crave_crusher/view/features/auth/models/user_model.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthController extends GetxController {
  final String _tokenKey = AppConstants.bearerToken;
  final String _userDataKey = 'data';
  final String _userId = AppConstants.userId;
  String? token;
  UserModel? user;

  Future<void> saveTokenId(String accessToken, String userId) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    await sharedPreferences.setString(_tokenKey, accessToken);
    await sharedPreferences.setString(_userId, userId);
  }

  Future<void> saveId(String userId) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    await sharedPreferences.setString(_userId, userId);
  }

  Future<void> getUserData() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    token = sharedPreferences.getString(_tokenKey);
    String? userData = sharedPreferences.getString(_userDataKey);
    if (userData != null) {
      user = UserModel.fromJson(jsonDecode(userData));
    }
  }

  Future<bool> isUserLoggedIn() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    String? accessToken = sharedPreferences.getString(_tokenKey);
    if (accessToken != null) {
      await getUserData();
      return true;
    }
    return false;
  }

  Future<void> clearUserData() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    await sharedPreferences.remove(_tokenKey);
    await sharedPreferences.remove(_userDataKey);
    token = null;
    user = null;
  }

  // remember me keys
  final String _rememberMeKey = "remember_me";
  final String _rememberEmailKey = "remember_email";
  final String _rememberPasswordKey = "remember_password";

  /// ================= REMEMBER ME =================
  Future<void> saveRememberMe({
    required bool rememberMe,
    required String email,
    required String password,
  }) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    if (rememberMe) {
      await prefs.setBool(_rememberMeKey, true);
      await prefs.setString(_rememberEmailKey, email);
      await prefs.setString(_rememberPasswordKey, password);
    } else {
      await prefs.remove(_rememberMeKey);
      await prefs.remove(_rememberEmailKey);
      await prefs.remove(_rememberPasswordKey);
    }
  }

  Future<Map<String, dynamic>> getRememberMeData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    return {
      "rememberMe": prefs.getBool(_rememberMeKey) ?? false,
      "email": prefs.getString(_rememberEmailKey) ?? "",
      "password": prefs.getString(_rememberPasswordKey) ?? "",
    };
  }
}
