import 'package:crave_crusher/core/routes/app_routes.dart';
import 'package:crave_crusher/utils/app_images/app_images.dart';
import 'package:crave_crusher/view/components/custom_image/custom_image.dart';
import 'package:crave_crusher/view/features/auth/controllers/auth_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {

  @override
  void initState() {
    super.initState();
    _moveToNextScreen();
  }

  Future<void> _moveToNextScreen() async {
    await Future.delayed(const Duration(seconds: 1));

    final auth = Get.find<AuthController>();
    bool isLoggedIn = await auth.isUserLoggedIn();

    if (isLoggedIn) {
      Get.offNamed(AppRoutes.homeScreen);
    } else {
      Get.offNamed(AppRoutes.onBoardingOneScreen);
    }
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: CustomImage(imageSrc: AppImages.appLogo),
      ),
    );
  }
}
