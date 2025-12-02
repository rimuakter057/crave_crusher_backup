
import 'package:get/get.dart';

class HomeController extends GetxController {

RxDouble progress= 0.58.obs;

void updateProgress(double value){
  progress.value=value.clamp(0.0, 1.0);
}

String get progressText => "${(progress.value * 100).toInt()}%";
}




