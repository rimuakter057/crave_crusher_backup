import 'package:crave_crusher/core/routes/app_routes.dart';
import 'package:crave_crusher/utils/app_images/app_images.dart';
import 'package:crave_crusher/view/components/custom_image/custom_image.dart';
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
    // TO DO: implement initState

    Future.delayed(const Duration(seconds: 2), () {
      Get.offNamed(AppRoutes.homeScreen);
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(child: CustomImage(imageSrc: AppImages.appLogo)),
    );
  }
}
