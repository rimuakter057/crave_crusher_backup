import 'package:crave_crusher/helper/responsive_helper/responsive_helper.dart';
import 'package:crave_crusher/service/api_url.dart';
import 'package:crave_crusher/view/components/custom_svg_icon/custom_svg_icon.dart';
import 'package:crave_crusher/view/features/community/controllers/community_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:crave_crusher/utils/app_icons/app_icons.dart';
import 'package:crave_crusher/view/components/common_empty/common_empty_widget.dart';
import 'package:crave_crusher/view/components/custom_app_bar/custom_app_bar.dart';

class CommunityImageShowScreen extends StatefulWidget {
  final List<String> images;
  const CommunityImageShowScreen({super.key, required this.images});

  @override
  State<CommunityImageShowScreen> createState() =>
      _CommunityImageShowScreenState();
}

class _CommunityImageShowScreenState extends State<CommunityImageShowScreen> {
  final CommunityController controller = Get.put(CommunityController());
  final PageController _pageController = PageController();
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
          icon: CustomSvgIcon(icon: AppIcons.backButton),
        ),
        actionIcon: AppIcons.download,
        onActionPressed: () {
          if (widget.images.isEmpty) return;

          final imageUrl =
              "${ApiUrl.primaryUrl}/${widget.images[_currentPage]}";

          controller.downloadImage(imageUrl);
        },
      ),
      body:
          widget.images.isEmpty
              ? EmptyWidget(title: "Images is not available")
              : Center(
                child: SizedBox(
                  width: ResponsiveHelper.width(390),
                  height: ResponsiveHelper.height(390),
                  child: PageView.builder(
                    controller: _pageController,
                    itemCount: widget.images.length,
                    onPageChanged: (index) {
                      setState(() {
                        _currentPage = index;
                      });
                    },
                    itemBuilder: (context, index) {
                      String imageUrl =
                          "${ApiUrl.primaryUrl}/${widget.images[index]}";
                      return Padding(
                        padding: EdgeInsets.symmetric(
                          horizontal: ResponsiveHelper.width(8),
                        ),
                        child: Container(
                          width: ResponsiveHelper.width(390),
                          height: ResponsiveHelper.height(300),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(
                              ResponsiveHelper.borderRadius(6),
                            ),
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
