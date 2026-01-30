import 'package:crave_crusher/utils/app_images/app_images.dart';
import 'package:crave_crusher/view/features/on_boarding/on_boarding_two/on_boarding_two_screen.dart';
import 'package:crave_crusher/view/features/on_boarding/widgets/on_boarding_body_widget.dart';
import 'package:crave_crusher/view/features/on_boarding/widgets/skip_button_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class OnBoardingOneScreen extends StatefulWidget {
  const OnBoardingOneScreen({super.key});

  @override
  State<OnBoardingOneScreen> createState() => _OnBoardingOneScreenState();
}

class _OnBoardingOneScreenState extends State<OnBoardingOneScreen> {
  @override
  Widget build(BuildContext context) {
    // Get screen dimensions
    final screenWidth = MediaQuery.of(context).size.width;
    final isTablet = screenWidth > 600;

    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        actions: [
          Padding(
            padding: EdgeInsets.only(right: isTablet ? 16.0 : 8.0),
            child: SkipButtonWidget(),
          ),
        ],
      ),
      body: OnBoardingBodyWidget(
        imagePath: AppImages.onBoardingOne,
        title: "Face Your Monster",
        subTitle:
            'Spot your addictions and get ready to battle them — one step at a time.',
        isTablet: isTablet,
        onTap: () {
          Get.to(() => const OnBoardingTwoScreen());
        },
      ),
    );
  }
}

// import 'package:crave_crusher/utils/app_images/app_images.dart';
// import 'package:crave_crusher/view/features/on_boarding/on_boarding_two/on_boarding_two_screen.dart';
// import 'package:crave_crusher/view/features/on_boarding/widgets/on_boarding_body_widget.dart';
// import 'package:crave_crusher/view/features/on_boarding/widgets/skip_button_widget.dart';
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';

// class OnBoardingOneScreen extends StatefulWidget {
//   const OnBoardingOneScreen({super.key});

//   @override
//   State<OnBoardingOneScreen> createState() => _OnBoardingOneScreenState();
// }

// class _OnBoardingOneScreenState extends State<OnBoardingOneScreen> {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         automaticallyImplyLeading: false,
//         actions: [
//           Padding(
//             padding: const EdgeInsets.only(right: 8.0),
//             child: SkipButtonWidget(),
//           ),
//         ],
//       ),
//       body: OnBoardingBodyWidget(
//         imagePath: AppImages.onBoardingOne,
//         title: "Face Your Monster",
//         subTitle:
//             'Spot your addictions and get ready to battle them — one step at a time.',
//         onTap: () {
//           Get.to(() => OnBoardingTwoScreen());
//         },
//       ),
//     );
//   }
// }
