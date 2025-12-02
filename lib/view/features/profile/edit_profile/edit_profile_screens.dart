import 'package:crave_crusher/helper/imges_handler/image_handler.dart';
import 'package:crave_crusher/utils/app_colors/app_colors.dart';
import 'package:crave_crusher/view/components/common_profile/avater_widget.dart';
import 'package:crave_crusher/view/components/custom_container/custom_container.dart';
import 'package:crave_crusher/view/components/custom_leadin_title_appbar.dart';
import 'package:crave_crusher/view/components/custom_text/custom_text.dart';
import 'package:crave_crusher/view/components/input_field_with_title/input_field_with_title.dart';
import 'package:crave_crusher/view/features/profile/controllers/profile_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:gap/gap.dart';

class EditProfileScreens extends StatefulWidget {
  const EditProfileScreens({super.key, required this.name, required this.email});

  final String name;
  final String email;

  @override
  State<EditProfileScreens> createState() => _EditProfileScreensState();
}

class _EditProfileScreensState extends State<EditProfileScreens> {
  final ProfileController controller = Get.find<ProfileController>();

  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();

  @override
  void initState() {
    super.initState();

    nameController.text = widget.name;
    emailController.text = widget.email;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomLeadingTitleAppbar(title: "Edit Profile"),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 16.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Gap(8.h),

            /// Profile Image Picker
            Center(
              child: Obx(
                    () => ProfileAvatarWidget(
                  imagePath: controller.profileImagePath.value,
                  heightA: 100.h,
                  widthA: 100.w,
                  enableEdit: true,
                  onEdit: controller.pickImageFromGallery,
                ),
              ),
            ),

            Gap(16.h),

            /// Full Name Field
            InputFieldWithTitleWidget(
              title: "Full Name",
              hintText: widget.name,
              controller: nameController,
            ),

            Gap(16.h),

            /// Email Field (Read-only)
            InputFieldWithTitleWidget(
              title: "Email Address",
              hintText: widget.email,
              controller: emailController,
              readOnly: true,
            ),

            Gap(24.h),

            /// Update Button
            GestureDetector(
              onTap: () {
                /// Call update API
                controller.updatePost(nameController.text);
              },
              child: CustomContainer(
                backgroundColor: AppColors.primary,
                padding: 4,
                height: 36.h,
                width: 140.w,
                child: Center(
                  child: CustomText(
                    text: "Update",
                    color: AppColors.white,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
