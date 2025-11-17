// ignore_for_file: deprecated_member_use

import 'package:crave_crusher/core/dependency/dependency_injection.dart';
import 'package:crave_crusher/core/routes/app_routes.dart';
import 'package:crave_crusher/utils/app_colors/app_colors.dart';
import 'package:crave_crusher/view/components/device_utils/device_utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:device_preview_plus/device_preview_plus.dart'; // ✅ add this

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  DeviceUtils.lockDevicePortrait();

  DependencyInjection di = DependencyInjection();
  di.dependencies();

  runApp(
    DevicePreview(
      enabled: true, // ✅ set false in production
      builder: (context) => const MyApp(),
    ),
  );
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
          title: "InviteeMe",
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
