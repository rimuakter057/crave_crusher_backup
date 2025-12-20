import 'dart:async';
import 'package:crave_crusher/service/api_url.dart';
import 'package:crave_crusher/service/network_caller.dart';
import 'package:get/get.dart';

class UserResendOtpController extends GetxController {
  bool _inProgress = false;
  bool get inProgress => _inProgress;
  String? _errorMessage;

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

  String? get errorMessage => _errorMessage;
  Future<bool> resendOtp(String email) async {
    bool isSuccess = false;
    _inProgress = true;
    update();
    final NetworkResponse response = await Get.find<NetworkCaller>()
        .postRequest(url: ApiUrl.userResendVerifyOtp, body: {'email': email});
    if (response.isSuccess) {
      _errorMessage = null;
      isSuccess = true;
      startCountdown(seconds: 60);
    } else {
      _errorMessage = response.errorMessage;
    }
    _inProgress = false;
    update();
    return isSuccess;
  }
}
