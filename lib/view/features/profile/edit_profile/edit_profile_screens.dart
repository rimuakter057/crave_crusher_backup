

import 'package:crave_crusher/utils/app_colors/app_colors.dart';
import 'package:crave_crusher/view/components/common_profile/avater_widget.dart';
import 'package:crave_crusher/view/components/custom_container/custom_container.dart';
import 'package:crave_crusher/view/components/custom_leadin_title_appbar.dart';
import 'package:crave_crusher/view/components/custom_text/custom_text.dart';
import 'package:crave_crusher/view/components/input_field_with_title/input_field_with_title.dart';
import 'package:crave_crusher/view/features/profile/profile_screen/profile_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gap/gap.dart';
import 'package:image_picker/image_picker.dart';

import '../../../../utils/app_const/app_const.dart' show AppConstants;


class EditProfileScreens extends StatelessWidget {
  const EditProfileScreens({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomLeadingTitleAppbar(title: "Edit Profile"),

      body: Padding(
        padding:  EdgeInsets.symmetric(horizontal:16.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Gap(8.h),
            Center(
              child:ProfileAvatarWidget(
              imagePath: AppConstants.unknown,
              heightA: 100.h,
              widthA: 100.w,
              enableEdit: true,
              onEdit: () async {
                // Example: pick image from gallery
                final picker = ImagePicker();
                final pickedFile = await picker.pickImage(source: ImageSource.gallery);
                if (pickedFile != null) {
                  print("Selected image path: ${pickedFile.path}");
                  // setState / controller update করুন
                }
              },
            ),
            ),



            Gap(16.h),

            InputFieldWithTitleWidget(title:"Full Name", hintText: "e.g. Sheena DuBois ",),
            Gap(16.h),
            InputFieldWithTitleWidget(title:"Email Address", hintText: "e.g. kristin.SheenaDuBois@example.com",
            readOnly: true,
            ),
            Gap(16.h),
            ///update button
            GestureDetector(
              onTap: (){
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => ProfileScreen()),
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

                    CustomText(text: "Update", color: AppColors.white),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),

    );
  }
}


