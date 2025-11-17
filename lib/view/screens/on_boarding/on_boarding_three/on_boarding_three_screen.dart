import 'package:crave_crusher/utils/app_colors/app_colors.dart';
import 'package:crave_crusher/utils/app_images/app_images.dart';
import 'package:crave_crusher/view/components/custom_button/custom_button.dart';
import 'package:crave_crusher/view/components/custom_container/custom_container.dart';
import 'package:crave_crusher/view/components/custom_image/custom_image.dart';
import 'package:crave_crusher/view/components/custom_text/custom_text.dart';
import 'package:crave_crusher/view/screens/home/home_screen.dart';
import 'package:crave_crusher/view/screens/on_boarding/widgets/on_boarding_body_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';

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
            padding: const EdgeInsets.only(right: 8.0),
            child: TextButton(
              onPressed: () {},
              child: CustomText(text: "Skip", color: AppColors.primary),
            ),
          ),
        ],
      ),
      body: OnBoardingBodyWidget(
        imagePath: AppImages.onBoardingThree,
        title: "Stay Strong Together",
        subTitle:
            'Get daily tips, earn rewards, and find strength in your support community.',
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => HomeScreen()),
          );
        },
      ),
    );
  }
}
