import 'package:crave_crusher/view/screen/auth/screen/login_screen.dart';
import 'package:crave_crusher/view/screen/home/home_screen.dart';
import 'package:crave_crusher/view/screen/splash/splash_screen.dart';
import 'package:get/get.dart';

///=========================App Routes=========================

class AppRoutes {
  static const String splashScreen = "/SplashScreen";
  static const String loginScreen = "/LoginScreen";
  static const String homeScreen = "/HomeScreen";

  static List<GetPage> routes = [
    ///===========================Authentication==========================
    GetPage(name: splashScreen, page: () => SplashScreen()),
    GetPage(name: loginScreen, page: () => LoginScreen()),
    GetPage(name: homeScreen, page: () => HomeScreen()),
  ];
}
