import 'package:crave_crusher/utils/app_colors/app_colors.dart';
import 'package:crave_crusher/utils/app_icons/app_icons.dart';
import 'package:crave_crusher/utils/app_images/app_images.dart';
import 'package:crave_crusher/view/components/custom_app_bar/custom_app_bar.dart';
import 'package:crave_crusher/view/components/custom_nav_bar/navbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CommunityImageShowScreen extends StatelessWidget {
  const CommunityImageShowScreen({super.key});

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      // appBar: ,
      appBar: CustomAppBar(
        title: 'Media ',
       leading: IconButton(onPressed: (){
         Navigator.pop(context);

       }, icon: Icon(Icons.close,color: AppColors.primary,)),
        actionIcon: AppIcons.download,
        onActionPressed: () {
          //   Get.toNamed(AppRoutes.createBattleScreen);
        },
      ),
      body: Center(
        child:
        Container(
          height: 300.h,
          width: double.infinity,
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage(AppImages.imageOne),
              fit: BoxFit.cover,      // optional
            ),
          ),
        ),


      ),

    );
  }
}


