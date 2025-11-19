

import 'package:crave_crusher/utils/app_colors/app_colors.dart';
import 'package:crave_crusher/view/components/custom_leadin_title_appbar.dart';
import 'package:crave_crusher/view/components/custom_text/custom_text.dart';
import 'package:crave_crusher/view/features/change_password/change_password_screen.dart';

import 'package:crave_crusher/view/features/profile/widgets/custom_profile_menu.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';

class AccountSettingScreen extends StatelessWidget {
  const AccountSettingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:  CustomLeadingTitleAppbar(title: "Account Setting"),

      body: Padding(
        padding: const EdgeInsets.all( 16),
        child: Column(children: [


          CustomProfileMenu(text: 'Change Password', icon: Icon(Icons.lock_outline), onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => ChangePasswordScreen()),
            );
          },),

          Gap(16.h),
          CustomProfileMenu(
            iconColor: AppColors.red,
            textColor: AppColors.red,
            text: 'Delete Account', icon: Icon(Icons.delete_forever_outlined), onTap: () {
            // Navigator.push(
            //   context,
            //   MaterialPageRoute(builder: (context) => MyProfileScreen()),
            // );
          },),


        ],),
      ),


    );
  }
}
