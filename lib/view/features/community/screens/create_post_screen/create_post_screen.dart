import 'dart:io';
import 'package:crave_crusher/utils/app_colors/app_colors.dart';
import 'package:crave_crusher/utils/app_icons/app_icons.dart';
import 'package:crave_crusher/view/components/custom_container/custom_container.dart';
import 'package:crave_crusher/view/components/custom_image/custom_image.dart';
import 'package:crave_crusher/view/components/custom_loader/custom_loader.dart';
import 'package:crave_crusher/view/components/custom_text/custom_text.dart';
import 'package:crave_crusher/view/features/community/controllers/post_controller.dart';
import 'package:crave_crusher/view/features/community/screens/community_all_feed_screen/community_all_feed_screen.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';

class CreatePostScreen extends StatelessWidget {
  CreatePostScreen({super.key});

  final PostController controller = Get.find<PostController>();
  final TextEditingController textController = TextEditingController();

  @override
  Widget build(BuildContext context) {


    return Scaffold(
      appBar: AppBar(
        surfaceTintColor: AppColors.backgroundColor,
        backgroundColor: AppColors.backgroundColor,
        leading: Center(
          child: Container(
            width: 50.w,
            height: 50.h,
            alignment: Alignment.center,
            decoration: BoxDecoration(
              color: AppColors.subPrimary.withOpacity(.3),
              shape: BoxShape.circle,
              border: Border.all(color: AppColors.subPrimary),
            ),
            child: BackButton(color: AppColors.primary),
          ),
        ),
        centerTitle: true,
        title: CustomText(
          text: "Create Post",
          fontSize: 18.sp,
          fontWeight: FontWeight.w500,
        ),
      ),
      body: Obx(
        () => SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.w),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CustomText(
                  text: "What’s on your mind today?",
                  fontSize: 14.sp,
                  fontWeight: FontWeight.w500,
                ),
                Gap(8.h),
                CustomContainer(
                  width: double.infinity,
                  height: 120.h,
                  backgroundColor: AppColors.subPrimary.withOpacity(.5),
                  child: SizedBox(
                    height: 90.h,
                    child: TextField(
                      maxLines: 4,
                      controller: textController,
                      onChanged: (val) => controller.postText.value = val,
                      decoration: InputDecoration(
                        hintText:
                            "Share your progress, thoughts, or a victory moment…",
                        hintStyle: TextStyle(
                          color: AppColors.black.withOpacity(0.5),
                          fontSize: 14.sp,
                        ),
                        contentPadding: EdgeInsets.symmetric(
                          horizontal: 8.w,
                          vertical: 8.h,
                        ),
                        border: OutlineInputBorder(borderSide: BorderSide.none),
                      ),
                    ),
                  ),
                ),
                Gap(24.h),
                CustomText(
                  text: "Add a photo or moment (optional)",
                  fontSize: 14.sp,
                  fontWeight: FontWeight.w500,
                ),
                Gap(8.h),
               ///image add option










                GestureDetector(
                onTap: () => controller.pickImages(), // multiple image picker
                child: controller.imagePaths.isNotEmpty
                    ? SizedBox(
                  height: 120.h,
                  child: ListView.separated(
                    scrollDirection: Axis.horizontal,
                    itemCount: controller.imagePaths.length,
                    separatorBuilder: (_, __) => SizedBox(width: 10),
                    itemBuilder: (context, index) {
                      final path = controller.imagePaths[index];
                      return Stack(
                        children: [
                          ClipRRect(
                            borderRadius: BorderRadius.circular(12),
                            child: Image.file(
                              File(path),
                              width: 120.w,
                              height: 120.h,
                              fit: BoxFit.cover,
                            ),
                          ),

                          /// Remove button
                          Positioned(
                            right: 5,
                            top: 5,
                            child: GestureDetector(
                              onTap: () => controller.removeImage(path),
                              child:  Container(
                                width: 24.w,
                                height: 24.h,
                                alignment: Alignment.center,
                                decoration: BoxDecoration(
                                  color: AppColors.white,
                                  shape: BoxShape.circle,
                                  border: Border.all(color: AppColors.subPrimary),
                                ),
                                child: Icon(Icons.close, size: 16),
                              ),
                            ),
                          ),
                        ],
                      );
                    },
                  ),
                )
                    : CustomContainer(
                  width: double.infinity,
                  height: 120.h,
                  backgroundColor: AppColors.subPrimary.withOpacity(.5),
                  child: Center(
                    child: CustomImage(imageSrc: AppIcons.addImage),
                  ),
                ),
              ),

              Gap(12.h),


                /// post Button section
            GestureDetector(
              onTap: controller.isLoadingCreate.value
                  ? null
                  : () async {
                if (controller.postText.value.trim().isEmpty) {
                  Get.snackbar(
                    "Error",
                    "Post content cannot be empty",
                  );
                  return;
                }

                await controller.createPost();

                Get.to(() => CommunityAllFeedScreen());

                textController.clear();
                controller.postText.value = '';
                controller.imagePaths.clear(); // <-- FIXED
              },
              child: controller.isLoadingCreate.value
                  ? CustomLoader()
                  : CustomContainer(
                backgroundColor: AppColors.primary,
                padding: 4,
                height: 36.h,
                width: 100.w,
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
