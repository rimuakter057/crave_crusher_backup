import 'package:crave_crusher/service/network_caller.dart';
import 'package:crave_crusher/view/features/account_setting/controllers/acount_setting_controller.dart';
import 'package:crave_crusher/view/features/auth/controllers/auth_controller.dart';
import 'package:crave_crusher/view/features/auth/controllers/forget_password_controller.dart';
import 'package:crave_crusher/view/features/auth/controllers/login_controller.dart';
import 'package:crave_crusher/view/features/auth/controllers/reset_password_controller.dart';
import 'package:crave_crusher/view/features/auth/controllers/reset_resend_otp_controller.dart';
import 'package:crave_crusher/view/features/auth/controllers/sign_up_controller.dart';
import 'package:crave_crusher/view/features/auth/controllers/user_resend_otp_controller.dart';
import 'package:crave_crusher/view/features/auth/controllers/verify_account_otp_controller.dart';
import 'package:crave_crusher/view/features/auth/controllers/verify_identity_otp_controller.dart';
import 'package:crave_crusher/view/features/change_password/controllers/change_password_controller.dart';
import 'package:crave_crusher/view/features/community/controllers/community_controller.dart';

import 'package:crave_crusher/view/features/community/controllers/post_controller.dart';

import 'package:crave_crusher/view/features/home/controller/home_controller.dart';
import 'package:crave_crusher/view/features/profile/controllers/profile_controller.dart';
import 'package:crave_crusher/view/features/rewards/controller/reward_controller.dart';
import 'package:get/get.dart';
import '../../view/features/battle/controller/battle_controller.dart';

class DependencyInjection extends Bindings {
  @override
  void dependencies() {

    
    Get.put(NetworkCaller());

    Get.put(AuthController());

    //auth================================
    Get.lazyPut(() => SignUpController(), fenix: true);
    Get.lazyPut(() => LogInController(), fenix: true);
    Get.lazyPut(() => VerifyAccountOtpController(), fenix: true);
    Get.lazyPut(() => ForgetPasswordController(), fenix: true);
    Get.lazyPut(() => VerifyIdentityOtpController(), fenix: true);
    Get.lazyPut(() => ResetPasswordController(), fenix: true);
    Get.lazyPut(() => ResendOtpController(), fenix: true);
    Get.lazyPut(() => UserResendOtpController(), fenix: true);
    Get.lazyPut(() => ChangePasswordController(), fenix: true);

    ///==========================Community section==================

    //Get.lazyPut(() => AddPostController(), fenix: true);
   Get.lazyPut(() => PostController(), fenix: true);
    Get.lazyPut(() => CommunityController(), fenix: true);


///profile section========================
    Get.lazyPut(() => ProfileController(), fenix: true);

    ///==========================Default Custom Controller ==================
      Get.lazyPut(() => BattleController(), fenix: true);

       Get.lazyPut(() => RewardsController(), fenix: true);
       Get.lazyPut(() => HomeController(), fenix: true);

       ///privacy terms faq

    Get.lazyPut(() => AccountSettingController(), fenix: true);
                ///reward controller==========
      Get.lazyPut(() => RewardsController(), fenix: true);
    //   Get.lazyPut(() => WifiSettingsController(), fenix: true);
    //   Get.lazyPut(() => LanguageController(), fenix: true);
    //   Get.put(NavController(), permanent: true);
  }
}
