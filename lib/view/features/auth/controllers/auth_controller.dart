import 'dart:convert';
import 'package:crave_crusher/helper/shared_prefe/shared_prefe.dart';
import 'package:crave_crusher/utils/app_const/app_const.dart';
import 'package:crave_crusher/view/features/auth/models/user_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthController extends GetxController {
  final String _tokenKey = AppConstants.bearerToken;
  final String _userDataKey = 'data';

  String? token;
  UserModel? user;

  Future<void> saveUserData(String accessToken, ) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    await SharePrefsHelper.setString(_tokenKey, accessToken);

    token = accessToken;

  }

  // Future<void> saveUserData(String accessToken, UserModel userModel) async {
  //   SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
  //   await SharePrefsHelper.setString(_tokenKey, accessToken);
  //   await sharedPreferences.setString(_userDataKey, jsonEncode(userModel.toJson()));
  //   token = accessToken;
  //   user = userModel;
  // }

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
}
