import 'package:crave_crusher/helper/responsive_helper/responsive_helper.dart';
import 'package:crave_crusher/utils/app_colors/app_colors.dart';
import 'package:crave_crusher/view/components/custom_button/custom_button.dart';
import 'package:crave_crusher/view/components/custom_loader/custom_loader.dart';
import 'package:crave_crusher/view/components/custom_text/custom_text.dart';
import 'package:crave_crusher/view/components/input_field_with_title/input_field_with_title.dart';
import 'package:crave_crusher/view/components/leading_back/custom_leading_back_icon.dart';
import 'package:crave_crusher/view/features/auth/controllers/forget_password_controller.dart';
import 'package:crave_crusher/view/features/auth/screen/verify_identity/verify_identity_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';




class ForgotPasswordScreen extends StatelessWidget {
ForgotPasswordScreen({super.key});
final TextEditingController _emailController = TextEditingController();
  final ForgetPasswordController forgetPasswordController =
  Get.find<ForgetPasswordController>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:AppBar(
        leading: Center(
          child: Container(
            width: ResponsiveHelper.width(50), // 50.w,
            height: ResponsiveHelper.height(50), // 50.h,
            alignment: Alignment.center,
            decoration: BoxDecoration(
              color: AppColors.subPrimary.withOpacity(.3),
              shape: BoxShape.circle,
              border: Border.all(color: AppColors.subPrimary),
            ),
            child:LeadingBackIconWidget(),
          ),
        ),
        centerTitle: true,
        title: CustomText(
          text: "Forgot Password",
          fontSize: ResponsiveHelper.fontSize(18), // 18.sp,
          fontWeight: FontWeight.w500,
        ),

      ),
      body: SingleChildScrollView(
        child: Padding(
          padding:  ResponsiveHelper.all(16),
          child: Column(children: [

            ///login text
            CustomText(
              textAlign: TextAlign.start,
              text: "Forgot Password",
              fontSize: ResponsiveHelper.fontSize(24),
              fontWeight: FontWeight.w500,
            ),

            SizedBox(height: ResponsiveHelper.spacing(8)),

            CustomText(
              maxLines: 3,
              textAlign: TextAlign.start,
              text:
              "Don’t worry enter your registered email",
              fontSize: ResponsiveHelper.fontSize(16),
              fontWeight: FontWeight.w400,
              color: const Color(0xFF555555),
            ),





            SizedBox(height: ResponsiveHelper.spacing(120)),

            /// email input field
            InputFieldWithTitleWidget(
              title: "Email Address",
              hintText: "Enter your email",
              controller: _emailController,
              validator: (String? value) {
                if (value == null || value.trim().isEmpty) {
                  return "Enter Your Email";
                }
                final emailRegex = RegExp(
                  r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$',
                );
                if (!emailRegex.hasMatch(value.trim())) {
                  return "Enter a valid email address";
                }
                return null;
              },
            ),
            SizedBox(height: ResponsiveHelper.spacing(152)),
            GetBuilder<ForgetPasswordController>(
              builder: (controller) {
                return Visibility(
                  visible: controller.inProgress == false,
                  replacement: const CustomLoader(),
                  child:CustomButton(
                   onTap: _forgetButtonTap,
                   title: "Send OTP",

                  ),




                  // TextButton(
                  //   onPressed: _forgetButtonTap,
                  //   child: CustomText(
                  //     text: "Forget Password?",
                  //     fontWeight: FontWeight.w600,
                  //     fontSize: ResponsiveHelper.fontSize(14),
                  //     color: AppColors.primary,
                  //   ),
                  // ),

                );
              },
            ),


          ],),
        ),
      ),



    );
  }



  ///forget button
  Future<void> _forgetButtonTap() async {
    if(_emailController.text.isEmpty){
      Get.snackbar("Error", "Please Enter Your Email");
      return;
    }

    final bool isSuccess = await forgetPasswordController.forgetPassword(
      _emailController.text,
    );


    if (isSuccess && _emailController.text.isNotEmpty) {
      Get.to(() => VerifyIdentityScreen(email: _emailController.text));
    }


  }

}
