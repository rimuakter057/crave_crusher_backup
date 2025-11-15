import 'package:crave_crusher/utils/app_colors/app_colors.dart';
import 'package:crave_crusher/utils/app_icons/app_icons.dart';
import 'package:crave_crusher/utils/app_images/app_images.dart';
import 'package:crave_crusher/view/components/common_profile/common_profile_widget.dart';
import 'package:crave_crusher/view/components/custom_app_bar/custom_app_bar.dart';
import 'package:crave_crusher/view/components/custom_image/custom_image.dart';
import 'package:crave_crusher/view/components/custom_nav_bar/navbar.dart';
import 'package:crave_crusher/view/components/custom_text/custom_text.dart';
import 'package:crave_crusher/view/screens/battle/widget/battle_tab_selector.dart';
import 'package:crave_crusher/view/screens/community/widgets/common%20comunity%20widget.dart';
import 'package:crave_crusher/view/screens/community/widgets/community_tab_selector.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';

class CommunityImageShowScreen extends StatelessWidget {
  const CommunityImageShowScreen({super.key});

  @override
  Widget build(BuildContext context) {

    return Scaffold(bottomNavigationBar: NavBar(currentIndex: 2),
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


