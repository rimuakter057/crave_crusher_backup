import 'package:crave_crusher/core/service/data_source/local/network_caller_demo.dart';
import 'package:crave_crusher/service/api_url.dart';
import 'package:crave_crusher/service/network_caller.dart';

import 'package:crave_crusher/view/features/auth/models/user_model.dart';
import 'package:get/get.dart';

class SignUpController extends GetxController {
  bool _signUpInProgress = false;

  bool get signUpInProgress => _signUpInProgress;

  String? _errorMessage;

  String? get errorMessage => _errorMessage;

  Future<bool> signUp(UserModel userModel) async {
    bool isSuccess = false;
    _signUpInProgress = true;
    update();
    final NetworkResponse response =
    await Get.find<NetworkCaller>().postRequest(
      url: ApiUrl.signUpUrl,
      body: userModel.toJson(),
    );
    if (response.isSuccess) {
      _errorMessage = null;
      isSuccess = true;
    } else {
      _errorMessage = response.errorMessage;
    }
    _signUpInProgress = false;
    update();
    return isSuccess;
  }
}