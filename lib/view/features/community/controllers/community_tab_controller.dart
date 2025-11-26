import 'package:get/get.dart';

class CommunityTabController extends GetxController {
  /// Current selected tab index
  int communityTabIndex = 0;

  /// Update the selected tab
  void changeTab(int index) {
    communityTabIndex = index;
    update(); // triggers GetBuilder rebuild
  }
}
