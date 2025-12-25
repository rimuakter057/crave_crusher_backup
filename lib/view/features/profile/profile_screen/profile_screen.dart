import 'package:crave_crusher/core/routes/app_routes.dart';
import 'package:crave_crusher/helper/imges_handler/image_handler.dart';
import 'package:crave_crusher/utils/app_colors/app_colors.dart';
import 'package:crave_crusher/utils/app_const/app_const.dart';
import 'package:crave_crusher/utils/app_icons/app_icons.dart';
import 'package:crave_crusher/utils/app_images/app_images.dart';
import 'package:crave_crusher/view/components/common_profile/avatar_widget.dart';
import 'package:crave_crusher/view/components/custom_nav_bar/navbar.dart';
import 'package:crave_crusher/view/components/custom_text/custom_text.dart';
import 'package:crave_crusher/view/components/leading_back/custom_leading_back_icon.dart';
import 'package:crave_crusher/view/features/account_setting/account_setting_screen.dart';
import 'package:crave_crusher/view/features/auth/controllers/auth_controller.dart';
import 'package:crave_crusher/view/features/auth/screen/login/login_screen.dart';
import 'package:crave_crusher/view/features/help_support/help_support_screen.dart';
import 'package:crave_crusher/view/features/notification/notification_screen.dart';
import 'package:crave_crusher/view/features/privacy_policy/privacy_policy_screen.dart';
import 'package:crave_crusher/view/features/profile/my_profile/my_profile_screen.dart';
import 'package:crave_crusher/view/features/profile/widgets/custom_profile_menu.dart';
import 'package:crave_crusher/view/features/terms_condition/terms_condition_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';

import '../controllers/profile_controller.dart';
class ProfileScreen extends StatelessWidget {
   ProfileScreen({super.key});
  final ProfileController profileController = Get.find<ProfileController>();
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
                      child:        LeadingBackIconWidget(),
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
                      fontSize: 18.sp,
                    ),
                  ),

                  // Profile image (SAFE)
                  Positioned(
                    bottom: -50,
                    child: Obx(() {
                      final profile = profileController.myProfile.value;

                      return ProfileAvatarWidget(
                        imagePath: ImageHandler.imagesHandle(
                          profile?.profileImage,
                          isProfile: true,
                        ),

                      );
                    }),
                  ),
                ],
              ),
            ),

            Gap(62.h),

            /// Profile Name (SAFE)
            Obx(() {
              final profile = profileController.myProfile.value;

              return CustomText(
                text: profile?.fullName ?? "Empty Name",
                fontWeight: FontWeight.w600,
                fontSize: 18.sp,
              );
            }),



            Gap(24.h),


            // Scrollable content
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.w),
              child:Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CustomProfileMenu(text: 'My Profile', icon: AppIcons.myProfile, onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => MyProfileScreen()),
                    );
                  },),
                  Gap(8.h),
                  CustomProfileMenu(text: 'Account Setting', icon: AppIcons.accountSetting, onTap: () {

                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => AccountSettingScreen()),
                    );

                  },),
                  Gap(8.h),
                  CustomProfileMenu(text: 'Notification', icon: AppIcons.notification, onTap: () {

                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => NotificationScreen()),
                    );


                  },),
                  Gap(12.h),
                  CustomText(text: "More",fontSize: 18.sp,fontWeight: FontWeight.w500,),
                  Gap(12.h),



                  CustomProfileMenu(text: 'Terms & Condition', icon: AppIcons.terms, onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => TermsConditionScreen()),
                    );


                  },),
                  Gap(8.h),
                  CustomProfileMenu(text: 'Privacy policy', icon: AppIcons.privacy,  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => PrivacyPolicyScreen()),
                    );


                  },),
                  Gap(8.h),
                  CustomProfileMenu(text: 'Help/Support', icon: AppIcons.help,  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => HelpSupportScreen()),
                    );
                  },),
                  Gap(12.h),
                  CustomProfileMenu(text: 'Log Out', icon: AppIcons.logout,
                      onTap: () async {
                        await Get.find<AuthController>().clearUserData();
                        Get.offAllNamed(AppRoutes.loginScreen);
                      }

                  ),
                ],
              )

            ),
          ],
        ),
      ),
    );
  }
}


