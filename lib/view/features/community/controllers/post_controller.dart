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
  // ======================== VARIABLES ============================
  var postText = ''.obs;
  var imagePaths = <String>[].obs; // multiple image support
  var isLoadingCreate = false.obs;
  RxString userID = ''.obs;

  RxList<Map<String, dynamic>> myPosts = <Map<String, dynamic>>[].obs;

  @override
  void onInit() {
    loadUserId();
    super.onInit();
  }

  // ======================== LOAD USER ID =========================
  Future<void> loadUserId() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    userID.value = sharedPreferences.getString(AppConstants.userId) ?? '';
  }

  // ========================= IMAGE PICKER =========================
  Future<void> pickImages() async {
    final ImagePicker picker = ImagePicker();
    final List<XFile> pickedFiles = await picker.pickMultiImage();

    if (pickedFiles.isNotEmpty) {
      imagePaths.addAll(pickedFiles.map((e) => e.path).toList());
    }
  }

  void removeImage(String path) {
    imagePaths.remove(path);
  }

  void removeAllImages() {
    imagePaths.clear();
  }

  // ========================= VALIDATION =========================
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

  // ========================= CREATE POST =========================
  Future<bool> createPost() async {
    if (!validatePost()) return false;

    isLoadingCreate.value = true;

    Map<String, String> body = {
      'content': postText.value.trim(),
      'authorId': userID.value,
    };

    List<MultipartBodyPost> multipartFiles = [];

    // Attach Multiple Images
    for (var path in imagePaths) {
      multipartFiles.add(MultipartBodyPost('post_images', File(path)));
    }

    final response = await ApiClient.postMultipartData(
      ApiUrl.createPost,
      body,
      multipartBody: multipartFiles.isNotEmpty ? multipartFiles : null,
    );

    isLoadingCreate.value = false;

    if (response.statusCode == 200) {
      Map<String, dynamic> newPost = {
        '_id': response.body['data']['_id'],
        'content': postText.value.trim(),
        'authorId': userID.value,
        'post_images': imagePaths.toList(),
      };

      myPosts.insert(0, newPost);

      // Reset
      postText.value = '';
      imagePaths.clear();

      Get.snackbar("Success", "Post created successfully");
      return true;
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
