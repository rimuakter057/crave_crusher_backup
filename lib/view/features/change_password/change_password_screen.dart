

import 'package:crave_crusher/utils/app_colors/app_colors.dart';
import 'package:crave_crusher/view/components/custom_container/custom_container.dart';
import 'package:crave_crusher/view/components/custom_leadin_title_appbar.dart';
import 'package:crave_crusher/view/components/custom_text/custom_text.dart';
import 'package:crave_crusher/view/components/input_password_field_widget/input_password_field_widget.dart';
import 'package:crave_crusher/view/features/change_password/controllers/change_password_controller.dart';
import 'package:crave_crusher/view/features/change_password/models/change_password_model.dart';
import 'package:crave_crusher/view/features/profile/profile_screen/profile_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';

class ChangePasswordScreen extends StatelessWidget {
   ChangePasswordScreen({super.key});
        final TextEditingController _oldPassController=TextEditingController();
        final TextEditingController _newPassController=TextEditingController();
        final TextEditingController _confirmedPassController=TextEditingController();
        final GlobalKey<FormState> _key=GlobalKey<FormState>();

        final ChangePasswordController changePasswordController = Get.find<ChangePasswordController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:  CustomLeadingTitleAppbar(title: "Change Password"),

      body: Form(
        key: _key,
        child: Padding(
          padding:  EdgeInsets.symmetric(horizontal:16.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Gap(8.h),

              InputPasswordFieldWidget(
                title: "Old Password",
                controller: _oldPassController,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "Enter old password";
                  }
                  if (value.length < 6) {
                    return "Password must be at least 6 characters";
                  }
                  return null;
                },
              ),
              Gap(16.h),

              InputPasswordFieldWidget(
                title: "New Password",
                controller: _newPassController,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "Enter new password";
                  }
                  if (value.length < 6) {
                    return "Password must be at least 6 characters";
                  }
                  return null;
                },
              ),
              Gap(16.h),

              InputPasswordFieldWidget(
                title: "Confirmed Password",
                controller: _confirmedPassController,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "Enter confirm password";
                  }
                  if (value != _newPassController.text) {
                    return "Passwords do not match";
                  }
                  return null;
                },
              ),

              Gap(16.h),
              ///update button



              GetBuilder<ChangePasswordController>(
                builder: (controller) {
                  return Visibility(
                    visible: controller.inProgress==false,
                    replacement: Center(child: CircularProgressIndicator(),),
                    child: GestureDetector(
                      onTap:_updateButton,
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
                  );
                }
              ),
            ],
          ),
        ),
      ),

    );
  }



  Future<void> _updateButton()async{
    if(_key.currentState!.validate()){

      ChangePasswordModel changePasswordModel =ChangePasswordModel(
          oldPassword: _oldPassController.text,
          newPassword: _newPassController.text,
          confirmNewPassword: _confirmedPassController.text
      );


      final bool isSuccess= await changePasswordController .changePassword(changePasswordModel);
      if(isSuccess){
        Get.off(ProfileScreen());
      }else{

        Get.snackbar("Error", changePasswordController.errorMessage!);

      }
    }




  }




}






