

import 'package:crave_crusher/service/api_check.dart';
import 'package:crave_crusher/service/api_client.dart';
import 'package:crave_crusher/service/api_url.dart';
import 'package:crave_crusher/utils/app_const/app_const.dart';
import 'package:crave_crusher/view/features/help_support/models/help_support_model.dart';
import 'package:get/get.dart';

class HelpController extends GetxController {
  Rx<Status> helpStatus = Status.loading.obs;
  RxList<FaqModel> helpList = <FaqModel>[].obs;

  Future<void> getHelp() async {
    helpStatus.value = Status.loading;
    final response = await ApiClient.getData(ApiUrl.help);

    if (response.statusCode == 200 || response.statusCode == 201) {
      helpList.value = (response.body['data'] as List)
          .map((x) => FaqModel.fromJson(x))
          .toList();
      helpStatus.value = Status.completed;
    } else {
      helpList.clear();
      helpStatus.value = Status.error;
      ApiChecker.checkApi(response);
    }
  }
}


