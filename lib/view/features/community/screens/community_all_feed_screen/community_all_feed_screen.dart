import 'package:crave_crusher/view/components/custom_app_bar/custom_app_bar.dart';
import 'package:crave_crusher/view/components/custom_nav_bar/navbar.dart';
import 'package:crave_crusher/view/features/community/controllers/community_tab_controller.dart';
import 'package:crave_crusher/view/features/community/screens/create_post_screen/create_post_screen.dart';
import 'package:crave_crusher/view/features/community/widgets/common%20comunity%20widget.dart';
import 'package:crave_crusher/view/features/community/widgets/community_tab_selector.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';

class CommunityAllFeedScreen extends StatelessWidget {
   CommunityAllFeedScreen({super.key});

  final CommunityTabController controller= Get.find<CommunityTabController>();


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
                builder: (context) =>  CreatePostScreen()),
          );
        },
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding:  EdgeInsets.all(16.w),
          child: Obx((){
            return Column(children: [
              SizedBox(height: 16.h),
              /// tab section
              CommunityTabSelector(),
              Gap(24.h),

              if(controller.communityTabIndex.value==0)...[

                ListView.builder(
                   physics: BouncingScrollPhysics(),
                    scrollDirection: Axis.vertical,
                    itemCount: 6,
                    shrinkWrap: true,
                    itemBuilder: (context,index){
                  return         Column(
                    children: [
                      CommonCommunityWidget(),
                      SizedBox(height: 8.h,),

                    ],
                  );
                }),


              ],
              if(controller.communityTabIndex.value==1)...[

                ListView.builder(
                    physics: BouncingScrollPhysics(),
                    scrollDirection: Axis.vertical,
                    itemCount: 6,
                    shrinkWrap: true,
                    itemBuilder: (context,index){
                      return         Column(
                        children: [
                          CommonCommunityWidget(
                            myPost: true,
                          ),
                          SizedBox(height: 8.h,),
                        ],
                      );
                    }),



              ],





              ///common community widget
              //CommonCommunityWidget(),
              // Gap(24.h),
              // CommonCommunityWidget(),

            ]);
          }
          ),
        ),
      ),

    );
  }
}


