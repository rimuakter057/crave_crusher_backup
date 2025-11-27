import 'package:crave_crusher/service/api_client.dart';
import 'package:crave_crusher/service/api_url.dart';
import 'package:crave_crusher/view/features/community/models/post_model.dart';
import 'package:get/get.dart';
import 'package:logger/logger.dart';

class PostShowController extends GetxController {
  var posts = <Data>[].obs;
  var isLoading = false.obs;
  static final Logger logger = Logger();


  Future<void> fetchPosts() async {
    try {
      isLoading.value = true;

      final response = await ApiClient.getData(ApiUrl.getAllPost);
      if (response.statusCode == 200 && response.body['data'] != null) {
        var postList = (response.body['data'] as List)
            .map((e) => Data.fromJson(e))
            .toList();
        posts.value = postList;
      } else {
        posts.clear();
      }
    } catch (e) {
      posts.clear();
      Logger().e("Fetch posts error: $e");
    } finally {
      isLoading.value = false;
    }
  }
}


