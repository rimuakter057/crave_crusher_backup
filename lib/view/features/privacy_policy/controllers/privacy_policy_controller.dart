
import 'package:crave_crusher/service/api_check.dart';
import 'package:crave_crusher/service/api_client.dart';
import 'package:crave_crusher/service/api_url.dart';
import 'package:crave_crusher/utils/app_const/app_const.dart';
import 'package:crave_crusher/view/features/privacy_policy/models/privacy_policy_model.dart';
import 'package:get/get.dart';

class PrivacyController extends GetxController {

        var isLoadingPrivacy = false.obs;
        Rx<Status> privacyStatus = Status.loading.obs;
        Rx<TermsModel?> privacy = Rx<TermsModel?>(null);

        Future<void> getPrivacy() async {

          isLoadingPrivacy.value = true;
          privacyStatus(Status.loading);

          final response = await ApiClient.getData(ApiUrl.privacyPolicy);

          isLoadingPrivacy.value = false;

          if (response.statusCode == 200 || response.statusCode == 201) {
            final data = response.body['data'];
            if (data != null) {
              privacy.value = TermsModel.fromJson(data);
              privacyStatus(Status.completed);
            } else {
              privacyStatus(Status.error);
              Get.snackbar("Error", "No privacy data found");
            }
          } else {
            privacyStatus(Status.error);
            ApiChecker.checkApi(response);
      }

  }


}