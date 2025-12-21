
import 'package:crave_crusher/service/api_check.dart';
import 'package:crave_crusher/service/api_client.dart';
import 'package:crave_crusher/service/api_url.dart';
import 'package:crave_crusher/utils/app_const/app_const.dart';
import 'package:crave_crusher/view/features/community/controllers/post_controller.dart';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

import 'package:permission_handler/permission_handler.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:logger/logger.dart';

import '../models/comment_model.dart';

class CommunityController extends GetxController {
  RxInt communityTabIndex = 0.obs;

  final PostController postController = Get.find<PostController>();

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

  /// Create a comment =====================================================================

  Future<bool> createComment(String postId, {required bool allFeed}) async {
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
      if (response.statusCode == 200 || response.statusCode == 201) {
        isLoadingSend.value = true;

        commentText.value = '';

        if (allFeed) {
          postController.fetchAllPosts();
        } else {
          postController.fetchMyPost();
        }
        await fetchCommentList(postId, callFormCreateComment:  true);

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

  Future<void> fetchCommentList(String postId, {bool callFormCreateComment = false}) async {

     if(callFormCreateComment){
       isLoadingComment.value = false;
     }else{
       isLoadingComment.value = true;
     }

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

  /// Add or remove vote==============================================post method==========================================

  RxList<String> userVotedPosts = <String>[].obs;

  Future<bool> addVote({
    required String postId,
    required int index,
    required bool isMyPost,
    required bool hasVoted,
  }) async {
    if (userID.value.isEmpty) return false;
    final body = {'userId': userID.value};
    final response = await ApiClient.postData(
      ApiUrl.addVote(postId),
      body,
      isJson: true,
    );
    if (response.statusCode == 200 || response.statusCode == 201) {
      // Toggle UI logic

      debugPrint("===========================>>>  hasVoted: $hasVoted");
      debugPrint("===========================>>>  index: $index");
      debugPrint("===========================>>>  isMyPost: $isMyPost");

    if(isMyPost){
      if(hasVoted) {
        postController.getMyPostList.reversed.toList()[index].totalVotes =
            postController.getMyPostList.reversed.toList()[index].totalVotes - 1;
        postController.getMyPostList.reversed.toList()[index].hasVoted.value = false;
      }else{
        postController.getMyPostList.reversed.toList()[index].totalVotes =
            postController.getMyPostList.reversed.toList()[index].totalVotes + 1;
        postController.getMyPostList.reversed.toList()[index].hasVoted.value = true;

      }

    }else{
      if(hasVoted) {
        postController.allPostList.reversed.toList()[index].totalVotes =
            postController.allPostList.reversed.toList()[index].totalVotes - 1;
        postController.allPostList.reversed.toList()[index].hasVoted.value = false;
      }else{
        postController.allPostList.reversed.toList()[index].totalVotes =
            postController.allPostList.reversed.toList()[index
            ].totalVotes + 1;
        postController.allPostList.reversed.toList()[index].hasVoted.value = true;

      }}

      return true;
    } else {
      ApiChecker.checkApi(response);
      return false;
    }
  }








/// download images============================
//   var isDownloading = false.obs;
//
//   Future<void> downloadImage(String imageUrl) async {
//     try {
//       // Request storage/photos permission
//       var status = await Permission.storage.request();
//       if (!status.isGranted) {
//         Get.snackbar("Permission Denied", "Storage permission is required");
//         return;
//       }
//
//       isDownloading.value = true;
//
//       // Download image bytes
//       var response = await http.get(Uri.parse(imageUrl));
//       if (response.statusCode == 200) {
//         // Use ImageDownloader package
//         try {
//           var imageId = await ImageDownloader.downloadImage(
//             imageUrl,
//             destination: AndroidDestinationType.directoryPictures
//               ..subDirectory("image_${DateTime.now().millisecondsSinceEpoch}.png"),
//           );
//
//           if (imageId != null) {
//             Get.snackbar("Success", "Image saved to gallery");
//           } else {
//             Get.snackbar("Failed", "Failed to save image");
//           }
//         } catch (e) {
//           Get.snackbar("Error", "Failed to save image: $e");
//         }
//       } else {
//         Get.snackbar(
//             "Failed", "Failed to download image: ${response.statusCode}");
//       }
//     } catch (e) {
//       Get.snackbar("Error", e.toString());
//       debugPrint("error ================================= ${e.toString()}");
//     } finally {
//       isDownloading.value = false;
//     }
//   }
  }










