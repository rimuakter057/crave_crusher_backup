
import 'package:crave_crusher/service/api_check.dart';
import 'package:crave_crusher/service/api_client.dart';
import 'package:crave_crusher/service/api_url.dart';
import 'package:crave_crusher/utils/app_const/app_const.dart';
import 'package:crave_crusher/view/features/profile/models/edit_profile_model.dart';
import 'package:crave_crusher/view/features/profile/models/user_profile_model.dart';
import 'package:get/get.dart';


class ProfileController extends GetxController {
  /// my profile controller
  var isLoadingMyProfile = false.obs;
  Rx<Status> myProfileStatus = Status.loading.obs;
  Rx<UserProfileModel?> myProfile = Rx<UserProfileModel?>(null);

  Future<void> fetchMyProfile() async {
    isLoadingMyProfile.value = true;
    myProfileStatus(Status.loading);

    final response = await ApiClient.getData(ApiUrl.getMyProfile);

    isLoadingMyProfile.value = false;

    if (response.statusCode == 200 || response.statusCode == 201) {
      final data = response.body['data'];
      if (data != null) {
        myProfile.value = UserProfileModel.fromJson(data);
        myProfileStatus(Status.completed);
      } else {
        myProfileStatus(Status.error);
        Get.snackbar("Error", "No profile data found");
      }
    } else {
      myProfileStatus(Status.error);
      ApiChecker.checkApi(response);
    }
  }
  ///edit profile controller







}
