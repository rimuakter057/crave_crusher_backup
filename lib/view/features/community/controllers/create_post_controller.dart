import 'package:crave_crusher/service/api_client.dart';
import 'package:crave_crusher/service/api_url.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';


class AddPostController extends GetxController {
  //============================= Rx Variables ===========================
  var postText = ''.obs;
  var imagePath = ''.obs;
  var isLoading = false.obs;

  //============================= Image Picker ===========================
  Future<void> pickImage({bool fromCamera = true}) async {
    final ImagePicker _imagePicker = ImagePicker();
    final image = await _imagePicker.pickImage(
      source: fromCamera ? ImageSource.camera : ImageSource.gallery,
    );

    if (image != null) {
      imagePath.value = image.path; // Rx updated
    }
  }

  void removeImage() {
    imagePath.value = '';
  }

  //============================= Post Validation ========================
  bool validatePost() {
    if (postText.value.trim().isEmpty) {
      Get.snackbar("Error", "Post content cannot be empty");
      return false;
    }
    return true;
  }

  //============================= Create Post ============================
  Future<void> createPost(String authorId) async {
    if (!validatePost()) return;

    isLoading.value = true;

    try {
      Map<String, String> body = {
        'content': postText.value.trim(),
        'authorId': authorId,
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
        Get.snackbar("Success", "Post created successfully");
        postText.value = '';
        imagePath.value = '';
      } else {
        Get.snackbar("Error", response.body['message'] ?? "Something went wrong");
      }
    } catch (e) {
      Get.snackbar("Error", e.toString());
    } finally {
      isLoading.value = false;
    }
  }
}
