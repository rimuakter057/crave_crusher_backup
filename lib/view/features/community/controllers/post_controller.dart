import 'dart:io';

import 'package:crave_crusher/service/api_check.dart';
import 'package:crave_crusher/service/api_client.dart';
import 'package:crave_crusher/service/api_url.dart';
import 'package:crave_crusher/utils/app_const/app_const.dart';
import 'package:crave_crusher/view/features/community/models/my_post_model.dart';
import 'package:crave_crusher/view/features/community/models/post_model.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:logger/logger.dart';
import 'package:shared_preferences/shared_preferences.dart';


class PostController extends GetxController {

  ///create post=============================================================



  var postText = ''.obs;
  var imagePath = ''.obs;
  var isLoading = false.obs;

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
        source: fromCamera ? ImageSource.camera : ImageSource.gallery);

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


  Future<bool> createPost() async {
    if (!validatePost()) return false;

    isLoading.value = true;
    try {
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
        Get.snackbar("Error", response.body['message'] ?? "Something went wrong");
        return false;
      }
    } catch (e) {
      Get.snackbar("Error", e.toString());
      return false;
    } finally {
      isLoading.value = false;
    }
  }


  /// get all post ====================================

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
        this.allPostList.clear();
      }
    } catch (e) {
      allPostList.clear();
      Logger().e("Fetch posts error: $e");
    } finally {
      isLoadingAllPost.value = false;
    }
  }

  ///get my post==========================================
  Rx<Status> myPostStatus = Status.loading.obs;
  var isLoadingPost = false.obs;
  RxList<MyPostModel> myPostList = <MyPostModel>[].obs;

  Future<void> fetchMyPost() async {
    isLoadingPost.value = true;

    final response = await ApiClient.getData(ApiUrl.getMyPost);

    isLoadingPost.value = false;

    if (response.statusCode == 200 || response.statusCode == 201) {

      myPostList.value = (response.body['data'] as List)
          .map((x) => MyPostModel.fromJson(x))
          .toList();

      myPostStatus(Status.completed);
    } else {
      myPostList.clear();
      myPostStatus(Status.error);
      ApiChecker.checkApi(response);
    }
  }




// Rx<Status> myPostStatus=Status.loading.obs;
//   var isLoadingPost=false.obs;
//   RxList<MyPostModel> myPostList=<MyPostModel>[].obs;
//
//   Future <void> fetchMyPost()async{
//     isLoadingPost.value=true;
//     final response=await ApiClient.getData(ApiUrl.getMyPost);
//     isLoadingPost.value=false;
//  if(response.statusCode==200 && response.statusCode==201){
//    myPostList.value= List<MyPostModel>.from(
//      response.body['data'].toMap((x)=>MyPostModel.fromJson(x)),
//    );
//    myPostStatus(Status.completed);
//  }else{
//    myPostList.clear();
//    myPostStatus(Status.error);
//      ApiChecker.checkApi(response);
//  }

  }

  // Rx<Status> commentStatus = Status.loading.obs;
  // var isLoadingFetch = false.obs;
  // RxList<CommentModel> commentList = <CommentModel>[].obs;
  //
  // /// Fetch all comments for a specific post
  // Future<void> fetchCommentList(String postId) async {
  //   isLoadingFetch.value = true;
  //   debugPrint('Fetching comments for post: $postId');
  //   final response = await ApiClient.getData(ApiUrl.getAllComment(postId));
  //   isLoadingFetch.value = false;
  //   if (response.statusCode == 200 && response.statusCode == 201) {
  //     commentList.value = List<CommentModel>.from(
  //       response.body['data'].toMap((x) => CommentModel.fromJson(x)),
  //     );
  //
  //     commentStatus
  //   } else {
  //     comments.clear();
  //     commentStatus(Status.error);
  //
  //     ApiChecker.checkApi(response);
  //   }
  //}









