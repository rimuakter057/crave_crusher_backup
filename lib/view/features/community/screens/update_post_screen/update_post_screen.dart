import 'dart:io';

import 'package:crave_crusher/helper/images_handler/image_handler.dart';
import 'package:crave_crusher/utils/app_colors/app_colors.dart';
import 'package:crave_crusher/utils/app_icons/app_icons.dart';

import 'package:crave_crusher/view/components/custom_container/custom_container.dart';
import 'package:crave_crusher/view/components/custom_image/custom_image.dart';
import 'package:crave_crusher/view/components/custom_loader/custom_loader.dart';
import 'package:crave_crusher/view/components/custom_network_image/custom_network_image.dart';
import 'package:crave_crusher/view/components/custom_svg_icon/custom_svg_icon.dart';
import 'package:crave_crusher/view/components/custom_text/custom_text.dart';
import 'package:crave_crusher/view/components/custom_text_field/custom_text_field.dart';
import 'package:crave_crusher/view/features/community/controllers/post_controller.dart';
import 'package:crave_crusher/view/features/community/models/post_update_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class UpdatePostScreen extends StatefulWidget {
  const UpdatePostScreen({super.key, required this.updatePostData});

  final PostUpdateModel updatePostData;
  @override
  State<UpdatePostScreen> createState() => _UpdatePostScreenState();
}

class _UpdatePostScreenState extends State<UpdatePostScreen> {
  final contentController = TextEditingController();
  final PostController postController = Get.find<PostController>();
  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      contentController.text = widget.updatePostData.content;

      // Existing images set kora
      postController.currentImagePaths.value =
          widget.updatePostData.images.isNotEmpty
              ? List<String>.from(widget.updatePostData.images)
              : [];
    });
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double itemWidth =
        (screenWidth - 16.w - 16.w - 8.w * 2) / 3; // 3 item fixed

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
          text: "Update",
          fontSize: 18.sp,
          fontWeight: FontWeight.w500,
        ),
      ),
      //         onTap: () => postController.pickImagesUpdate(),
      //        final images = postController.currentImagePaths;
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              /// write comment
              CustomText(
                text: "What’s on your mind today?",
                fontSize: 14.sp,
                fontWeight: FontWeight.w500,
              ),
              Gap(8.h),

              CustomTextField(
                cursorColor: AppColors.black,
                maxLines: 4,
                textEditingController: contentController,
                hintText: "Share your progress, thoughts, or a victory moment…",
                hintStyle: GoogleFonts.syne(
                  color: AppColors.black.withOpacity(0.5),
                  fontSize: 14.sp,
                ),
                fillColor: AppColors.subPrimary.withOpacity(.5),
              ),

              Gap(24.h),

              /// add photo
              CustomText(
                text: "Add a photo or moment (optional)",
                fontSize: 14.sp,
                fontWeight: FontWeight.w500,
              ),
              Gap(16.h),

              //========================================
              Obx(() {
                final images = postController.currentImagePaths;

                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    /// selected images (Column or Wrap)
                    if (images.isNotEmpty)
                      Wrap(
                        spacing: 8.w,
                        runSpacing: 8.h,
                        children: List.generate(
                          images.length,
                          (index) => _buildImageItem(images[index], itemWidth),
                        ),
                      ),

                    Gap(12.h),

                    /// full width add button
                    GestureDetector(
                      onTap: () => postController.pickImagesUpdate(),
                      child: CustomContainer(
                        width: double.infinity,
                        height: 120.h,
                        borderColor: AppColors.primary,
                        backgroundColor: AppColors.subPrimary.withOpacity(.5),
                        child: Center(
                          child: CustomImage(imageSrc: AppIcons.addImage),
                        ),
                      ),
                    ),
                  ],
                );
              }),

              Gap(16.h),

              /// post button
              Obx(() {
                return InkWell(
                  onTap: () async {
                    if (contentController.text.isEmpty) {
                      Get.snackbar("Error", "Content cannot be empty!");
                      return;
                    }

                    await postController.updatePost(
                      widget.updatePostData.postId,
                      contentController.text,
                    );
                  },
                  child:
                      postController.isLoadingUpdate.value
                          ? CustomLoader()
                          : CustomContainer(
                            backgroundColor: AppColors.primary,
                            padding: 4,
                            height: 45.h,
                            width: 140.w,
                            child: Center(
                              child: CustomText(
                                text: "Update Post",
                                color: AppColors.white,
                                fontSize: 18,
                              ),
                            ),
                          ),
                );
              }),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildImageItem(String img, double size) {
    final bool isLocalFile = File(img).existsSync();

    return Stack(
      children: [
        ClipRRect(
          borderRadius: BorderRadius.circular(12),
          child:
              isLocalFile
                  ? Image.file(
                    File(img),
                    height: size,
                    width: size,
                    fit: BoxFit.cover,
                  )
                  : CustomNetworkImage(
                    imageUrl: ImageHandler.imagesHandle(img),
                    height: size,
                    width: size,
                  ),
        ),
        Positioned(
          right: 6,
          top: 6,
          child: GestureDetector(
            onTap: () {
              postController.deleteImage(img);
              debugPrint('delete image');
            },
            child: Container(
              width: 24.w,
              height: 24.h,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                color: AppColors.white,
                shape: BoxShape.circle,
                border: Border.all(color: AppColors.subPrimary),
              ),
              child: CustomSvgIcon(icon: AppIcons.cross),
            ),
          ),
        ),
      ],
    );
  }
}
