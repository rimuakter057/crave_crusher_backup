
import 'package:crave_crusher/service/api_url.dart';
import 'package:crave_crusher/service/network_caller.dart';
import 'package:crave_crusher/view/features/auth/models/signup_model.dart';
import 'package:get/get.dart';


class SignUpController extends GetxController {
  bool _signUpInProgress = false;
  bool get signUpInProgress => _signUpInProgress;

  String? _errorMessage;
  String? get errorMessage => _errorMessage;

  // 🔹 TERMS STATE
  bool _termsAgree = false;
  bool get termsAgree => _termsAgree;

  void toggleTerms(bool value) {
    _termsAgree = value;
    update();
  }

  // 🔹 SIGN UP
  Future<bool> signUp(SignUpModel userModel, String confirmPassword) async {
    // 🔹 Terms check
    if (!_termsAgree) {
      _errorMessage = "Please accept terms and conditions.";
      update();
      return false;
    }

    // 🔹 Password confirmation check
    if (userModel.password != confirmPassword) {
      _errorMessage = "Password and Confirm Password do not match.";
      update();
      return false;
    }

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
