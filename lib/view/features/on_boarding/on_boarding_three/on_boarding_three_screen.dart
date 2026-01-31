import 'package:crave_crusher/helper/responsive_helper/responsive_helper.dart';
import 'package:crave_crusher/utils/app_images/app_images.dart';
import 'package:crave_crusher/view/features/auth/screen/login/login_screen.dart';
import 'package:crave_crusher/view/features/on_boarding/widgets/on_boarding_body_widget.dart';
import 'package:crave_crusher/view/features/on_boarding/widgets/skip_button_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class OnBoardingThreeScreen extends StatefulWidget {
  const OnBoardingThreeScreen({super.key});

  @override
  State<OnBoardingThreeScreen> createState() => _OnBoardingThreeScreenState();
}

class _OnBoardingThreeScreenState extends State<OnBoardingThreeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        actions: [
          Padding(
            padding:  EdgeInsets.only(right:ResponsiveHelper.width(8),),
            child: SkipButtonWidget(),
          ),
        ],
      ),
      body: OnBoardingBodyWidget(
        imagePath: AppImages.onBoardingThree,
        title: "Stay Strong Together",
        subTitle:
            'Get daily tips, earn rewards, and find strength in your support community.',
        onTap: () {
          Get.to(() => LoginScreen());
        },
      ),
    );
  }
}
