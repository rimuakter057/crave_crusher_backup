import 'package:crave_crusher/utils/app_colors/app_colors.dart';
import 'package:crave_crusher/utils/app_const/app_const.dart';
import 'package:crave_crusher/utils/app_images/app_images.dart';
import 'package:crave_crusher/view/components/common_profile/avater_widget.dart';
import 'package:crave_crusher/view/components/custom_container/custom_container.dart';
import 'package:crave_crusher/view/components/custom_leadin_title_appbar.dart';
import 'package:crave_crusher/view/components/custom_text/custom_text.dart';
import 'package:crave_crusher/view/features/profile/controllers/profile_controller.dart';
import 'package:crave_crusher/view/features/profile/edit_profile/edit_profile_screens.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'widgets/custom_profile_input_field.dart';

class MyProfileScreen extends StatelessWidget {
  MyProfileScreen({super.key});
  final ProfileController profileController = Get.find<ProfileController>();

  @override
  Widget build(BuildContext context) {
    profileController.fetchMyProfile();

    return Scaffold(
      appBar: CustomLeadingTitleAppbar(title: "My Profile"),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Obx(() {
            // loading check
            if (profileController.isLoadingMyProfile.value) {
              return Center(child: CircularProgressIndicator());
            }

            final profile = profileController.myProfile.value;

            if (profile == null) {
              return Center(child: Text("No profile data"));
            }

            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Gap(8.h),
                Center(
                  child: ProfileAvatarWidget(imagePath: profile.profileImage??''),
                ),
                Gap(24.h),
                // Name
                CustomProfileInputField(title: 'Name', text: profile.fullName),
                Gap(16.h),
                // Email
                CustomProfileInputField(title: 'Email', text: profile.email),
                Gap(16.h),
                GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => EditProfileScreens(name: profile.fullName, email:  profile.email,),
                      ),
                    );
                  },
                  child: CustomContainer(
                    backgroundColor: AppColors.primary,
                    padding: 4,
                    height: 36.h,
                    width: 140.w,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        CustomText(
                          text: "Edit Profile",
                          color: AppColors.white,
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            );
          }),
        ),
      ),
    );
  }
}
