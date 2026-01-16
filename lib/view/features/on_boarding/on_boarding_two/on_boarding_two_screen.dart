import 'package:crave_crusher/utils/app_images/app_images.dart';
import 'package:crave_crusher/view/features/on_boarding/on_boarding_three/on_boarding_three_screen.dart';
import 'package:crave_crusher/view/features/on_boarding/widgets/on_boarding_body_widget.dart';
import 'package:crave_crusher/view/features/on_boarding/widgets/skip_button_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class OnBoardingTwoScreen extends StatefulWidget {
  const OnBoardingTwoScreen({super.key});

  @override
  State<OnBoardingTwoScreen> createState() => _OnBoardingTwoScreenState();
}

class _OnBoardingTwoScreenState extends State<OnBoardingTwoScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 8.0),
            child: SkipButtonWidget(),
          ),
        ],
      ),
      body: OnBoardingBodyWidget(
        imagePath: AppImages.onBoardingTwo,
        title: "Track Your Wins",
        subTitle:
            'See your streak grow, money saved, and milestones achieved as you progress.',
        onTap: () {
          Get.to(() => OnBoardingThreeScreen());
        },
      ),
    );
  }
}
