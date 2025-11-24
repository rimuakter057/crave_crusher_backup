import 'dart:convert';
import 'package:crave_crusher/service/api_check.dart';
import 'package:crave_crusher/service/api_client.dart';
import 'package:crave_crusher/service/api_url.dart';
import 'package:crave_crusher/utils/app_const/app_const.dart';
import 'package:crave_crusher/view/features/auth/models/user_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../../helper/shared_prefe/shared_prefe.dart';

class AuthController {
  final String _tokenKey = 'token';
  final String _userDataKey = 'user-data';

  String? token;
  UserModel? user;

  Future<void> saveUserData(String accessToken, UserModel userModel) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    await sharedPreferences.setString(_tokenKey, accessToken);
    await sharedPreferences.setString(
      _userDataKey,
      jsonEncode(userModel.toJson()),
    );

    token = accessToken;
    user = userModel;
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
    await sharedPreferences.clear();
    token = null;
    user = null;
  }

  bool isValidUser() {
    return token != null;
  }

  //============================= Login ===============================

  // TextEditingController loginEmailController = TextEditingController();
  // TextEditingController loginPassController = TextEditingController();
  //
  // RxBool isLogingLoading = false.obs;
  //
  // Future<bool> loginUser() async {
  //   isLogingLoading(true);
  //
  //   var body = {
  //     "email": loginEmailController.text,
  //     "password": loginPassController.text,
  //   };
  //
  //   var response = await ApiClient.postData(ApiUrl.signInUrl, jsonEncode(body));
  //
  //   if (response.statusCode == 200 || response.statusCode == 201) {
  //     SharePrefsHelper.setString(
  //       AppConstants.bearerToken,
  //       response.body['data']['accessToken'],
  //     );
  //
  //     return true;
  //   } else {
  //     ApiChecker.checkApi(response);
  //     return false;
  //   }
  // }
}
