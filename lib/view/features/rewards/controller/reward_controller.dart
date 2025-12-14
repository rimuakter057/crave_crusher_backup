import 'package:crave_crusher/service/api_check.dart';
import 'package:crave_crusher/service/api_client.dart';
import 'package:crave_crusher/service/api_url.dart';
import 'package:crave_crusher/view/features/rewards/models/badge_model.dart';
import 'package:get/get.dart';

import '../models/progress_model.dart';

class RewardsController extends GetxController {


  @override
  void onInit() {
    super.onInit();
    getBadgeProgress();
    getAchieveBadges();
    getAllBadges();
  }

  ///get all badges controller=================================================================================

  RxList <BadgeModel> allBadgeList= <BadgeModel>[].obs;
  var isLoadingAllBadge= false.obs;

Future <void> getAllBadges()async{
isLoadingAllBadge.value=true;
final response = await ApiClient.getData(ApiUrl.getAllBadge);

if(response.statusCode==200 && response.body['data']!=null){
  var badgeList=(response.body['data']as List).map((e)=>BadgeModel.fromJson(e)).toList();

  allBadgeList.value=badgeList;

}else{
  ApiChecker.checkApi(response);


}
isLoadingAllBadge.value = false;
}

///get progress controller==========================================without model get request===========================================


  var currentProgress = 0.obs;
  var currentBadge = Rx<CurrentBadge?>(null);
  var isLoadingProgress = false.obs;

  Future<void> getBadgeProgress() async {
    isLoadingProgress.value = true;

    final response = await ApiClient.getData(ApiUrl.getProgress);

    if (response.statusCode == 200 && response.body['data'] != null) {
      // Use model
      final progressModel = BadgeProgressModel.fromJson(response.body['data']);
      currentProgress.value = progressModel.currentProgress;
      currentBadge.value = progressModel.currentBadge;
    } else {
      ApiChecker.checkApi(response);
    }

    isLoadingProgress.value = false;
  }









///get achieve badges===================================================================================


  RxList <BadgeModel> allAchieveList= <BadgeModel>[].obs;
  var isLoadingAchieveBadge= false.obs;

  Future <void> getAchieveBadges()async{
    isLoadingAchieveBadge.value=true;
    final response = await ApiClient.getData(ApiUrl.getAchieveBadge);

    if(response.statusCode==200 && response.body['data']!=null){
      var achieveList=(response.body['data']as List).map((e)=>BadgeModel.fromJson(e)).toList();

      allAchieveList.value=achieveList;

    }else{
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
      getAchieveBadges();
      badgeStatus[badgeId] = true; // update local status
      return true;
    }

    return false;
  }




}






