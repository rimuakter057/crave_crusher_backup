import 'package:crave_crusher/utils/app_colors/app_colors.dart';
import 'package:crave_crusher/view/components/custom_button/custom_button.dart';
import 'package:crave_crusher/view/components/custom_leadin_title_appbar.dart';
import 'package:crave_crusher/view/components/custom_text/custom_text.dart';
import 'package:crave_crusher/view/features/change_password/change_password_screen.dart';
import 'package:crave_crusher/view/features/profile/widgets/custom_profile_menu.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'controllers/account_setting_controller.dart';

class AccountSettingScreen extends StatelessWidget {
  AccountSettingScreen({super.key});
  final AccountSettingController controller =
      Get.find<AccountSettingController>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomLeadingTitleAppbar(title: "Account Setting"),

      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            CustomProfileMenu(
              text: 'Change Password',
              icon: Icon(Icons.lock_outline),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => ChangePasswordScreen(),
                  ),
                );
              },
            ),

            Gap(16.h),
            Obx(() {
              return CustomProfileMenu(
                iconColor: AppColors.red,
                textColor: AppColors.red,
                text: 'Delete Account',
                icon: Icon(Icons.delete_forever_outlined),
                onTap:
                    controller.isLoadingDeleteAccount.value
                        ? () {}
                        : () {
                          () async {
                            bool? confirm = await Get.dialog<bool>(
                              AlertDialog(
                                backgroundColor: AppColors.white,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(12),
                                ),
                                title: Text(
                                  "Confirm",
                                  style: TextStyle(fontWeight: FontWeight.bold),
                                ),
                                content: CustomText(
                                  maxLines: 2,

                                  text:
                                      "Are you sure you want to delete your account?",
                                  textAlign: TextAlign.center,
                                ),

                                actionsAlignment: MainAxisAlignment.center,
                                actions: [
                                  CustomButton(
                                    onTap: () {
                                      Get.back(result: false);
                                    },
                                    title: "No",
                                    height: 30.h,
                                    width: 100.w,
                                  ),
                                  CustomButton(
                                    onTap: () {
                                      Get.back(result: true);
                                    },
                                    title: "Yes",
                                    height: 30.h,
                                    width: 100.w,
                                  ),
                                ],
                              ),
                            );

                            if (confirm == true) {
                              await controller.deleteAccount();
                            }
                          }();
                        },
              );
            }),
          ],
        ),
      ),
    );
  }
}
