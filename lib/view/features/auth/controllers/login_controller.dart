import 'package:crave_crusher/service/api_url.dart';
import 'package:crave_crusher/service/network_caller.dart';
import 'package:crave_crusher/view/features/auth/controllers/auth_controller.dart';
import 'package:crave_crusher/view/features/auth/models/login_model.dart';
import 'package:get/get.dart';

class LogInController extends GetxController {
  bool _inProgress = false;
  bool get inProgress => _inProgress;

  String? _errorMessage;
  String? get errorMessage => _errorMessage;

  int _statusCode = 0;
  int get statusCode => _statusCode;

  bool _emailNotVerified = false;
  bool get emailNotVerified => _emailNotVerified;

  Future<bool> logIn(LogInModel logInModel) async {
    bool isSuccess = false;
    _inProgress = true;
    update();

    _emailNotVerified = false; // reset

    final NetworkResponse response = await Get.find<NetworkCaller>()
        .postRequest(url: ApiUrl.signInUrl, body: logInModel.toJson());

    _statusCode = response.statusCode;

    if (response.statusCode == 200 && response.responseData != null) {
      final data = response.responseData!['data'];

      /// 🔹 CASE 1: Email not verified
      if (data['email_verification'] == false) {
        _emailNotVerified = true;
        _errorMessage = null;
        isSuccess = true;
      }
      /// 🔹 CASE 2: Login complete
      else if (data.containsKey('accessToken')) {
        String accessToken = data['accessToken'];
        String userId = data['id'];

        await Get.find<AuthController>().saveTokenId(accessToken, userId);

        _errorMessage = null;
        isSuccess = true;
      } else {
        _errorMessage = "Unexpected response format";
      }
    } else {
      _errorMessage =
          response.responseData?['message'] ??
          response.errorMessage ??
          "Something went wrong";
    }

    _inProgress = false;
    update();
    return isSuccess;
  }

  ///============ when user not found status 502 =============

  bool _userUnauthorizedLoading = false;
  bool get userUnauthorizedLoading => _userUnauthorizedLoading;

  String? _errorMessageUnauthorized;
  String? get errorMessageUnauthorized => _errorMessageUnauthorized;

  // 🔹 SIGN UP
  Future<bool> userUnauthorized(String email) async {
    bool isSuccess = false;
    _userUnauthorizedLoading = true;
    update();

    final body = {"email": email};
    final NetworkResponse response = await Get.find<NetworkCaller>()
        .postRequest(url: ApiUrl.signUpUrl, body: body);

    if (response.isSuccess) {
      _errorMessageUnauthorized = null;
      isSuccess = true;
    } else {
      _errorMessageUnauthorized = response.errorMessage;
    }

    _userUnauthorizedLoading = false;
    update();
    return isSuccess;
  }
}
