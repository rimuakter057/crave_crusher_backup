import 'package:crave_crusher/view/features/community/controllers/community_tab_controller.dart';
import 'package:crave_crusher/view/features/home/controller/home_controller.dart';
import 'package:crave_crusher/view/features/rewards/controller/reward_controller.dart';
import 'package:get/get.dart';

import '../../view/features/battle/controller/battle_controller.dart';

class DependencyInjection extends Bindings {
  @override
  void dependencies() {
    ///==========================Default Custom Controller ==================
      Get.lazyPut(() => BattleController(), fenix: true);

      Get.lazyPut(() => CommunityTabController(), fenix: true);

       Get.lazyPut(() => RewardsController(), fenix: true);
       Get.lazyPut(() => HomeController(), fenix: true);
    //   Get.lazyPut(() => ConnectionController(), fenix: true);
    //   Get.lazyPut(() => ProfileController(), fenix: true);
    //   Get.lazyPut(() => SettingsController(), fenix: true);
    //   Get.lazyPut(() => WifiSettingsController(), fenix: true);
    //   Get.lazyPut(() => LanguageController(), fenix: true);
    //   Get.put(NavController(), permanent: true);
  }
}
