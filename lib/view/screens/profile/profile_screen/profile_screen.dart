import 'package:crave_crusher/utils/app_colors/app_colors.dart';
import 'package:crave_crusher/utils/app_images/app_images.dart';
import 'package:crave_crusher/view/components/common_profile/avater_widget.dart';
import 'package:crave_crusher/view/components/custom_nav_bar/navbar.dart';
import 'package:crave_crusher/view/components/custom_text/custom_text.dart';
import 'package:crave_crusher/view/screens/account_setting/account_setting_screen.dart';
import 'package:crave_crusher/view/screens/notification/notification_screen.dart';
import 'package:crave_crusher/view/screens/privacy_policy/privacy_policy_screen.dart';
import 'package:crave_crusher/view/screens/profile/my_profile/my_profile_screen.dart';
import 'package:crave_crusher/view/screens/profile/widgets/custom_profile_menu.dart';
import 'package:crave_crusher/view/screens/terms_condition/terms_condition_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final stackHeight = 180.h; // height of the top stack

    return Scaffold(
      bottomNavigationBar: NavBar(currentIndex: 4),
      body: SingleChildScrollView(
        child: Column(
          children: [
            // Top Stack
            SizedBox(
              height: stackHeight,
              child: Stack(
                clipBehavior: Clip.none,
                alignment: Alignment.center,
                children: [
                  // Background Image
                  Container(
                    width: double.infinity,
                    height: stackHeight,
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image: AssetImage(AppImages.profileBackground),
                        fit: BoxFit.cover,
                      ),
                      borderRadius: BorderRadius.circular(20),
                    ),
                  ),

                  // Back button
                  Positioned(
                    left: 16,
                    top: 48,
                    child: Container(
                      width: 50.w,
                      height: 50.h,
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        color: AppColors.white,
                        shape: BoxShape.circle,
                        border: Border.all(color: AppColors.subPrimary),
                      ),
                      child: BackButton(color: AppColors.primary),
                    ),
                  ),

                  // Title text
                  Positioned(
                    top: 50.h,
                    left: 0,
                    right: 0,
                    child: CustomText(
                      text: "Profile",
                      color: AppColors.white,
                    ),
                  ),

                  // Profile image overlapping bottom
                  Positioned(
                    bottom: -50, // overlaps below stack
                    child: ProfileAvatarWidget(
                      imagePath: AppImages.profileManImage,
                      heightA: 100.h,
                      widthA: 100.w,
                    ),
                  ),
                ],
              ),
            ),

          Gap(62.h),

            CustomText(text: "Sheena DuBois",fontWeight: FontWeight.w600,fontSize: 18.sp,),
            Gap(24.h),


            // Scrollable content
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.w),
              child:Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CustomProfileMenu(text: 'My Profile', icon: Icon(Icons.account_circle_outlined), onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => MyProfileScreen()),
                    );
                  },),
                  Gap(8.h),
                  CustomProfileMenu(text: 'Account Setting', icon: Icon(Icons.settings), onTap: () {

                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => AccountSettingScreen()),
                    );

                  },),
                  Gap(8.h),
                  CustomProfileMenu(text: 'Notification', icon: Icon(Icons.notifications_none), onTap: () {

                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => NotificationScreens()),
                    );


                  },),
                  Gap(12.h),
                  CustomText(text: "More",fontWeight: FontWeight.w600,fontSize: 18.sp,),
                  Gap(12.h),



                  CustomProfileMenu(text: 'Terms & Condition', icon: Icon(Icons.description_outlined), onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => TermsConditionScreen()),
                    );


                  },),
                  Gap(8.h),
                  CustomProfileMenu(text: 'Privacy policy', icon: Icon(Icons.privacy_tip_outlined), onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => PrivacyPolicyScreen()),
                    );


                  },),
                  Gap(8.h),
                  CustomProfileMenu(text: 'Help/Support', icon: Icon(Icons.help_outline), onTap: () {  },),
                  Gap(12.h),
                  CustomProfileMenu(text: 'Log Out', icon: Icon(Icons.logout_outlined), onTap: () {  },),
                ],
              )

            ),
          ],
        ),
      ),
    );
  }
}


