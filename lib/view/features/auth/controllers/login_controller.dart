import 'package:crave_crusher/core/service/data_source/local/network_caller_demo.dart';
import 'package:crave_crusher/service/api_url.dart';
import 'package:crave_crusher/service/network_caller.dart';
import 'package:crave_crusher/view/features/auth/controllers/auth_controller.dart';
import 'package:crave_crusher/view/features/auth/models/login_model.dart';
import 'package:crave_crusher/view/features/auth/models/user_model.dart';
import 'package:get/get.dart';

class LogInController extends GetxController {
  bool _inProgress = false;
  bool get inProgress => _inProgress;

  String? _errorMessage;

  String? get errorMessage => _errorMessage;

  Future<bool> logIn(LogInModel logInModel) async {
    bool isSuccess = false;
    _inProgress = true;
    update();
    final NetworkResponse response = await Get.find<NetworkCaller>()
        .postRequest(url: ApiUrl.signInUrl, body: logInModel.toJson());

    if (response.isSuccess) {
      //save user data

      UserModel userModel = UserModel.fromJson(response.responseData!['data']);

      //save user token
      String accessToken = response.responseData!['data']['accessToken'];

      await Get.find<AuthController>().saveUserData(accessToken, userModel);

      _errorMessage = null;
      isSuccess = true;
    } else {
      _errorMessage = response.errorMessage;
    }
    _inProgress = false;
    update();
    return isSuccess;
  }
}
