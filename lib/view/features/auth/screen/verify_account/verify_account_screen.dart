

import 'package:crave_crusher/view/components/custom_button/custom_button.dart';
import 'package:crave_crusher/view/components/custom_text/custom_text.dart';
import 'package:crave_crusher/view/components/show_snakbar/show_snakbar.dart';
import 'package:crave_crusher/view/features/auth/controllers/verify_otp_controller.dart';
import 'package:crave_crusher/view/features/auth/models/verify_otp_model.dart';
import 'package:crave_crusher/view/features/auth/screen/login/login_screen.dart';
import 'package:crave_crusher/view/features/auth/screen/verify_identity/verify_identity_screen.dart';
import 'package:crave_crusher/view/features/auth/screen/widgets/action_promote_widget.dart';
import 'package:crave_crusher/view/features/auth/screen/widgets/otp_field_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';


class VerifyAccountScreen extends StatefulWidget {
  const VerifyAccountScreen({super.key, required this.email});
final String email;

  @override
  State<VerifyAccountScreen> createState() => _VerifyAccountScreenState();
}

class _VerifyAccountScreenState extends State<VerifyAccountScreen> {

  final TextEditingController _otpController=TextEditingController();

  final VerifyOtpController verifyOtpController = Get.find<VerifyOtpController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(


      body:  Center(
          child: SingleChildScrollView(
            child: Padding(
              padding:  EdgeInsets.symmetric(horizontal:16.w),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Gap(8.h),
                  ///reset  text
                  CustomText(
                    textAlign: TextAlign.start,
                    text: "Verify Your Account",fontSize: 28.sp,fontWeight: FontWeight.w500,),
                  CustomText(
                    maxLines: 2,
                    textAlign: TextAlign.start,
                    text: "Verify it’s you — check your email for the 6-digit code:ne***************@gmail.com",fontSize: 14.sp,fontWeight: FontWeight.w400,
                    color: Color(0xFF555555),
                  ),
                  Gap(16.h),
                  ///otp field
                  OtpFieldWidget(
                    controller: _otpController,
                    onCompleted: (value) {
                      print("OTP Completed: $value");
                    },
                  ),

                  Gap(16.h),
                  ///action promot
                  ActionPromptWidget(prefixText: 'Didn’t receive the code?', actionText: 'Resend OTP (30s)', onActionTapped: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => LoginScreen()),
                    );
                  },),


                  ///reset button
                  Gap(16.h),


                  GetBuilder<VerifyOtpController>(
                    builder: (controller) {
                      return Visibility(
                        visible: controller.inProgress==false,
                        replacement: Center(child: CircularProgressIndicator(),),
                        child: CustomButton(
                            title: "Verify OTP",
                            onTap: _verifyOtp
                            ),
                      );
                    }
                  )





                ],
              ),
            ),
          ),
        ),


    );
  }

  Future<void> _verifyOtp() async {
    if (_otpController.text.isEmpty || _otpController.text.length != 6) {
      showSnackBarMessage(context, "Please enter a 6-digit OTP", true);
      return;
    }

    // Pass the text as string
    VerifyOtpModel verifyOtpModel = VerifyOtpModel(
      email: widget.email,
      verifyCode: _otpController.text, // ✅ string
    );

    final bool isSuccess = await Get.find<VerifyOtpController>().verifyOtp(verifyOtpModel);

    if (isSuccess) {
      Get.to(() => LoginScreen()); // pass instance
    } else {
      showSnackBarMessage(context, verifyOtpController.errorMessage ?? "Something went wrong", true);
    }
  }






}






