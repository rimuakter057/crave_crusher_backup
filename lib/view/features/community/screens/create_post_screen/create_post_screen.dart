// ignore_for_file: deprecated_member_use

import 'dart:io';
import 'package:crave_crusher/helper/responsive_helper/responsive_helper.dart';
import 'package:crave_crusher/helper/time_converter/date_converter.dart';
import 'package:crave_crusher/utils/app_colors/app_colors.dart';
import 'package:crave_crusher/utils/app_icons/app_icons.dart';
import 'package:crave_crusher/view/components/custom_container/custom_container.dart';
import 'package:crave_crusher/view/components/custom_image/custom_image.dart';
import 'package:crave_crusher/view/components/custom_loader/custom_loader.dart';
import 'package:crave_crusher/view/components/custom_svg_icon/custom_svg_icon.dart';
import 'package:crave_crusher/view/components/custom_text/custom_text.dart';
import 'package:crave_crusher/view/features/community/controllers/community_controller.dart';
import 'package:crave_crusher/view/features/community/controllers/post_controller.dart';
import 'package:crave_crusher/view/features/community/screens/community_all_feed_screen/community_all_feed_screen.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

class CreatePostScreen extends StatelessWidget {
  CreatePostScreen({super.key});

  final PostController controller = Get.find<PostController>();
  final TextEditingController textController = TextEditingController();
  final CommunityController communityController =
      Get.find<CommunityController>();

  @override
  Widget build(BuildContext context) {
    final Widget gap = Gap(ResponsiveHelper.height(24));
    return Scaffold(
      appBar: AppBar(
        surfaceTintColor: AppColors.backgroundColor,
        backgroundColor: AppColors.backgroundColor,
        leading: Center(
          child: Container(
            width: ResponsiveHelper.width(50),
            height: ResponsiveHelper.height(50),
            alignment: Alignment.center,
            decoration: BoxDecoration(
              color: AppColors.subPrimary.withOpacity(.3),
              shape: BoxShape.circle,
              border: Border.all(color: AppColors.subPrimary),
            ),
            child: IconButton(
              onPressed: () {
                Get.back();
              },
              icon: CustomSvgIcon(icon: AppIcons.backButton),
            ),
          ),
        ),
        centerTitle: true,
        title: CustomText(
          text: "Create Post",
          fontSize: ResponsiveHelper.fontSize(18),
          fontWeight: FontWeight.w500,
        ),
      ),
      body: Obx(
        () => SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.symmetric(
              horizontal: ResponsiveHelper.width(16),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CustomText(
                  text: "What’s on your mind today?",
                  fontSize: ResponsiveHelper.fontSize(14),
                  fontWeight: FontWeight.w500,
                ),
                Gap(ResponsiveHelper.height(8)),
                CustomContainer(
                  width: double.infinity,
                  height: ResponsiveHelper.height(120),
                  backgroundColor: AppColors.subPrimary.withOpacity(.5),
                  child: SizedBox(
                    height: ResponsiveHelper.height(90),
                    child: TextField(
                      maxLines: 4,
                      controller: textController,
                      onChanged: (val) => controller.postText.value = val,
                      decoration: InputDecoration(
                        hintText:
                            "Share your progress, thoughts, or a victory moment…",
                        hintStyle: TextStyle(
                          color: AppColors.black.withOpacity(0.5),
                          fontSize: ResponsiveHelper.fontSize(14),
                        ),
                        contentPadding: EdgeInsets.symmetric(
                          horizontal: ResponsiveHelper.width(8),
                          vertical: ResponsiveHelper.height(8),
                        ),
                        border: OutlineInputBorder(borderSide: BorderSide.none),
                      ),
                    ),
                  ),
                ),
                gap,
                CustomText(
                  text: "Add a photo or moment (optional)",
                  fontSize: ResponsiveHelper.fontSize(14),
                  fontWeight: FontWeight.w500,
                ),
                Gap(ResponsiveHelper.height(12)),

                /// Image List
                if (controller.imagePaths.isNotEmpty)
                  SizedBox(
                    height: ResponsiveHelper.height(120),
                    child: ListView.separated(
                      scrollDirection: Axis.horizontal,
                      itemCount: controller.imagePaths.length,
                      separatorBuilder:
                          (_, __) =>
                              SizedBox(width: ResponsiveHelper.width(10)),
                      itemBuilder: (context, index) {
                        final path = controller.imagePaths[index];
                        return Stack(
                          children: [
                            ClipRRect(
                              borderRadius: BorderRadius.circular(
                                ResponsiveHelper.borderRadius(12),
                              ),
                              child: Image.file(
                                File(path),
                                width: ResponsiveHelper.width(120),
                                height: ResponsiveHelper.height(120),
                                fit: BoxFit.cover,
                              ),
                            ),
                            Positioned(
                              right: ResponsiveHelper.width(5),
                              top: ResponsiveHelper.height(5),
                              child: GestureDetector(
                                onTap: () => controller.removeImage(path),
                                child: Container(
                                  width: ResponsiveHelper.width(24),
                                  height: ResponsiveHelper.height(24),
                                  decoration: BoxDecoration(
                                    color: AppColors.white,
                                    shape: BoxShape.circle,
                                  ),
                                  child: CustomSvgIcon(icon: AppIcons.cross),
                                ),
                              ),
                            ),
                          ],
                        );
                      },
                    ),
                  ),

                gap,
                GestureDetector(
                  onTap: () => controller.pickImages(),
                  child: CustomContainer(
                    width: double.infinity,
                    height: ResponsiveHelper.height(120),
                    backgroundColor: AppColors.subPrimary.withOpacity(.5),
                    child: Center(
                      child: CustomImage(imageSrc: AppIcons.addImage),
                    ),
                  ),
                ),
                gap,

                /// post Button section
                GestureDetector(
                  onTap:
                      controller.isLoadingCreate.value
                          ? null
                          : () async {
                            var dateTime = DateConverter.dateYearTimeUtc(
                              DateTime.now().toString(),
                            );

                            debugPrint(
                              "dateTime========================= >> $dateTime",
                            );

                            if (controller.postText.value.trim().isEmpty) {
                              Get.snackbar(
                                "Error",
                                "Post content cannot be empty",
                              );
                              return;
                            }

                            await controller.createPost();

                            Get.off(
                              () => CommunityAllFeedScreen(initialTabIndex: 0),
                            );

                            textController.clear();
                            controller.postText.value = '';
                            controller.imagePaths.clear(); // <-- FIXED
                          },
                  child:
                      controller.isLoadingCreate.value
                          ? CustomLoader()
                          : CustomContainer(
                            backgroundColor: AppColors.primary,
                            padding: ResponsiveHelper.width(4),
                            height: ResponsiveHelper.height(36),
                            width: ResponsiveHelper.width(100),
                            child: Center(
                              child: CustomText(
                                text: "Post Now",
                                color: AppColors.white,
                              ),
                            ),
                          ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
