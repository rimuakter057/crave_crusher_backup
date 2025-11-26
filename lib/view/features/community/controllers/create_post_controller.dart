import 'package:crave_crusher/view/features/community/models/create_post_model.dart';
import 'package:get/get.dart';
import 'package:crave_crusher/service/network_caller.dart';
import 'package:crave_crusher/service/api_url.dart';


class CreatePostController extends GetxController {
  bool _inProgress = false;
  bool get inProgress => _inProgress;

  String? _errorMessage;
  String? get errorMessage => _errorMessage;

  CreatePostModel? _createdPost;
  CreatePostModel? get createdPost => _createdPost;

  /// Function to create a post
  Future<bool> createPost({
    required String content,
    List<String>? postImages,
  }) async {
    bool isSuccess = false;
    _inProgress = true;
    update();

    try {
      final NetworkResponse response = await Get.find<NetworkCaller>().postRequest(
        url: "${ApiUrl.baseUrl}/community-post/create-post", // your API
        body: {
          'content': content,
          'post_images': postImages ?? [],
        },
      );

      if (response.isSuccess && response.responseData != null) {
        _errorMessage = null;

        // Parse the response to model
        if (response.responseData!['data'] != null) {
          _createdPost = CreatePostModel.fromJson(response.responseData!['data']);
        }

        isSuccess = true;
      } else {
        _errorMessage = response.errorMessage ?? "Something went wrong";
      }
    } catch (e) {
      _errorMessage = e.toString();
    }

    _inProgress = false;
    update();
    return isSuccess;
  }
}
