import 'package:crave_crusher/service/api_client.dart';
import 'package:crave_crusher/service/api_url.dart';
import 'package:crave_crusher/utils/app_const/app_const.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CommunityController extends GetxController {
  var commentText = ''.obs;
  var isLoading = false.obs;
  RxString userID = ''.obs;
  RxList<Map<String, dynamic>> myComment = <Map<String, dynamic>>[].obs;
  @override
  void onInit() {
    loadUserId();
    super.onInit();
  }
  Future<void> loadUserId() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    userID.value = sharedPreferences.getString(AppConstants.userId) ?? '';
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

  Future <bool> createComment() async {
    if (!validateComment()) return false;

    isLoading.value = true;
    try{
      Map<String, String> body = {
        'commentText': commentText.value,
        'authorId': userID.value,
      };

      final response = await ApiClient.postData(ApiUrl.createComment, body);
     if(response.statusCode==200){
       Map<String,dynamic> newComment={
         '_id': response.body['data']['_id'],
         'commentText': commentText.value,
         'authorId': userID.value,
       };

       myComment.insert(0, newComment);

       commentText.value = '';

       Get.snackbar("Success", "Comment post successfully");
       return true; // success
     }else {
       Get.snackbar("Error", response.body['message'] ?? "Something went wrong");
       return false;
     }

    }catch (e) {
      Get.snackbar("Error", e.toString());
      return false;
    } finally {
      isLoading.value = false;
    }
  }
}


