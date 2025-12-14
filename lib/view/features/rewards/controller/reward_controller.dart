import 'package:crave_crusher/service/api_check.dart';
import 'package:crave_crusher/service/api_client.dart';
import 'package:crave_crusher/service/api_url.dart';
import 'package:crave_crusher/view/features/rewards/models/badge_model.dart';
import 'package:get/get.dart';

class RewardsController extends GetxController {
  RxDouble progress = 1.0.obs; // initial progress

  void updateProgress(double value) {
    progress.value = value.clamp(0.0, 1.0);
  }

  String get progressText => "${(progress.value * 100).toInt()}%";




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
  var isLoadingProgress = false.obs;

  Future<void> getBadgeProgress() async {
    isLoadingProgress.value = true;

    final response = await ApiClient.getData(ApiUrl.getProgress);

    if (response.statusCode == 200 && response.body['data'] != null) {
      currentProgress.value =
      response.body['data']['currentProgress'];
    } else {
      ApiChecker.checkApi(response);
    }

    isLoadingProgress.value = false;
  }

}






