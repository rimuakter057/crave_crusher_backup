import 'package:crave_crusher/helper/images_handler/image_handler.dart';
import 'package:crave_crusher/helper/responsive_helper/responsive_helper.dart';
import 'package:crave_crusher/utils/app_colors/app_colors.dart';
import 'package:crave_crusher/view/components/common_profile/avatar_widget.dart';
import 'package:crave_crusher/view/components/custom_container/custom_container.dart';
import 'package:crave_crusher/view/components/custom_leading_title_appbar.dart';
import 'package:crave_crusher/view/components/custom_loader/custom_loader.dart';
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
    return Scaffold(
      appBar: CustomLeadingTitleAppbar(title: "My Profile"),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Obx(() {
            // loading check
            if (profileController.isLoadingMyProfile.value) {
              return Center(child: CustomLoader());
            }

            final profile = profileController.myProfile.value;

            if (profile == null) {
              return Center(child: Text("No profile data"));
            }

            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Gap(ResponsiveHelper.height(8)),
                Center(
                  child: ProfileAvatarWidget(
                    imagePath: ImageHandler.imagesHandle(
                      profile.profileImage,
                      isProfile: true,
                    ),
                  ),
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
                        builder:
                            (context) => EditProfileScreens(
                              name: profile.fullName,
                              email: profile.email,
                            ),
                      ),
                    );
                  },
                  child: CustomContainer(
                    backgroundColor: AppColors.primary,
                    padding:ResponsiveHelper.padding(4),
                    height:ResponsiveHelper.height(36),
                    width: ResponsiveHelper.width(140),
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
