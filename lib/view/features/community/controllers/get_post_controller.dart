import 'package:crave_crusher/service/api_check.dart';
import 'package:crave_crusher/service/api_client.dart';
import 'package:crave_crusher/service/api_url.dart';
import 'package:crave_crusher/utils/app_const/app_const.dart';
import 'package:crave_crusher/view/features/community/models/my_post_model.dart';
import 'package:crave_crusher/view/features/community/models/post_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:logger/logger.dart';

class GetPostController extends GetxController {

  /// get all post ====================================

  var allPostList = <Data>[].obs;
  var isLoading = false.obs;
  static final Logger logger = Logger();

  Future<void> fetchAllPosts() async {
    try {
      isLoading.value = true;

      final response = await ApiClient.getData(ApiUrl.getAllPost);
      if (response.statusCode == 200 && response.body['data'] != null) {
        var postList = (response.body['data'] as List)
            .map((e) => Data.fromJson(e))
            .toList();
        this.allPostList.value = postList;

         // for(int i =0 ; i < posts.length; i++){
         //   debugPrint('============== post id =========== ${posts[i].sId}');
         // }

      } else {
        this.allPostList.clear();
      }
    } catch (e) {
      this.allPostList.clear();
      Logger().e("Fetch posts error: $e");
    } finally {
      isLoading.value = false;
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









