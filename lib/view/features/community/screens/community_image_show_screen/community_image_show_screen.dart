import 'package:crave_crusher/utils/app_colors/app_colors.dart';
import 'package:crave_crusher/utils/app_icons/app_icons.dart';
import 'package:crave_crusher/view/components/custom_app_bar/custom_app_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CommunityImageShowScreen extends StatelessWidget {
  final List<String> images; // API থেকে পাওয়া images
  const CommunityImageShowScreen({super.key, required this.images});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        title: 'Media',
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Icon(Icons.close, color: AppColors.primary),
        ),
        actionIcon: AppIcons.download,
        onActionPressed: () {
          // Download logic
        },
      ),
      body: images.isEmpty
          ? Center(child: Text("No images available"))
          : Center(
            child: SizedBox(
                    height: 300.h,
                    child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: images.length,
            itemBuilder: (context, index) {
            
              String imageUrl = "http://10.10.20.45:5555/${images[index]}";
              return Padding(
                padding: EdgeInsets.symmetric(horizontal: 8.w),
            
                child: Container(
                  width: 390.w,
                  height: 300.h,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(6.r),
                    image: DecorationImage(
                      image: NetworkImage(imageUrl),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              );
            },
                    ),
                  ),
          ),
    );
  }
}
