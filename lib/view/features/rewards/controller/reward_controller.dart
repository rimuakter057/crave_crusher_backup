import 'package:crave_crusher/service/api_check.dart';
import 'package:crave_crusher/service/api_client.dart';
import 'package:crave_crusher/service/api_url.dart';
import 'package:crave_crusher/view/features/rewards/models/badge_model.dart';
import 'package:get/get.dart';

import '../models/progress_model.dart';

class RewardsController extends GetxController {
  ///get all badges controller=================================================================================

  RxList<BadgeModel> allBadgeList = <BadgeModel>[].obs;
  var isLoadingAllBadge = false.obs;

  Future<void> getAllBadges() async {
    isLoadingAllBadge.value = true;
    final response = await ApiClient.getData(ApiUrl.getAllBadge);

    if (response.statusCode == 200 && response.body['data'] != null) {
      var badgeList =
          (response.body['data'] as List)
              .map((e) => BadgeModel.fromJson(e))
              .toList();

      allBadgeList.value = badgeList;
    } else if (response.statusCode != 404) {
      ApiChecker.checkApi(response);
    }
    isLoadingAllBadge.value = false;
  }

  ///get progress controller=====================================================================================

  var currentProgress = 0.obs;
  var currentBadge = Rx<CurrentBadge?>(null);
  var craveCount = 0.obs;
  var isLoadingProgress = false.obs;

  Future<void> getBadgeProgress() async {
    isLoadingProgress.value = true;

    final response = await ApiClient.getData(ApiUrl.getProgress);

    if (response.statusCode == 200 && response.body['data'] != null) {
      // Use model
      final progressModel = BadgeProgressModel.fromJson(response.body['data']);
      currentProgress.value = progressModel.currentProgress;
      craveCount.value = progressModel.craveCount;
      currentBadge.value = progressModel.currentBadge;
    } else if (response.statusCode != 404) {
      ApiChecker.checkApi(response);
    }

    isLoadingProgress.value = false;
  }

  ///get achieve badges===================================================================================

  RxList<BadgeModel> allAchieveList = <BadgeModel>[].obs;
  var isLoadingAchieveBadge = false.obs;

  Future<void> getAchieveBadges() async {
    isLoadingAchieveBadge.value = true;
    final response = await ApiClient.getData(ApiUrl.getAchieveBadge);

    if (response.statusCode == 200 && response.body['data'] != null) {
      var achieveList =
          (response.body['data'] as List)
              .map((e) => BadgeModel.fromJson(e))
              .toList();

      allAchieveList.value = achieveList;
    } else if (response.statusCode != 404) {
      ApiChecker.checkApi(response);
    }
    isLoadingAchieveBadge.value = false;
  }

  ///claim=============================================patch==============================

  var isLoadingClaim = false.obs;
  var badgeStatus = <String, bool>{}.obs;

  Future<bool> claim(String badgeId) async {
    if (badgeStatus[badgeId] == true) return false; // already claimed

    isLoadingClaim.value = true;

    final body = {"isClaim": true}; // send claim status

    final response = await ApiClient.patchData(ApiUrl.claim(badgeId), body);

    isLoadingClaim.value = false;

    if (response.statusCode == 200 || response.statusCode == 201) {
      badgeStatus[badgeId] = true;
      getAchieveBadges();
      return true;
    } else if (response.statusCode != 404) {
      ApiChecker.checkApi(response);
    }

    return false;
  }

  /// get claim badges =========================================================

  RxList<BadgeModel> allClaimList = <BadgeModel>[].obs;
  var isLoadingClaimBadge = false.obs;

  Future<void> getClaimBadges() async {
    isLoadingClaimBadge.value = true;

    final response = await ApiClient.getData(ApiUrl.getClaimBadge);

    if (response.statusCode == 200 && response.body['data'] != null) {
      final List claimList = response.body['data'];

      allClaimList.value =
          claimList.map((e) => BadgeModel.fromJson(e)).toList();
    } else if (response.statusCode != 404) {
      ApiChecker.checkApi(response);
    }

    isLoadingClaimBadge.value = false;
  }
}
