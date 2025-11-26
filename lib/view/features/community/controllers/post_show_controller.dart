import 'package:crave_crusher/service/api_url.dart';
import 'package:crave_crusher/service/network_caller.dart';
import 'package:crave_crusher/view/features/community/models/post_model.dart';
import 'package:get/get.dart';

class PostShowController extends GetxController {
  bool _getPostsInProgress = false;
  List<Data> _postList = [];
  String? _errorMessage;

  // Getters
  bool get getPostsInProgress => _getPostsInProgress;
  List<Data> get posts => _postList;
  String? get errorMessage => _errorMessage;

  @override
  void onInit() {
    super.onInit();
    getPosts();
  }

  Future<bool> getPosts() async {
    bool isSuccess = false;
    _getPostsInProgress = true;
    update();
    final NetworkResponse response =
    await Get.find<NetworkCaller>().getRequest(url: ApiUrl.getAllPost);

    if (response.isSuccess && response.responseData != null) {
      try {
        // ensure response is a Map
        final Map<String, dynamic> json =
        Map<String, dynamic>.from(response.responseData!);
        PostModel postModel = PostModel.fromJson(json);
        _postList = postModel.data ?? [];
        print("Posts parsed: ${_postList.length}"); // debug
        _errorMessage = null;
        isSuccess = true;
      } catch (e) {
        print("Parsing error: $e");
        _errorMessage = "Failed to parse posts";
      }
    } else {
      _errorMessage = response.errorMessage ?? "Something went wrong";
    }

    _getPostsInProgress = false;
    update(); // rebuild UI
    return isSuccess;
  }
}
