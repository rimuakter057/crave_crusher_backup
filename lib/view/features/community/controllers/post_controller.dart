import 'dart:io';

import 'package:crave_crusher/service/api_check.dart';
import 'package:crave_crusher/service/api_client.dart';
import 'package:crave_crusher/service/api_url.dart';
import 'package:crave_crusher/utils/ToastMsg/toast_message.dart';
import 'package:crave_crusher/utils/app_const/app_const.dart';
import 'package:crave_crusher/view/features/community/models/my_post_model.dart';
import 'package:crave_crusher/view/features/community/models/all_post_model.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:logger/logger.dart';
import 'package:shared_preferences/shared_preferences.dart';

class PostController extends GetxController {

  /// get all post ==============================================================================Get Method====================
  var allPostList = <Data>[].obs;
  var isLoadingAllPost = false.obs;
  static final Logger logger = Logger();

  Future<void> fetchAllPosts() async {
    try {
      isLoadingAllPost.value = true;

      final response = await ApiClient.getData(ApiUrl.getAllPost);

      // print("RAW POST RESPONSE:");
      // print(response.body);   // 👈 পুরো JSON দেখাবে

      if (response.statusCode == 200 && response.body['data'] != null) {
        var postList = (response.body['data'] as List)
            .map((e) => Data.fromJson(e))
            .toList();
        allPostList.value = postList;
      } else {
        allPostList.clear();
      }
    } catch (e) {
      allPostList.clear();
      Logger().e("Fetch posts error: $e");
    } finally {
      isLoadingAllPost.value = false;
    }
  }





  ///create post==============================================================Post Method================================================

  var postText = ''.obs;
  var imagePath = ''.obs;
  var isLoadingCreate = false.obs;

  RxString userID = ''.obs;

  RxList<Map<String, dynamic>> myPosts = <Map<String, dynamic>>[].obs;

  @override
  void onInit() {
    loadUserId();
    super.onInit();
  }

  Future<void> loadUserId() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    userID.value = sharedPreferences.getString(AppConstants.userId) ?? '';
  }

  // Image picker
  Future<void> pickImage({bool fromCamera = true}) async {
    final ImagePicker picker = ImagePicker();
    final pickedFile = await picker.pickImage(
      source: fromCamera ? ImageSource.camera : ImageSource.gallery,
    );

    if (pickedFile != null) {
      imagePath.value = pickedFile.path;
    }
  }

  void removeImage() {
    imagePath.value = '';
  }

  bool validatePost() {
    if (postText.value.trim().isEmpty) {
      Get.snackbar("Error", "Post content cannot be empty");
      return false;
    }
    if (userID.value.isEmpty) {
      Get.snackbar("Error", "Please login again");
      return false;
    }
    return true;
  }

  ///create post========================================================================
  Future<bool> createPost() async {
    if (!validatePost()) return false;

    isLoadingCreate.value = true;

      Map<String, String> body = {
        'content': postText.value.trim(),
        'authorId': userID.value,
      };

      List<MultipartBody>? multipartFiles;
      if (imagePath.value.isNotEmpty) {
        multipartFiles = [MultipartBody('post_images', File(imagePath.value))];
      }

      final response = await ApiClient.postMultipartData(
        ApiUrl.createPost,
        body,
        multipartBody: multipartFiles,
      );

      if (response.statusCode == 200) {
        Map<String, dynamic> newPost = {
          '_id': response.body['data']['_id'],
          'content': postText.value.trim(),
          'authorId': userID.value,
          'post_images': imagePath.value.isNotEmpty ? [imagePath.value] : [],
        };
        myPosts.insert(0, newPost);

        // ফিল্ড ক্লিয়ার
        postText.value = '';
        imagePath.value = '';

        Get.snackbar("Success", "Post created successfully");
        return true; // success
      } else {
        ApiChecker.checkApi(response);
        return false;
      }

  }



  ///get my post==================================================================================Get Method====================
  Rx<Status> myPostStatus = Status.loading.obs;
  var isLoadingPost = false.obs;
  RxList<MyPostModel> myPostList = <MyPostModel>[].obs;

  Future<void> fetchMyPost() async {
    isLoadingPost.value = true;
    final response = await ApiClient.getData(ApiUrl.getMyPost);
    isLoadingPost.value = false;
    if (response.statusCode == 200 || response.statusCode == 201) {
      myPostList.value =
          (response.body['data'] as List)
              .map((x) => MyPostModel.fromJson(x))
              .toList();

      myPostStatus(Status.completed);
    } else {
      myPostList.clear();
      myPostStatus(Status.error);
      ApiChecker.checkApi(response);
    }
  }

  ///update post==================================================================Patch Methode=======================================
  Rx<Status> updatePostStatus = Status.loading.obs;
  var isLoadingUpdate = false.obs;

  Future<void> updatePost(String postId, String content) async {
    isLoadingUpdate(true);
    final body = {"content": content};

    final response = await ApiClient.patchData(
      ApiUrl.updatePost(postId),
      body,
      isJson: true,
    );
    isLoadingUpdate(false);
    if (response.statusCode == 200 || response.statusCode == 201) {
      showCustomSnackBar("Post updated successfully", isError:  false);

      fetchMyPost();

      Get.back();

     // return true;
    } else {
     ApiChecker.checkApi(response);
    //  return false;
    }
  }
}
