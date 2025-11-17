
import 'package:crave_crusher/utils/app_colors/app_colors.dart';
import 'package:crave_crusher/utils/app_icons/app_icons.dart';

import 'package:crave_crusher/view/components/custom_container/custom_container.dart';
import 'package:crave_crusher/view/components/custom_image/custom_image.dart';

import 'package:crave_crusher/view/components/custom_text/custom_text.dart';


import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';

class HelpSupportScreen extends StatelessWidget {
  const HelpSupportScreen({super.key});

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
          text: "Help/Support",
          fontSize: 18.sp,
          fontWeight: FontWeight.w500,
        ),
      ),


      body: SingleChildScrollView(
        child: Padding(
          padding:  EdgeInsets.symmetric(horizontal: 16.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [

              ///What is Crave Crusher?
               CustomContainer(
                   backgroundColor:Color(0xFFEEF2FF),
                   child: Column(children: [
                      Row(

                        children: [
                        Expanded(child: CustomText(text: "What is Crave Crusher?",fontSize: 14,)),
                          DropdownButton<String>(

                            underline: SizedBox(), // underline (grey divider) remove করা
                            icon: Icon(Icons.keyboard_arrow_down_outlined,color: AppColors.primary,size: 28,), // main dropdown icon
                            items: [
                              DropdownMenuItem(
                                value: "Option 1",
                                child: Row(
                                  children: [
                                    Icon(Icons.check_circle, color: Colors.green),
                                    SizedBox(width: 8),
                                    Text("Option 1"),
                                  ],
                                ),
                              ),
                              DropdownMenuItem(
                                value: "Option 2",
                                child: Row(
                                  children: [
                                    Icon(Icons.star, color: Colors.orange),
                                    SizedBox(width: 8),
                                    Text("Option 2"),
                                  ],
                                ),
                              ),
                              DropdownMenuItem(
                                value: "Option 3",
                                child: Row(
                                  children: [
                                    Icon(Icons.favorite, color: Colors.red),
                                    SizedBox(width: 8),
                                    Text("Option 3"),
                                  ],
                                ),
                              ),
                            ],
                            onChanged: (value) {
                              print("Selected: $value");
                            },
                          )
                        ],),
                     Divider(
                       color: Colors.grey,
                       thickness: 1.2,
                     ),
                     CustomText(
                         maxLines: 8,
                         textAlign: TextAlign.start,
                         text: "Crave Crusher is your personal companion to overcome addictions and bad habits. Create daily “battles,” track cravings, and watch your Addiction Monster lose power as you progress.",
                         fontWeight: FontWeight.w400,
                         fontSize: 14,
                         color:Color(0xFFA1A1AA)
                     ),


               ],)),
              Gap (12.h),
               ///others option
              _buildOthersField("How do I start a battle?"),
              Gap (8.h),
              _buildOthersField("Can I fight more than one addiction?"),
              Gap (8.h),
              _buildOthersField("How do I track money and time saved?"),
              Gap (8.h),
              _buildOthersField("What does “Craved” and “Caved” mean?"),
              ///need more help
              CustomText(text: "Need More Help?"),
              Gap (8.h),
              ListTile(

                tileColor:Color(0xFFEEF2FF),
                             leading: CustomImage(imageSrc: AppIcons.music,),
                title:CustomText(
                  textAlign: TextAlign.start,
                  text: "Mail Us [support@CraveCrusher.com]",
                  fontWeight: FontWeight.w500,
                  fontSize: 14,
                  color:AppColors.black,
                ),


                subtitle: CustomText(
                    maxLines: 8,
                    textAlign: TextAlign.start,
                    text: "Our support team will get back to you as soon as possible with assistance for any issues, feedback, or technical questions.",
                    fontWeight: FontWeight.w400,
                    fontSize: 14,
                    color:Color(0xFFA1A1AA)
                ),


              ),



            ],),
        ),
      ),

    );
  }



///others field option
  CustomContainer _buildOthersField(String title) {
    return CustomContainer(
              padding: 16,
                backgroundColor:Color(0xFFEEF2FF),
                child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: CustomText(
                        textAlign: TextAlign.start,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        text: title,fontSize: 14,),
                    ),

                    Icon(Icons.arrow_forward_ios,color: AppColors.primary,size: 18,),

                  ],));
  }
}









