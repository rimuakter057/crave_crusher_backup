import 'package:get/get.dart';

class CustomController extends GetxController {
  RxInt currentIndex = 0.obs;
  RxList<String> categoryList = ["Male", "Female"].obs;
}
