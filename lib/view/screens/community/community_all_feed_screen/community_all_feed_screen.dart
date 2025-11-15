import 'package:crave_crusher/utils/app_colors/app_colors.dart';
import 'package:crave_crusher/utils/app_images/app_images.dart';
import 'package:crave_crusher/view/components/common_profile/common_profile_widget.dart';
import 'package:crave_crusher/view/components/custom_app_bar/custom_app_bar.dart';
import 'package:crave_crusher/view/components/custom_image/custom_image.dart';
import 'package:crave_crusher/view/components/custom_nav_bar/navbar.dart';
import 'package:crave_crusher/view/components/custom_text/custom_text.dart';
import 'package:crave_crusher/view/screens/battle/widget/battle_tab_selector.dart';
import 'package:crave_crusher/view/screens/community/create_post_screen/create_post_screen.dart';
import 'package:crave_crusher/view/screens/community/widgets/common%20comunity%20widget.dart';
import 'package:crave_crusher/view/screens/community/widgets/community_tab_selector.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';

class CommunityAllFeedScreen extends StatelessWidget {
  const CommunityAllFeedScreen({super.key});

  @override
  Widget build(BuildContext context) {

    return


      Scaffold(
      bottomNavigationBar: NavBar(currentIndex: 2),
      // appBar: ,
      appBar: CustomAppBar(
        title: 'Community',
        onActionPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => const CreatePostScreen()),
          );
        },
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding:  EdgeInsets.all(16.w),
          child: Column(children: [
            SizedBox(height: 16.h),
            /// tab section
            CommunityTabSelector(),
            Gap(24.h),
            ///common community widget
            CommonCommunityWidget(),
            Gap(24.h),
            CommonCommunityWidget(),
        
          ],),
        ),
      ),

    );
  }
}


