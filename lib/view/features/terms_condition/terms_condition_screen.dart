import 'package:crave_crusher/view/components/common_empty/common_empty_widget.dart';
import 'package:crave_crusher/view/components/custom_leading_title_appbar.dart';
import 'package:crave_crusher/view/components/custom_loader/custom_loader.dart';
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import '../account_setting/controllers/account_setting_controller.dart';

class TermsConditionScreen extends StatelessWidget {
  TermsConditionScreen({super.key});

  final AccountSettingController termsConditionController =
      AccountSettingController();

  @override
  Widget build(BuildContext context) {
    termsConditionController.getTerms();
    return Scaffold(
      appBar: CustomLeadingTitleAppbar(title: "Terms & Condition"),

      body: SingleChildScrollView(
        padding: EdgeInsets.all(16),
        child: Obx(() {
          if (termsConditionController.isLoadingTerms.value) {
            return Center(child: CustomLoader());
          }

          final termsData = termsConditionController.termsList.value;

          if (termsData == null) {
            return EmptyWidget(
              title: "Terms & Conditions are currently unavailable",
            );
          }
          return
            Html(
              data: termsData.description,
              style: {
                "body": Style(
                  fontSize: FontSize(18.sp),
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


