
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


      //save user token
      String accessToken = response.responseData!['data']['accessToken'];

      String userId = response.responseData!['data']['id'];

      await Get.find<AuthController>().saveTokenId(accessToken,userId );


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
