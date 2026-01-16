import 'package:crave_crusher/utils/app_colors/app_colors.dart';
import 'package:crave_crusher/utils/app_const/app_const.dart';
import 'package:crave_crusher/utils/app_icons/app_icons.dart';
import 'package:crave_crusher/view/components/common_empty/common_empty_widget.dart';
import 'package:crave_crusher/view/components/custom_container/custom_container.dart';
import 'package:crave_crusher/view/components/custom_image/custom_image.dart';
import 'package:crave_crusher/view/components/custom_leading_title_appbar.dart';
import 'package:crave_crusher/view/components/custom_text/custom_text.dart';
import 'package:crave_crusher/view/features/account_setting/controllers/account_setting_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';

class HelpSupportScreen extends StatelessWidget {
  HelpSupportScreen({super.key});

  final AccountSettingController helpController =
      Get.find<AccountSettingController>();
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
            return EmptyWidget(title: "There are currently no FAQs to display");
          }

          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Loop through API FAQs
              ...helpData.map(
                (faq) => Column(
                  children: [
                    CustomContainer(
                      backgroundColor: const Color(0xFFEEF2FF),
                      padding: 12,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          /// Question + Icon Row
                          Row(
                            children: [
                              Expanded(
                                child: CustomText(
                                  textAlign: TextAlign.start,
                                  text: faq.question ?? "",
                                  fontSize: 14,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                              GestureDetector(
                                onTap: () {
                                  faq.isExpanded = !faq.isExpanded;
                                  helpController.helpList.refresh();
                                },
                                child: SvgPicture.asset(
                                  faq.isExpanded
                                      ? AppIcons
                                          .dropDown // SVG for down arrow
                                      : AppIcons
                                          .arrowFront, // SVG for right arrow
                                  width: 28,
                                  height: 28,
                                  colorFilter: ColorFilter.mode(
                                    AppColors.primary,
                                    BlendMode.srcIn,
                                  ),
                                ),
                              ),
                            ],
                          ),

                          /// Answer (only when expanded)
                          if (faq.isExpanded) ...[
                            const Divider(color: Colors.grey, thickness: 1.2),
                            CustomText(
                              text: faq.answer ?? "",
                              fontWeight: FontWeight.w400,
                              fontSize: 14,
                              color: const Color(0xFFA1A1AA),
                              maxLines: 10,
                              textAlign: TextAlign.start,
                            ),
                          ],
                        ],
                      ),
                    ),
                    Gap(12.h),
                  ],
                ),
              ),

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
