

import 'package:crave_crusher/utils/app_colors/app_colors.dart';
import 'package:crave_crusher/view/components/custom_text/custom_text.dart';
import 'package:crave_crusher/view/screens/change_password/change_password_screen.dart';

import 'package:crave_crusher/view/screens/profile/widgets/custom_profile_menu.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:google_fonts/google_fonts.dart';

class TermsConditionScreen extends StatelessWidget {
  const TermsConditionScreen({super.key});

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
          text: "Terms & Condition",
          fontSize: 18.sp,
          fontWeight: FontWeight.w500,
        ),
      ),

      body: SingleChildScrollView(
        padding: EdgeInsets.all(16),
        child: RichText(
          text: TextSpan(
            style: TextStyle(
              color: Colors.black,
              fontSize: 12,
              height: 1.5,
              fontWeight: FontWeight.w400
            ),
            children: [
              TextSpan(
                text: "Terms and Conditions\n",
                style:GoogleFonts.syne(fontSize: 18.sp, fontWeight: FontWeight.w600,),


              ),
              TextSpan(
                text: "Last Updated: 30-10-2005\n\n",
                style: GoogleFonts.syne(fontSize: 14.sp, fontWeight: FontWeight.w500,),
              ),

              // 1
              TextSpan(
                text: "1. Overview\n",
                style: GoogleFonts.syne(fontSize: 13.sp, fontWeight: FontWeight.w600,),
              ),
              TextSpan(
                text:
                "Crave Crusher is a motivational wellness platform designed to help users overcome addictions and bad habits through goal setting, tracking, and gamified progress.\n\n",

                style: GoogleFonts.syne(fontSize: 12.sp, fontWeight: FontWeight.w400,),
              ),

              // 2
              TextSpan(
                text: "2. User Responsibilities\n",
                style: GoogleFonts.syne(fontSize: 13.sp, fontWeight: FontWeight.w600,),
              ),
              TextSpan(
                text:
                "Account Creation: You must create an account to access features.\n"
                    "Confidentiality: You are responsible for safeguarding your account.\n"
                    "Lawful Use: You agree not to misuse the app.\n\n",
                style: GoogleFonts.syne(fontSize: 12.sp, fontWeight: FontWeight.w400,),
              ),



              TextSpan(
                children: [
                  // 3
                  TextSpan(
                    text: "3. App Functionality\n",
                    style: GoogleFonts.syne(fontSize: 13.sp, fontWeight: FontWeight.w600,),
                  ),
                  TextSpan(
                    text:
                    "Battles and Tracking: Users can set \"Battles\" to quit or control specific addictions such as smoking, social media, shopping, or junk food. Progress is self-reported. Crave Crusher is not responsible for the accuracy of user entries or outcomes.\n\n"
                        "Community Posts: You may share progress posts and comments. Content must remain respectful, supportive, and free from discrimination or harmful speech. We reserve the right to remove posts that violate community standards.\n\n"
                        "Rewards and Badges: Badges and rewards are motivational tools only. They have no monetary value and cannot be exchanged for cash or prizes.\n\n",

                    style: GoogleFonts.syne(fontSize: 12.sp, fontWeight: FontWeight.w400,),
                  ),

                  // 4
                  TextSpan(
                    text: "4. Payments and Ads\n",
                    style: GoogleFonts.syne(fontSize: 13.sp, fontWeight: FontWeight.w600,),
                  ),
                  TextSpan(
                    text:
                    "Payments: Currently, Crave Crusher is free to use. If paid features or subscriptions are introduced, all fees will be clearly disclosed before purchase.\n\n"
                        "Ads and Monetization: Crave Crusher may display in-app advertisements through Google AdMob or similar platforms. Watching ads may unlock certain rewards or in-app perks.\n\n",
                    style: GoogleFonts.syne(fontSize: 12.sp, fontWeight: FontWeight.w400,),

                  ),
                ],
              ),


            ],
          ),
        ),
      )
      ,




    );
  }
}
