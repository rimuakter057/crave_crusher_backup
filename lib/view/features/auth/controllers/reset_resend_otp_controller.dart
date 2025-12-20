import 'dart:async';
import 'package:get/get.dart';
import 'package:crave_crusher/service/network_caller.dart';
import 'package:crave_crusher/service/api_url.dart';

class ResendOtpController extends GetxController {
  bool inProgress = false;
  String? errorMessage;

  int countdown = 60;
  Timer? _timer;

  String get countdownText => countdown > 0 ? '$countdown s' : '';

  @override
  void onInit() {
    super.onInit();
    startCountdown(); // countdown auto start on screen load
  }

  /// start countdown
  void startCountdown({int seconds = 60}) {
    countdown = seconds;
    update();

    _timer?.cancel();
    _timer = Timer.periodic(Duration(seconds: 1), (timer) {
      if (countdown > 0) {
        countdown--;
        update();
      } else {
        _timer?.cancel();
        update();
      }
    });
  }

  @override
  void onClose() {
    _timer?.cancel();
    super.onClose();
  }

  /// resend OTP API call
  Future<bool> resendOtp(String email) async {
    if (email.isEmpty) {
      errorMessage = "Email not found!";
      update();
      return false;
    }

    bool isSuccess = false;
    inProgress = true;
    update();

    final response = await Get.find<NetworkCaller>().postRequest(
      url: ApiUrl.resendResetOtp,
      body: {'email': email},
    );

    if (response.isSuccess) {
      errorMessage = null;
      isSuccess = true;

      // countdown restart after OTP resent
      startCountdown(seconds: 60);
    } else {
      errorMessage = response.errorMessage;
    }

    inProgress = false;
    update();
    return isSuccess;
  }
}
