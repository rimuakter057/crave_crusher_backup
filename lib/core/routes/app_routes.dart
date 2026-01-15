import 'package:crave_crusher/view/features/auth/screen/login/login_screen.dart';
import 'package:crave_crusher/view/features/battle/inner_screen/create_battle_screen.dart';
import 'package:crave_crusher/view/features/community/screens/post/post_screen.dart';
import 'package:crave_crusher/view/features/home/home_screen.dart';
import 'package:crave_crusher/view/features/on_boarding/on_boarding_one/on_boarding_one_screen.dart';
import 'package:crave_crusher/view/features/splash/splash_screen.dart';
import 'package:get/get.dart';

///=========================App Routes=========================

class AppRoutes {
  static const String splashScreen = "/SplashScreen";
  static const String loginScreen = "/LoginScreen";
  static const String homeScreen = "/HomeScreen";

  static const String battleLogScreen = "/BattleLogScreen";
  static const String createBattleScreen = "/CreateBattleScreen";
  static const String onBoardingOneScreen = "/OnBoardingOne";
  static const String emptyHome = "/empty-home";
  static const String updateBattle = "/update-battle";
  static const String postScreen = "/post-screen";

  static List<GetPage> routes = [
    ///===========================Authentication==========================
    GetPage(name: splashScreen, page: () => SplashScreen()),
    GetPage(name: onBoardingOneScreen, page: ()=>OnBoardingOneScreen()),
    GetPage(name: loginScreen, page: () => LoginScreen()),
    GetPage(name: homeScreen, page: () => HomeScreen()),

    GetPage(name: createBattleScreen, page: () => CreateBattleScreen()),
    //GetPage(name: emptyHome, page: () => EmptyHomeScreen()),


    GetPage(name: postScreen, page: () => PostScreen()),
  ];
}
