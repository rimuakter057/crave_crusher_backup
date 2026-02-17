import 'package:crave_crusher/utils/app_colors/app_colors.dart';
import 'package:crave_crusher/utils/app_icons/app_icons.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';

class TestingScreen extends StatelessWidget {
  const TestingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Testing Screen'),
      ),

      backgroundColor:AppColors.black ,


      body: Center(
        child: Lottie.asset(
          AppIcons.monsterBattle,
          repeat: false,
          onLoaded: (composition) async {
            await Future.delayed(
              composition.duration,
            );
            Get.back();
          },
        ),
      ),

    );
  }
}
