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

  ///create comment section=============================================Post Method============================================
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

  /// Create a comment and update list instantly=======================================================================
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



///get all comment==========================================================Get Method=============================================
   Rx<Status> commentStatus = Status.loading.obs;
  var isLoadingComment = false.obs;
  RxList<CommentModel> commentList = <CommentModel>[].obs;

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


  ///add vote ================================================================

  RxList<String> reactList = <String>[].obs; // locally liked posts
  RxMap<String, int> likesMap = <String, int>{}.obs; // postId -> total likes
  Future<bool> addVote(String postId) async {
    try {
      final body = {'userId': userID.value};
      final response = await ApiClient.postData(
        ApiUrl.addVote(postId),
        body,
        isJson: true,
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        if (reactList.contains(postId)) {
          reactList.remove(postId);
        } else {
          reactList.add(postId);
        }

        // update likes count from API response
        final updatedCount = response.body['totalVotes'] ?? 0;
        likesMap[postId] = updatedCount;

        return true;
      } else {
        Get.snackbar("Error", "Failed to add reaction");
        return false;
      }
    } catch (e) {
      Get.snackbar("Error", "Exception: $e");
      return false;
    }
  }

}
