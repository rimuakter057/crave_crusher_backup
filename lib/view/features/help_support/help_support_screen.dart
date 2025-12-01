
import 'package:crave_crusher/utils/app_colors/app_colors.dart';
import 'package:crave_crusher/utils/app_const/app_const.dart';
import 'package:crave_crusher/utils/app_icons/app_icons.dart';

import 'package:crave_crusher/view/components/custom_container/custom_container.dart';
import 'package:crave_crusher/view/components/custom_image/custom_image.dart';
import 'package:crave_crusher/view/components/custom_leadin_title_appbar.dart';

import 'package:crave_crusher/view/components/custom_text/custom_text.dart';
import 'package:crave_crusher/view/features/help_support/controllers/help_support_controller.dart';


import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';

class HelpSupportScreen extends StatelessWidget {
  HelpSupportScreen({super.key});

  final HelpController helpController = Get.find<HelpController>();
  @override
  Widget build(BuildContext context) {
    // Fetch FAQs once
    helpController.getHelp();

    return Scaffold(
      appBar: CustomLeadingTitleAppbar(title: "Help/Support"),
      body: SingleChildScrollView(
        padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.h),
        child: Obx(() {
          if (helpController.helpStatus.value == Status.loading) {
            return Center(child: CircularProgressIndicator());
          }

          if (helpController.helpStatus.value == Status.error) {
            return Center(child: Text("Failed to load FAQs"));
          }

          final helpData = helpController.helpList;

          if (helpData.isEmpty) {
            return Center(child: Text("No FAQs available"));
          }

          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Loop through API FAQs
              ...helpData.map((faq) => Column(
                children: [
                  CustomContainer(
                    backgroundColor: Color(0xFFEEF2FF),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Expanded(
                              child: CustomText(
                                text: faq.question ?? "",
                                fontSize: 14,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                            Icon(
                              Icons.keyboard_arrow_down_outlined,
                              color: AppColors.primary,
                              size: 28,
                            )
                          ],
                        ),
                        Divider(
                          color: Colors.grey,
                          thickness: 1.2,
                        ),
                        CustomText(
                          text: faq.answer ?? "",
                          fontWeight: FontWeight.w400,
                          fontSize: 14,
                          color: Color(0xFFA1A1AA),
                          maxLines: 8,
                          textAlign: TextAlign.start,
                        ),
                      ],
                    ),
                  ),
                  Gap(12.h),
                ],
              )),

              /// Need More Help section (UI same as before)
              CustomText(
                text: "Need More Help?",
                fontWeight: FontWeight.w600,
                fontSize: 16,
              ),
              Gap(8.h),
              ListTile(
                tileColor: Color(0xFFEEF2FF),
                leading: CustomImage(imageSrc: AppIcons.music),
                title: CustomText(
                  textAlign: TextAlign.start,
                  text: "Mail Us [support@CraveCrusher.com]",
                  fontWeight: FontWeight.w500,
                  fontSize: 14,
                  color: AppColors.black,
                ),
                subtitle: CustomText(
                  maxLines: 8,
                  textAlign: TextAlign.start,
                  text:
                  "Our support team will get back to you as soon as possible with assistance for any issues, feedback, or technical questions.",
                  fontWeight: FontWeight.w400,
                  fontSize: 14,
                  color: Color(0xFFA1A1AA),
                ),
              ),
            ],
          );
        }),
      ),
    );
  }
}










