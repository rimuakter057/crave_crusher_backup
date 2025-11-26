
import 'package:crave_crusher/core/service/data_source/local/network_caller_demo.dart';
import 'package:crave_crusher/service/api_url.dart';
import 'package:crave_crusher/service/network_caller.dart';
import 'package:crave_crusher/view/features/auth/models/reset_password_model.dart';
import 'package:get/get.dart';

class ResetPasswordController extends GetxController {
  bool _inProgress =false;
  bool get inProgress=> _inProgress;
  String?_errorMessage;
  String? get errorMessage=>_errorMessage;

  Future <bool> resetPassword (ResetPasswordModel resetPasswordModel)async{
    bool isSuccess=false;
    _inProgress=true;
    update();
    final NetworkResponse response = await Get.find<NetworkCaller>().postRequest(url: ApiUrl.resetPassword,
    body: resetPasswordModel.toJson()
    );
   if(response.isSuccess){
     _errorMessage =null;
     isSuccess =true;
   } else {
      _errorMessage = response.errorMessage;
    }

    _inProgress = false;
    update();
    return isSuccess;

  }

}






