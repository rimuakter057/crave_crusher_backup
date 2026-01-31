import 'package:crave_crusher/view/components/common_empty/common_empty_widget.dart';
import 'package:crave_crusher/view/components/custom_leading_title_appbar.dart';
import 'package:crave_crusher/view/components/custom_loader/custom_loader.dart';
import 'package:crave_crusher/view/features/account_setting/controllers/account_setting_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:get/get.dart';

class PrivacyPolicyScreen extends StatelessWidget {
  PrivacyPolicyScreen({super.key});
  final AccountSettingController privacyController =
      Get.find<AccountSettingController>();

  @override
  Widget build(BuildContext context) {
    privacyController.getPrivacy();
    return Scaffold(
      appBar: CustomLeadingTitleAppbar(title: "Privacy Policy"),

      body: SingleChildScrollView(
        padding: EdgeInsets.all(16),
        child: Obx(() {
          // loading check
          if (privacyController.isLoadingPrivacy.value) {
            return Center(child: CustomLoader());
          }

          final privacyData = privacyController.privacy.value;

          if (privacyData == null) {
            return EmptyWidget(
              title: "Privacy Policy is currently unavailable",
            );
          }

          return Html(
            data: privacyData.description,
            style: {
              "body": Style(
                // fontSize: ResponsiveHelper.fontSize(18.w),
                fontWeight: FontWeight.w600,
                color: Colors.black,
              ),
            },
          );
        }),
      ),
    );
  }
}
