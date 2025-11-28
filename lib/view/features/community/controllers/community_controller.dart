import 'dart:convert';

import 'package:crave_crusher/service/api_check.dart';
import 'package:crave_crusher/service/api_client.dart';
import 'package:crave_crusher/service/api_url.dart';
import 'package:crave_crusher/utils/app_const/app_const.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:logger/logger.dart';

import '../models/comment_model.dart';

class CommunityController extends GetxController {

  ///create comment section=================================
  var commentText = ''.obs;
  var isLoadingSend = false.obs;
  RxString userID = ''.obs;
  RxList<Map<String, dynamic>> comments = <Map<String, dynamic>>[].obs;

  static final Logger logger = Logger();

  @override
  void onInit() {
    super.onInit();
    loadUserId();
  }

  Future<void> loadUserId() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    userID.value = prefs.getString(AppConstants.userId) ?? '';
  }

  bool validateComment() {
    if (commentText.value.trim().isEmpty) {
      Get.snackbar("Error", "Comment cannot be empty");
      return false;
    }
    if (userID.value.isEmpty) {
      Get.snackbar("Error", "Please login again");
      return false;
    }
    return true;
  }

  /// Create a comment and update list instantly
  Future<bool> createComment(String postId) async {
    if (!validateComment()) return false;

    isLoadingSend.value = true;
    try {
      Map<String, dynamic> body = {
        'commentText': commentText.value,
        'authorId': userID.value,

      };

      final response = await ApiClient.postData(
        ApiUrl.createComment(postId),
        body,
        isJson: true,
      );
      isLoadingSend.value = false;
      if (response.statusCode == 200  || response.statusCode == 201) {
        // Map<String, dynamic> newComment = {
        //   '_id': response.body['data']['_id'],
        //   'commentText': commentText.value,
        //   'authorId': {
        //     '_id': userID.value,
        //     'fullName': 'You',
        //     'profileImage': null,
        //   },
        // };
        isLoadingSend.value = true;
        ///=====================================================================
        CommentModel model = CommentModel(
          id: "",
          commentText: commentText.value,
          authorId: userID.value,
          createdAt: DateTime.now()
        );
        commentList.insert(0, model);
        ///=====================================================================
        commentText.value = '';

        Get.snackbar("Success", "Comment posted successfully");
        return true;
      } else {
        Get.snackbar(
          "Error",
          response.body['message'] ?? "Something went wrong",
        );
        return false;
      }
    } catch (e) {
      Get.snackbar("Error", e.toString());
      return false;
    } finally {
      isLoadingSend.value = false;
    }
  }



///fetch comment====================================
   Rx<Status> commentStatus = Status.loading.obs;
  var isLoadingComment = false.obs;
  RxList<CommentModel> commentList = <CommentModel>[].obs;

  /// Fetch all comments for a specific post
  Future<void> fetchCommentList(String postId) async {
    isLoadingComment.value = true;
     debugPrint('Fetching comments for post:=============================== $postId');
    final response = await ApiClient.getData(ApiUrl.getAllComment(postId));
    isLoadingComment.value = false;
    if (response.statusCode == 200 || response.statusCode == 201) {
      final data = response.body['data'] as List;
      commentList.value = data.map((e) => CommentModel.fromJson(e)).toList();

      commentStatus(Status.completed);
    } else {
      comments.clear();
      commentStatus(Status.error);

      ApiChecker.checkApi(response);
    }
  }


  ///get my post==========================================
  // Rx<Status> myPostStatus = Status.loading.obs;
  // var isLoadingPost = false.obs;
  // RxList<MyPostModel> myPostList = <MyPostModel>[].obs;
  //
  // Future<void> fetchMyPost() async {
  //   isLoadingPost.value = true;
  //
  //   final response = await ApiClient.getData(ApiUrl.getMyPost);
  //
  //   isLoadingPost.value = false;
  //
  //   if (response.statusCode == 200 || response.statusCode == 201) {
  //
  //     myPostList.value = (response.body['data'] as List)
  //         .map((x) => MyPostModel.fromJson(x))
  //         .toList();
  //
  //     myPostStatus(Status.completed);
  //   } else {
  //     myPostList.clear();
  //     myPostStatus(Status.error);
  //     ApiChecker.checkApi(response);
  //   }
  // }
  //
  //










}
