
import 'package:crave_crusher/service/api_url.dart';
import 'package:crave_crusher/service/network_caller.dart';
import 'package:crave_crusher/view/components/show_snakbar/show_snakbar.dart';
import 'package:crave_crusher/view/features/auth/models/verify_account_otp_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ForgetPasswordController extends GetxController {
  bool _inProgress =false;
  bool get inProgress =>_inProgress;
  String? _errorMessage;
  String? get errorMessage =>_errorMessage;

  Future <bool> forgetPassword (String email) async {
    bool isSuccess =false;
    _inProgress=true;
    update();
    final NetworkResponse response= await Get.find<NetworkCaller>().postRequest(url: ApiUrl.forgetPass,
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