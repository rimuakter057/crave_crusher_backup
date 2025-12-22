// ignore_for_file: deprecated_member_use

import 'package:crave_crusher/core/dependency/dependency_injection.dart';
import 'package:crave_crusher/core/routes/app_routes.dart';
import 'package:crave_crusher/utils/app_colors/app_colors.dart';
import 'package:crave_crusher/view/components/device_utils/device_utils.dart';
import 'package:crave_crusher/view/features/auth/controllers/auth_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:device_preview_plus/device_preview_plus.dart';
import 'package:get/get_core/src/get_main.dart' as getx;


import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';

// ...



Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
await Firebase.initializeApp(
options: DefaultFirebaseOptions.currentPlatform,
);
  DeviceUtils.lockDevicePortrait();

  DependencyInjection di = DependencyInjection();
  di.dependencies();

  /// Load Token Immediately (VERY IMPORTANT)
  final auth = getx.Get.find<AuthController>();
  await auth.getUserData();
  runApp(DevicePreview(enabled: false, builder: (context) => const MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(390, 870),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (context, child) {
        return GetMaterialApp(
          theme: CustomTheme.lightTheme,
          debugShowCheckedModeBanner: false,
          defaultTransition: Transition.fadeIn,
          transitionDuration: const Duration(milliseconds: 200),
          navigatorKey: Get.key,
          initialRoute: AppRoutes.splashScreen,
          getPages: AppRoutes.routes,
          useInheritedMediaQuery: true,
          locale: DevicePreview.locale(context),
          builder: DevicePreview.appBuilder,
        );
      },
    );
  }
}

class CustomTheme {
  static ThemeData get lightTheme {
    return ThemeData(
      scaffoldBackgroundColor: AppColors.backgroundColor,
      appBarTheme: AppBarTheme(
        surfaceTintColor: AppColors.backgroundColor,
        toolbarHeight: 65,
        elevation: 0,
        centerTitle: true,
        backgroundColor: AppColors.backgroundColor,
        iconTheme: const IconThemeData(color: Colors.black),
        systemOverlayStyle: SystemUiOverlayStyle(
          statusBarColor: AppColors.primary,
          statusBarIconBrightness: Brightness.dark, // Android
          statusBarBrightness: Brightness.light, // iOS
        ),
      ),
    );
  }

  static ThemeData get darkTheme => ThemeData.dark();
}
