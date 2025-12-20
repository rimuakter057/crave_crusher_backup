import 'package:crave_crusher/view/features/community/controllers/community_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:crave_crusher/utils/app_colors/app_colors.dart';
import 'package:crave_crusher/utils/app_icons/app_icons.dart';
import 'package:crave_crusher/view/components/common_empty/common_empty_widget.dart';
import 'package:crave_crusher/view/components/custom_app_bar/custom_app_bar.dart';


class CommunityImageShowScreen extends StatefulWidget {
  final List<String> images;
  const CommunityImageShowScreen({super.key, required this.images});

  @override
  State<CommunityImageShowScreen> createState() => _CommunityImageShowScreenState();
}

class _CommunityImageShowScreenState extends State<CommunityImageShowScreen> {
  final CommunityController controller = Get.put(CommunityController());
  PageController _pageController = PageController();
  int _currentPage = 0;

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        title: 'Media',
        leading: IconButton(
          onPressed: () => Navigator.pop(context),
          icon: Icon(Icons.close, color: AppColors.primary),
        ),
        actionIcon: AppIcons.download,
        onActionPressed: () {
          if (widget.images.isNotEmpty) {
            String imageUrl = "http://10.10.20.45:5555/${widget.images[_currentPage]}";
            controller.downloadImage(imageUrl);
          }
        },
      ),
      body: widget.images.isEmpty
          ? EmptyWidget(title: "Images is not available")
          : Center(
            child: SizedBox(
                    width: 390.w,
                    height: 300.h,
              child: PageView.builder(
                      controller: _pageController,
                      itemCount: widget.images.length,
                      onPageChanged: (index) {
              setState(() {
                _currentPage = index;
              });
                      },
                      itemBuilder: (context, index) {
              String imageUrl = "http://10.10.20.45:5555/${widget.images[index]}";
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
