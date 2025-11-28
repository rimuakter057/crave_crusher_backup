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
        'postId': postId,
      };

      final response = await ApiClient.postData(
        ApiUrl.createComment(userID.value),
        body,
        isJson: true,
      );
      isLoadingSend.value = false;
      if (response.statusCode == 200) {
        Map<String, dynamic> newComment = {
          '_id': response.body['data']['_id'],
          'commentText': commentText.value,
          'authorId': {
            '_id': userID.value,
            'fullName': 'You',
            'profileImage': null,
          },
        };
        isLoadingSend.value = true;
        CommentModel model = CommentModel(
          id: "",
          commentText: commentText.value,
          authorId: userID.value,
          createdAt: DateTime.now()
        );
        commentList.insert(0, model);
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
  var isLoadingFetch = false.obs;
  RxList<CommentModel> commentList = <CommentModel>[].obs;

  /// Fetch all comments for a specific post
  Future<void> fetchCommentList(String postId) async {
    isLoadingFetch.value = true;
     debugPrint('Fetching comments for post: $postId');
    final response = await ApiClient.getData(ApiUrl.getAllComment(postId));
    isLoadingFetch.value = false;
    if (response.statusCode == 200 && response.statusCode == 201) {
      commentList.value = List<CommentModel>.from(
        response.body['data'].toMap((x) => CommentModel.fromJson(x)),
      );

      commentStatus(Status.completed);
    } else {
      comments.clear();
      commentStatus(Status.error);

      ApiChecker.checkApi(response);
    }
  }
}
