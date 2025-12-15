import 'dart:io';

import 'package:crave_crusher/helper/imges_handler/image_handler.dart';
import 'package:crave_crusher/service/api_check.dart';
import 'package:crave_crusher/service/api_client.dart';
import 'package:crave_crusher/service/api_url.dart';
import 'package:crave_crusher/utils/ToastMsg/toast_message.dart';
import 'package:crave_crusher/utils/app_const/app_const.dart';
import 'package:crave_crusher/view/features/profile/models/user_profile_model.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

class ProfileController extends GetxController {
  ///profile image show =================================================================image picker==============================================
  @override
  void onInit() {
    super.onInit();
    fetchMyProfile();
  }
  //RxString? profileImagePath;
  Rx<File?> profileImageFile = Rx<File?>(null);


  final ImagePicker _picker = ImagePicker();

  Future<void> pickImageFromGallery() async {
    final pickedFile = await _picker.pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
     // profileImagePath?.value = pickedFile.path; // reactive update

      profileImageFile.value = File(pickedFile.path);

    }
  }

  ///update profile==================================================================Patch Methode=======================================
  Rx<Status> updateProfileStatus = Status.loading.obs;
  var isLoadingUpdateProfile = false.obs;


  Future<void> updateProfile(String name) async {
    isLoadingUpdateProfile(true);
    final body = {"fullName": name};

    final response =
        profileImageFile.value == null
            ? await ApiClient.patchData(
              ApiUrl.updateProfile,
              body,
              isJson: true,
            )
            : await ApiClient.patchMultipartData(ApiUrl.updateProfile, body, multipartBody: [
              MultipartBody(
                "profileImage",
                 profileImageFile.value!,
              ),
        ]);
    isLoadingUpdateProfile(false);
    if (response.statusCode == 200 || response.statusCode == 201) {
      showCustomSnackBar("Profile updated successfully", isError: false);

      fetchMyProfile();

      Get.back();

      // return true;
    } else {
      ApiChecker.checkApi(response);
      //  return false;
    }
  }

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
}
