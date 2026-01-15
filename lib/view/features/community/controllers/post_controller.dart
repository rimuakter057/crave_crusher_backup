import 'dart:convert';
import 'dart:io';

import 'package:crave_crusher/service/api_check.dart';
import 'package:crave_crusher/service/api_client.dart';
import 'package:crave_crusher/service/api_url.dart';
import 'package:crave_crusher/utils/ToastMsg/toast_message.dart';
import 'package:crave_crusher/utils/app_const/app_const.dart';
import 'package:crave_crusher/view/features/community/models/all_post_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:logger/logger.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../screens/community_all_feed_screen/community_all_feed_screen.dart';

class PostController extends GetxController {
  /// get all post ==============================================================================Get Method====================
  RxList<PostModel> allPostList = <PostModel>[].obs;
  var isLoadingAllPost = false.obs;
  static final Logger logger = Logger();

  Future<void> fetchAllPosts() async {
    try {
      isLoadingAllPost.value = true;

      final response = await ApiClient.getData(ApiUrl.getAllPost);

      if (response.statusCode == 200 && response.body['data'] != null) {
        var postList =
            (response.body['data'] as List)
                .map((e) => PostModel.fromJson(e))
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

  /// get my post ==============================================================================Get Method====================
  RxList<PostModel> getMyPostList = <PostModel>[].obs;
  RxBool isLoadingPost = false.obs;



  Future<void> fetchMyPost() async {
    isLoadingPost.value = true;

    final response = await ApiClient.getData(ApiUrl.getMyPost);

    if (response.statusCode == 200 && response.body['data'] != null) {
      final data = response.body['data'];

      /// posts
      final List posts = data['posts'] ?? [];
      getMyPostList.assignAll(posts.map((e) => PostModel.fromJson(e)).toList());

      /// numbers

    } else {
       getMyPostList.clear();

    }

    isLoadingPost.value = false;
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

  /// ========================= IMAGE PICKER =========================
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

  /// ========================= CREATE POST =========================post multipart================================================
  Future<bool> createPost() async {
    if (!validatePost()) return false;

    isLoadingCreate.value = true;

    Map<String, String> body = {
      'content': postText.value.trim(),
      'authorId': userID.value,
    };

    List<MultipartBody> multipartFiles = [];

    // Attach Multiple Images
    for (var path in imagePaths) {
      multipartFiles.add(MultipartBody('post_images', File(path)));
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

  ///update post==================================================================Patch Methode=======================================
  Rx<Status> updatePostStatus = Status.loading.obs;
  var isLoadingUpdate = false.obs;
  var currentImagePaths = <String>[].obs;

  void pickImagesUpdate() async {
    final ImagePicker picker = ImagePicker();
    final List<XFile> pickedFiles =
        await picker.pickMultiImage(); // image picker
    if (pickedFiles.isNotEmpty) {
      currentImagePaths.addAll(pickedFiles.map((file) => file.path));
    }
  }

  RxList<String> deleteNetworkImagePaths = <String>[].obs;

  void deleteImage(String imagePath) {
    final bool isLocalFile = File(imagePath).existsSync();

    if (isLocalFile) {
      currentImagePaths.remove(imagePath);
    } else {
      deleteNetworkImagePaths.add(imagePath);
      currentImagePaths.remove(imagePath);
    }

    debugPrint(
      "=========is Local Image ==========================>$isLocalFile",
    );
    debugPrint(
      "========= delete network image ==========================>$deleteNetworkImagePaths",
    );
    debugPrint(
      "========= all Images ==========================>$currentImagePaths",
    );
  }

  Future<void> updatePost(String postId, String content) async {
    isLoadingUpdate(true);

    Map<String, String> body = {
      "content": content,
      "deleted_images": jsonEncode(deleteNetworkImagePaths.toList()),
    };

    RxList<MultipartBody> multipartFiles = <MultipartBody>[].obs;

    for (var path in currentImagePaths) {
      if (File(path).existsSync()) {
        multipartFiles.add(MultipartBody('post_images', File(path)));
      }else{
        continue;
      }
    }

    final response =
        multipartFiles.isEmpty
            ? await ApiClient.patchData(
              ApiUrl.updatePost(postId),
              body,
              isJson: true,
            )
            : await ApiClient.patchMultipartData(
              ApiUrl.updatePost(postId),
              body,
              multipartBody: multipartFiles.value,
            );

    isLoadingUpdate(false);

    if (response.statusCode == 200 || response.statusCode == 201) {
      showCustomSnackBar("Post updated successfully", isError: false);
      fetchMyPost();
      // ✅ navigate AFTER snackbar frame completes
      WidgetsBinding.instance.addPostFrameCallback((_) {
        Get.to(() => CommunityAllFeedScreen(initialTabIndex: 0));
      });
    } else {
      ApiChecker.checkApi(response);
    }
  }














  RxList<PostModel> singleUserProfileList = <PostModel>[].obs;
  RxBool isLoadingSingleUser = false.obs;

  RxInt totalReaction = 0.obs;
  RxInt totalBadge = 0.obs;
  RxInt totalPost = 0.obs;

  Future<void> fetchSingleUserProfile(String userId) async {
    isLoadingSingleUser.value = true;

    final response = await ApiClient.getData(ApiUrl.getSingleUserProfile(userId));

    if (response.statusCode == 200 && response.body['data'] != null) {
      final data = response.body['data'];

      /// posts
      final List posts = data['posts'] ?? [];
      singleUserProfileList.assignAll(posts.map((e) => PostModel.fromJson(e)).toList());

      /// numbers
      totalReaction.value = data['totalReaction'] ?? 0;
      totalBadge.value = data['totalBadge'] ?? 0;
      totalPost.value = data['totalPost'] ?? 0;
    } else {
      singleUserProfileList.clear();
      totalReaction.value = 0;
      totalBadge.value = 0;
      totalPost.value = 0;
    }

    isLoadingSingleUser.value = false;
  }





}
