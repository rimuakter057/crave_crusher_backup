import 'package:crave_crusher/utils/app_colors/app_colors.dart';
import 'package:crave_crusher/utils/app_images/app_images.dart';
import 'package:crave_crusher/view/components/common_profile/avater_widget.dart';
import 'package:crave_crusher/view/components/custom_nav_bar/navbar.dart';
import 'package:crave_crusher/view/components/custom_text/custom_text.dart';
import 'package:crave_crusher/view/features/community/screens/community_profile_screen/widgets/profile_status_container.dart';
import 'package:crave_crusher/view/features/community/widgets/common%20comunity%20widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';

class CommunityProfileScreen extends StatelessWidget {
  const CommunityProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {

    return Scaffold(bottomNavigationBar: NavBar(currentIndex: 2),
      // appBar: ,
     appBar:  AppBar(
        surfaceTintColor: AppColors.backgroundColor,
        backgroundColor:AppColors.backgroundColor,
        leading: Center(
          child: Container(
            width: 50.w,
            height: 50.h,
            alignment: Alignment.center,
            decoration: BoxDecoration(
              color: AppColors.subPrimary.withOpacity(.3),
              shape: BoxShape.circle,
              border: Border.all(color: AppColors.subPrimary),
            ),
            child: BackButton(color: AppColors.primary),
          ),
        ),
        centerTitle: true,
        title: CustomText(
          text: "Community",
          fontSize: 18.sp,
          fontWeight: FontWeight.w500,
        ),
      ),


      body: SingleChildScrollView(
        child: Padding(
          padding:  EdgeInsets.symmetric(horizontal: 16.w),
          child: Column(children: [
            ///profile image
            ProfileAvatarWidget(
              imagePath: AppImages.profileManImage,
            heightA: 100.h,
              widthA: 100.w,
              borderColor: Colors.blue.shade100,
            ),
            Gap(16.h),
            CustomText(text: "@habitbreaker"),
            Gap(24.h),
            /// profile details section
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                ProfileStatusContainer(number: 120, title: 'Posts',),
                ProfileStatusContainer(number: 879, title: 'Reaction',),
                ProfileStatusContainer(number: 3, title: 'badge',),
              ],
            ),
             
            Gap(24.h),
            ///common community widget
            CommonCommunityWidget(),
            Gap(24.h),
            CommonCommunityWidget(),

          ],),
        ),
      ),

    );
  }
}




