
import 'package:crave_crusher/core/routes/app_routes.dart';
import 'package:crave_crusher/service/api_check.dart';
import 'package:crave_crusher/service/api_client.dart';
import 'package:crave_crusher/service/api_url.dart';
import 'package:crave_crusher/utils/app_const/app_const.dart';
import 'package:crave_crusher/view/features/help_support/models/help_support_model.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../auth/controllers/auth_controller.dart';
import '../../terms_condition/models/terms_condition_model.dart' show TermsModel;

class AccountSettingController extends GetxController{
///privacy policy===============================================================================
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

  ///help  support==========================================================================================


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

  /// terms condition==========================================================================================




  var isLoadingTerms = false.obs;
  Rx<Status> termsStatus = Status.loading.obs;
  Rx<TermsModel?> termsList = Rx<TermsModel?>(null);

  Future<void> getTerms() async {

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
      ApiChecker.checkApi(response);
    }

  }

/// delete account==========================================================================================



  var isLoadingDeleteAccount = false.obs;



  Future<void> deleteAccount() async {

    isLoadingDeleteAccount.value = true;

    final response = await ApiClient.deleteData(ApiUrl.deleteProfile);


    isLoadingDeleteAccount.value = false;

    if (response.statusCode == 200) {
      await Get.find<AuthController>().clearUserData();
      Get.offAllNamed(AppRoutes.loginScreen);
      Get.snackbar("Success", "Account deleted successfully");
    } else {
      Get.snackbar("Error", "Failed to delete account");
    }
  }
}