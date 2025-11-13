import 'package:crave_crusher/utils/app_colors/app_colors.dart';
import 'package:crave_crusher/utils/app_images/app_images.dart';
import 'package:crave_crusher/view/components/common_profile/common_profile_widget.dart';
import 'package:crave_crusher/view/components/custom_app_bar/custom_app_bar.dart';
import 'package:crave_crusher/view/components/custom_nav_bar/navbar.dart';
import 'package:crave_crusher/view/screens/battle/widget/battle_tab_selector.dart';
import 'package:crave_crusher/view/screens/community/widgets/community_tab_selector.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CommunityScreen extends StatelessWidget {
  const CommunityScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(bottomNavigationBar: NavBar(currentIndex: 2),
      // appBar: ,
      appBar: CustomAppBar(
        title: 'Community',
        onActionPressed: () {
       //   Get.toNamed(AppRoutes.createBattleScreen);
        },
      ),
      body: Padding(
        padding:  EdgeInsets.all(16.w),
        child: Column(children: [

          SizedBox(height: 16.h),
          /// tab section
          CommunityTabSelector(),
          SizedBox(height: 16.h),
          ///common community widget
          Container(
            padding: EdgeInsets.all(10.w),
            width: double.infinity,
            alignment: Alignment.center,
            decoration: BoxDecoration(
              color: AppColors.white,
              border: Border.all(color: AppColors.subPrimary),
              borderRadius: BorderRadius.all(Radius.circular(8))
            ),
            child:Column(
              children: [
                CommonProfileWidget(title: "@Sheena s", subTitle: "27 Aug 2020 06:20 AM", image: AppImages.profileManImage),
              ],
            )
          ),
          


        ],),
      ),

    );
  }
}
