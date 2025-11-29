import 'package:crave_crusher/utils/app_colors/app_colors.dart';
import 'package:crave_crusher/utils/app_icons/app_icons.dart';
import 'package:crave_crusher/utils/app_images/app_images.dart';
import 'package:crave_crusher/view/components/custom_container/custom_container.dart';
import 'package:crave_crusher/view/components/custom_image/custom_image.dart';
import 'package:crave_crusher/view/components/custom_loader/custom_loader.dart';
import 'package:crave_crusher/view/components/custom_text/custom_text.dart';
import 'package:crave_crusher/view/components/custom_text_field/custom_text_field.dart';
import 'package:crave_crusher/view/features/community/controllers/community_controller.dart';
import 'package:crave_crusher/view/features/community/controllers/post_controller.dart';
import 'package:crave_crusher/view/features/community/screens/community_all_feed_screen/community_all_feed_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class UpdatePostScreen extends StatefulWidget {
  const UpdatePostScreen({super.key, required this.postId, required this.content});
final String postId;
final String content;
  @override
  State<UpdatePostScreen> createState() => _UpdatePostScreenState();
}

class _UpdatePostScreenState extends State<UpdatePostScreen> {
  /// dummy image list (you can replace with real data)
  final List<String> images = [
    AppImages.imageOne,
    AppImages.imageOne,
    AppImages.imageOne,
    AppImages.imageOne,
    AppImages.imageOne,
  ];

  final contentController = TextEditingController();
  final PostController communityController = Get.find<PostController>();
  @override
  void initState() {
    super.initState();
    debugPrint("postId==================================${widget.postId}");
    contentController.text =widget.content;
  }


  @override
  Widget build(BuildContext context) {

    double screenWidth = MediaQuery.of(context).size.width;
    double itemWidth = (screenWidth - 16.w - 16.w - 8.w * 2) / 3; // 3 item fixed

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
          text: "Update",
          fontSize: 18.sp,
          fontWeight: FontWeight.w500,
        ),
      ),

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

              /// ---- Image Grid (3-column fixed) ----
              Wrap(
                spacing: 8.w,
                runSpacing: 8.h,
                children: List.generate(
                  images.length,
                      (index) => _buildImageItem(images[index], itemWidth),
                ),
              ),

              Gap(16.h),

              /// add button
              CustomContainer(
                borderColor: AppColors.primary,
                width: double.infinity,
                height: 120.h,
                backgroundColor: AppColors.subPrimary.withOpacity(.5),
                child: Center(
                    child: CustomImage(imageSrc: AppIcons.addImage)),
              ),

              Gap(16.h),

              /// post button


              Obx((){
                return GestureDetector(
                  onTap: () async {
                    if (contentController.text.isEmpty) {
                      Get.snackbar("Error", "Content cannot be empty!");
                      return;
                    }
                    final isUpdated = await communityController.updatePost(
                      widget.postId,
                     contentController.text,
                    );
                    // if (isUpdated) {
                    //   Get.to(()=>CommunityAllFeedScreen());
                    // }
                  },
                  child:communityController.isLoadingUpdate.value
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
              })




            ],
          ),
        ),
      ),
    );
  }

  /// ---------------- BUILD IMAGE ITEM ----------------
  Widget _buildImageItem(String img, double size) {
    return Stack(
      children: [
        ClipRRect(
          borderRadius: BorderRadius.circular(12),
          child: CustomImage(
            imageSrc: img,
            height: size,
            width: size,
          ),
        ),

        Positioned(
          right: 6,
          top: 6,
          child: Container(
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
      ],
    );
  }
}
