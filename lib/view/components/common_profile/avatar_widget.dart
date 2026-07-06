import 'dart:io';
import 'package:crave_crusher/helper/images_handler/image_handler.dart';
import 'package:crave_crusher/helper/responsive_helper/responsive_helper.dart';
import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';

import 'package:crave_crusher/utils/app_colors/app_colors.dart';

class ProfileAvatarWidget extends StatelessWidget {
  final String imagePath;
  final Color? borderColor;
  final double? heightA;
  final double? widthA;
  final bool enableEdit; // enable edit icon
  final VoidCallback? onEdit; // callback on edit tap
  final String editIconAsset;
  final bool? isFile;

  const ProfileAvatarWidget({
    super.key,
    required this.imagePath,
    this.borderColor,
    this.heightA,
    this.widthA,
    this.enableEdit = false,
    this.onEdit,
    this.editIconAsset = "assets/icon/edit_profile_camera.svg",
    this.isFile = false,
  });

  @override
  Widget build(BuildContext context) {
    final double avatarHeight = ResponsiveHelper.height(80);
    final double avatarWidth = ResponsiveHelper.width(80);

    return SizedBox(
      height: heightA ?? avatarHeight,
      width: widthA ?? avatarWidth,
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          // Circular profile image
          Container(
            height: heightA ?? avatarHeight,
            width: widthA ?? avatarWidth,
            alignment: Alignment.center,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(
                color: borderColor ?? AppColors.subPrimary,
                width: ResponsiveHelper.width(2),
              ),
              color: Colors.white,
            ),
            child: ClipOval(
              child:
                  !isFile!
                      ? CachedNetworkImage(
                        imageUrl: ImageHandler.imagesHandle(imagePath),
                        width: avatarHeight,
                        height: avatarWidth,
                        fit: BoxFit.cover,
                      )
                      : Image.file(
                        File(imagePath),
                        width: avatarHeight,
                        height: avatarWidth,
                        fit: BoxFit.cover,
                      ),
            ),
          ),

          // Bottom-right edit icon
          if (enableEdit)
            Positioned(
              bottom: 0,
              right: 0,
              child: GestureDetector(
                onTap: onEdit,
                child: Container(
                  height: 28,
                  width: 28,
                  decoration: const BoxDecoration(
                    color: AppColors.primary,

                    shape: BoxShape.circle,
                  ),
                  child: const Center(
                    child: Icon(
                      Icons.camera_alt_rounded,
                      color: Colors.white,
                      size: 16,
                    ),
                  ),
                ),
              ),
            )
        ],
      ),
    );
  }
}
