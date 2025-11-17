

import 'package:crave_crusher/utils/app_colors/app_colors.dart';
import 'package:crave_crusher/utils/app_images/app_images.dart';
import 'package:crave_crusher/view/components/common_profile/avater_widget.dart';
import 'package:crave_crusher/view/components/custom_container/custom_container.dart';
import 'package:crave_crusher/view/components/custom_image/custom_image.dart';
import 'package:crave_crusher/view/components/custom_text/custom_text.dart';
import 'package:crave_crusher/view/components/custom_text_field/custom_text_field.dart';
import 'package:crave_crusher/view/components/input_field_with_title/input_field_with_title.dart';
import 'package:crave_crusher/view/screens/notification/widgets/notification_tile_widget.dart';
import 'package:crave_crusher/view/screens/profile/profile_screen/profile_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';


class NotificationScreens extends StatelessWidget {
  const NotificationScreens({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:  AppBar(
        surfaceTintColor: AppColors.backgroundColor,
        backgroundColor:AppColors.backgroundColor,
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
          text: "Notification",
          fontSize: 18.sp,
          fontWeight: FontWeight.w500,
        ),
      ),

      body: ListView.separated(
          itemCount: 6,
        separatorBuilder: (context,index){return SizedBox(height: 8.h,);},
        itemBuilder: (context,index){

            return NotificationTileWidget(

              title: "New Badge Earned",
              subtitle: "Congratulations! You’ve unlocked a new badge for your dedication and progress. Check your Rewards tab to view your achievement.",
              leading: Container(
                width: 40.w,
                height: 40.h,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  color: AppColors.subPrimary.withOpacity(.3),
                  shape: BoxShape.circle,
                  border: Border.all(color: AppColors.subPrimary),
                ),
                child: CustomImage(
                  imageSrc: AppImages.appLogo,
                  height: 24.h,
                  width: 27.w,
                  fit: BoxFit.cover,
                ),
              ),

              trailing: Icon(Icons.close,color: AppColors.primary,size: 24,),


            );


        },  ),

    );
  }
}


