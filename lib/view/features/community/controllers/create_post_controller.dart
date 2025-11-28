// import 'dart:io';
// import 'package:crave_crusher/service/api_client.dart';
// import 'package:crave_crusher/service/api_url.dart';
// import 'package:get/get.dart';
// import 'package:image_picker/image_picker.dart';
// import 'package:shared_preferences/shared_preferences.dart';
// import '../../../../utils/app_const/app_const.dart' show AppConstants;
//
// class AddPostController extends GetxController {
//   var postText = ''.obs;
//   var imagePath = ''.obs;
//   var isLoading = false.obs;
//
//   RxString userID = ''.obs;
//
//
//   RxList<Map<String, dynamic>> myPosts = <Map<String, dynamic>>[].obs;
//
//   @override
//   void onInit() {
//     loadUserId();
//     super.onInit();
//   }
//
//   Future<void> loadUserId() async {
//     SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
//     userID.value = sharedPreferences.getString(AppConstants.userId) ?? '';
//   }
//
//   // Image picker
//   Future<void> pickImage({bool fromCamera = true}) async {
//     final ImagePicker picker = ImagePicker();
//     final pickedFile = await picker.pickImage(
//         source: fromCamera ? ImageSource.camera : ImageSource.gallery);
//
//     if (pickedFile != null) {
//       imagePath.value = pickedFile.path;
//     }
//   }
//
//   void removeImage() {
//     imagePath.value = '';
//   }
//
//   bool validatePost() {
//     if (postText.value.trim().isEmpty) {
//       Get.snackbar("Error", "Post content cannot be empty");
//       return false;
//     }
//     if (userID.value.isEmpty) {
//       Get.snackbar("Error", "Please login again");
//       return false;
//     }
//     return true;
//   }
//
//
//   Future<bool> createPost() async {
//     if (!validatePost()) return false;
//
//     isLoading.value = true;
//     try {
//       Map<String, String> body = {
//         'content': postText.value.trim(),
//         'authorId': userID.value,
//       };
//
//       List<MultipartBody>? multipartFiles;
//       if (imagePath.value.isNotEmpty) {
//         multipartFiles = [MultipartBody('post_images', File(imagePath.value))];
//       }
//
//       final response = await ApiClient.postMultipartData(
//         ApiUrl.createPost,
//         body,
//         multipartBody: multipartFiles,
//       );
//
//       if (response.statusCode == 200) {
//         Map<String, dynamic> newPost = {
//           '_id': response.body['data']['_id'],
//           'content': postText.value.trim(),
//           'authorId': userID.value,
//           'post_images': imagePath.value.isNotEmpty ? [imagePath.value] : [],
//         };
//         myPosts.insert(0, newPost);
//
//         // ফিল্ড ক্লিয়ার
//         postText.value = '';
//         imagePath.value = '';
//
//         Get.snackbar("Success", "Post created successfully");
//         return true; // success
//       } else {
//         Get.snackbar("Error", response.body['message'] ?? "Something went wrong");
//         return false;
//       }
//     } catch (e) {
//       Get.snackbar("Error", e.toString());
//       return false;
//     } finally {
//       isLoading.value = false;
//     }
//   }
// }
