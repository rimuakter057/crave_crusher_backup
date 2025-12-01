


import 'package:crave_crusher/service/api_client.dart';
import 'package:crave_crusher/service/api_url.dart';
import 'package:crave_crusher/utils/app_const/app_const.dart';
import 'package:crave_crusher/view/features/privacy_policy/models/privacy_policy_model.dart';
import 'package:get/get.dart';

class TermsConditionController extends GetxController {

  var isLoadingTerms = false.obs;
  Rx<Status> termsStatus = Status.loading.obs;
  Rx<TermsModel?> termsList = Rx<TermsModel?>(null);

  Future<void> getTerms() async {
    try {
      isLoadingTerms.value = true;
      termsStatus(Status.loading);

      final response = await ApiClient.getData(ApiUrl.termsCondition);

      isLoadingTerms.value = false;

      if (response.statusCode == 200 || response.statusCode == 201) {
        final data = response.body['data'];
        if (data != null) {
          termsList.value = TermsModel.fromJson(data);
          termsStatus(Status.completed);
        } else {
          termsStatus(Status.error);
          Get.snackbar("Error", "No terms data found");
        }
      } else {
        termsStatus(Status.error);
        Get.snackbar("Error", "Failed to terms. Status: ${response.statusCode}");
      }
    } catch (e) {
      isLoadingTerms.value = false;
      termsStatus(Status.error);
      Get.snackbar("Error", "Exception: $e");
    }
  }


}