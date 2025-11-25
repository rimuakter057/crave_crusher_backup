

import 'package:crave_crusher/core/service/data_source/local/network_caller_demo.dart';
import 'package:crave_crusher/service/api_url.dart';
import 'package:get/get.dart';

class ResendOtpController extends GetxController {
  bool _inProgress =false;
  bool get inProgress =>_inProgress;
  String? _errorMessage;
  String? get errorMessage =>_errorMessage;
  Future <bool> resendOtp (String email) async {
    bool isSuccess =false;
    _inProgress=true;
    update();
    final NetworkResponse response= await Get.find<NetworkCaller>().postRequest(url: ApiUrl.resendResetOtp,
      body: {
        'email':email,
      },
    );
    if(response.isSuccess){
      _errorMessage =null;
      isSuccess=true;
    }else{
      _errorMessage=response.errorMessage;
    }
    _inProgress =false;
    update();
    return   isSuccess;

  }
}