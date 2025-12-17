import 'dart:io';
import 'package:crave_crusher/helper/imges_handler/image_handler.dart';
import 'package:crave_crusher/utils/app_const/app_const.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:image_picker/image_picker.dart';
import 'package:crave_crusher/utils/app_colors/app_colors.dart';

class ProfileAvatarWidget extends StatelessWidget {
  final String imagePath;
  final Color? borderColor;
  final double? heightA;
  final double? widthA;
  final bool enableEdit; // enable edit icon
  final VoidCallback? onEdit; // callback on edit tap
  final String editIconAsset;
  final bool? isFile  ;

  const ProfileAvatarWidget({
    super.key,
    required this.imagePath,
    this.borderColor,
    this.heightA,
    this.widthA,
    this.enableEdit = false,
    this.onEdit,
    this.editIconAsset = "assets/icon/edit_profile_camera.svg", this.isFile = false,
  });

  @override
  Widget build(BuildContext context) {


    final double avatarHeight =  80.h;
    final double avatarWidth = 80.w;

    final double imageHeight = 80.h;
    final double imageWidth = 80.w;

    return SizedBox(
      height:heightA?? avatarHeight,
      width:widthA?? avatarWidth,
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          // Circular profile image
          Container(
            height:heightA?? avatarHeight,
            width:widthA?? avatarWidth,
            alignment: Alignment.center,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(
                color: borderColor ?? AppColors.subPrimary,
                width: 1,
              ),
              color: Colors.white,
            ),
            child: ClipOval(
              child:  !isFile!
                  ? CachedNetworkImage(
                imageUrl: ImageHandler.imagesHandle(imagePath),
                width: imageWidth,
                height: imageHeight,
                fit: BoxFit.cover,
              )
                  : Image.file(
                File(imagePath),
                width: imageWidth,
                height: imageHeight,
                fit: BoxFit.cover,
              ),
            ),

          ),

          // Bottom-right edit icon
          if (enableEdit)
            Positioned(
              bottom: 0,
              right:0,
              child:SizedBox(
                height: 24.h,
                width: 24.w,
                child: IconButton(
                    padding: EdgeInsets.zero, // default padding কমাবে
                    constraints: BoxConstraints(), // default constraints রিমুভ
                    onPressed: onEdit,
                    style: IconButton.styleFrom(
                      shape: CircleBorder(),
                      backgroundColor: AppColors.primary
                    ),
                    icon: Icon(Icons.camera_alt_outlined,color: AppColors.white,size: 15.w,)),
              )

            ),
        ],
      ),
    );
  }
}
