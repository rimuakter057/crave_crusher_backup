import 'package:crave_crusher/utils/app_colors/app_colors.dart';
import 'package:crave_crusher/view/components/custom_text/custom_text.dart';
import 'package:crave_crusher/view/features/auth/screen/login/login_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SkipButtonWidget extends StatelessWidget {
  const SkipButtonWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: () {
        Get.to(() => LoginScreen());
      },
      child: CustomText(text: "Skip", color: AppColors.primary),
    );
  }
}
