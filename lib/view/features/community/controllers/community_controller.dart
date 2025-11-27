import 'package:crave_crusher/service/api_client.dart';
import 'package:crave_crusher/service/api_url.dart';
import 'package:crave_crusher/utils/app_const/app_const.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:logger/logger.dart';

class CommunityController extends GetxController {
  var commentText = ''.obs;
  var isLoading = false.obs;
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

    isLoading.value = true;
    try {
      Map<String, String> body = {
        'commentText': commentText.value,
        'authorId': userID.value,
        'postId': postId,
      };

      final response = await ApiClient.postData(ApiUrl.createComment, body);

      if (response.statusCode == 200) {
        Map<String, dynamic> newComment = {
          '_id': response.body['data']['_id'],
          'commentText': commentText.value,
          'authorId': {
            '_id': userID.value,
            'fullName': 'You', // অথবা prefs থেকে নাম নেওয়া যেতে পারে
            'profileImage': null
          }
        };

        comments.insert(0, newComment); // instant add
        commentText.value = '';

        Get.snackbar("Success", "Comment posted successfully");
        return true;
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

  /// Fetch all comments for a specific post
  Future<void> fetchCommentList(String postId) async {
    try {
      isLoading.value = true;

      final response = await ApiClient.getData(ApiUrl.getAllComment(postId));

      if (response.statusCode == 200 && response.body['data'] != null) {
        // Map to List<Map<String, dynamic>>
        var commentList = (response.body['data'] as List)
            .map((e) => Map<String, dynamic>.from(e))
            .toList();
        comments.value = commentList;
      } else {
        comments.clear();
      }
    } catch (e) {
      comments.clear();
      logger.e("Fetch comments error: $e");
    } finally {
      isLoading.value = false;
    }
  }

}
