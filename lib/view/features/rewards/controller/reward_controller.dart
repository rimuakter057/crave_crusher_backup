import 'package:get/get.dart';

class RewardsController extends GetxController {
  RxDouble progress = 1.0.obs; // initial progress

  void updateProgress(double value) {
    progress.value = value.clamp(0.0, 1.0);
  }

  String get progressText => "${(progress.value * 100).toInt()}%";
}
