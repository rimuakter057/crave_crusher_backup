import 'package:get/get.dart';
import 'package:crave_crusher/service/api_check.dart';
import 'package:crave_crusher/service/api_client.dart';
import 'package:crave_crusher/service/api_url.dart';
import 'package:crave_crusher/utils/app_const/app_const.dart';
import 'package:crave_crusher/view/features/notification/models/notification_model.dart';

class HomeController extends GetxController {
  RxDouble progress = 0.58.obs;

  void updateProgress(double value) {
    progress.value = value.clamp(0.0, 1.0);
  }

  String get progressText => "${(progress.value * 100).toInt()}%";

  ///notification==========================================
  RxList<NotificationModel> notificationList = <NotificationModel>[].obs;
  var isLoadingNotification = false.obs;
  Rx<Status> notificationStatus = Status.loading.obs;
  var currentPage = 1.obs;
  var limit = 10.obs;
  var totalPage = 1.obs;

  @override
  void onInit() {
    super.onInit();
    fetchNotificationList(isRefresh: true);
  }

  /// Fetch notification list
  Future<void> fetchNotificationList({bool isRefresh = false}) async {
    if (isRefresh) {
      // Pull-to-refresh / initial load
      currentPage.value = 1;
      notificationList.clear();
      isLoadingNotification.value = false; // circular loader handled in UI
    } else {
      // Scroll bottom pagination
      isLoadingNotification.value = true; // linear loader
    }

    final response = await ApiClient.getData(
      ApiUrl.getNotifications(page: currentPage.value, limit: limit.value),
    );

    isLoadingNotification.value = false;

    if (response.statusCode == 200 || response.statusCode == 201) {
      final data = response.body['data']['result'] as List;
      totalPage.value = response.body['data']['meta']['totalPage'] ?? 1;

      if (currentPage.value == 1) {
        notificationList.value =
            data.map((e) => NotificationModel.fromJson(e)).toList();
      } else {
        notificationList.addAll(
          data.map((e) => NotificationModel.fromJson(e)).toList(),
        );
      }

      notificationStatus.value = Status.completed;
    } else {
      if (currentPage.value == 1) notificationList.clear();
      notificationStatus(Status.error);
      ApiChecker.checkApi(response);
    }
  }

  /// Fetch next page for pagination
  void fetchNextPageNotifications() {
    if (currentPage.value < totalPage.value && !isLoadingNotification.value) {
      currentPage.value++;
      fetchNotificationList(); // default isRefresh = false
    }
  }
}
