import 'package:crave_crusher/view/components/custom_leadin_title_appbar.dart';
import 'package:crave_crusher/view/features/account_setting/controllers/account_setting_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:get/get.dart';


class PrivacyPolicyScreen extends StatelessWidget {
   PrivacyPolicyScreen({super.key});
  final AccountSettingController privacyController = Get.find<AccountSettingController>();

  @override
  Widget build(BuildContext context) {

    privacyController.getPrivacy();
    return Scaffold(
      appBar:  CustomLeadingTitleAppbar(title: "Privacy Policy"),

      body: SingleChildScrollView(
        padding: EdgeInsets.all(16),
        child:Obx((){
          // loading check
          if (privacyController.isLoadingPrivacy.value) {
            return Center(child: CircularProgressIndicator());
          }

          final privacyData = privacyController.privacy.value;

          if (privacyData == null) {
            return Center(child: Text("Privacy Policy is currently unavailable"));
          }

          return   RichText(
            text: TextSpan(
              style: TextStyle(
                fontSize: 14,
                color: Colors.black87,
                height: 1.5,
              ),
              children: [
                TextSpan(
                  text: privacyData.description,
                  style:GoogleFonts.syne(fontSize: 18.sp, fontWeight: FontWeight.w600,),
                ),

              ],
            ),
          );

        }),
      ),

    );
  }
}
