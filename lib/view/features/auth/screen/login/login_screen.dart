import 'package:crave_crusher/core/routes/app_routes.dart';
import 'package:crave_crusher/utils/app_colors/app_colors.dart';
import 'package:crave_crusher/view/components/custom_button/custom_button.dart';
import 'package:crave_crusher/view/components/custom_text/custom_text.dart';
import 'package:crave_crusher/view/components/input_field_with_title/input_field_with_title.dart';
import 'package:crave_crusher/view/components/input_password_field_widget/input_password_field_widget.dart';
import 'package:crave_crusher/view/components/show_snakbar/show_snakbar.dart';
import 'package:crave_crusher/view/features/auth/controllers/forget_password_controller.dart';
import 'package:crave_crusher/view/features/auth/controllers/login_controller.dart';
import 'package:crave_crusher/view/features/auth/models/login_model.dart';
import 'package:crave_crusher/view/features/auth/screen/sign_up/sign_up_screen.dart';
import 'package:crave_crusher/view/features/auth/screen/verify_account/verify_account_screen.dart';
import 'package:crave_crusher/view/features/auth/screen/verify_identity/verify_identity_screen.dart';
import 'package:crave_crusher/view/features/auth/screen/widgets/action_promote_widget.dart';
import 'package:crave_crusher/view/features/auth/screen/widgets/or_divider_widget.dart';
import 'package:crave_crusher/view/features/auth/screen/widgets/remember_me_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';

import '../../models/user_model.dart';


class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {

  final bool _rememberMe = false;
 final TextEditingController _emailController=TextEditingController();
  final TextEditingController _passwordController=TextEditingController();


  GlobalKey<FormState>  _key = GlobalKey<FormState>();
 final LogInController logInController = Get.find<LogInController>();
final ForgetPasswordController forgetPasswordController =Get.find<ForgetPasswordController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            child: Padding(
              padding:  EdgeInsets.symmetric(horizontal: 16.w),
              child: Form(
                key: _key,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    ///login text
                    CustomText(
            
                      textAlign: TextAlign.start,
                      text: "Welcome Back",fontSize: 30.sp,fontWeight: FontWeight.w500,),
                    CustomText(
                      maxLines: 2,
                      textAlign: TextAlign.start,
                      text: "Let’s continue your journey to crush those cravings!",fontSize: 14.sp,fontWeight: FontWeight.w400,
                    color: Color(0xFF555555),
                    ),
                    Gap(24.h),
                    ///input field
                     InputFieldWithTitleWidget(title: "Email Address", hintText: "Enter your email",
                     controller: _emailController,
                         validator: (String? value) {
                           if (value?.trim().isEmpty ?? true) {
                             return "Enter Your Email";
                           }
                           return null;
                         },
                     ),
            
            
                    Gap(16.h),
                    InputPasswordFieldWidget(title: "Password",
                    controller: _passwordController,
                      validator: (String? value) {
                        if (value?.isEmpty ?? true && _passwordController.text.length<6) {
                          return "Enter Your password minimum length 6";
                        }
                        return null;
                      },
                    ),
            
                    ///remember and forgot section
                    RememberMeAndForgotPassword(
                      isChecked: _rememberMe,
                      onRememberMeChanged: (bool? newValue){},
                    child:  GetBuilder<ForgetPasswordController>(
                      builder: (controller) {
                        return Visibility(
                          visible: controller.inProgress==false,
                          replacement: Center(child: CircularProgressIndicator(),),
                          child: TextButton(
                            onPressed: _forgetButtonTap,
                            child: CustomText(text:"Forget Password?",fontWeight: FontWeight.w600,fontSize: 12,color: AppColors.primary,),

                          ),
                        );
                      }
                    ),
                    ),
                    OrDivider(),
                    Gap(24.h),
                    ActionPromptWidget(prefixText: 'Don’t have an account?', actionText: 'Sign Up Now', onActionTapped: () {


                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => SignUpScreen()),
                      );
                    },),
                    Gap(24.h),
                    ///login button

                    /// Sign Up Button with loader
                    GetBuilder<LogInController>(
                      builder: (controller) {
                        return Visibility(
                          visible: controller.inProgress == false,
                          replacement: Center(child: CircularProgressIndicator()),
                          child: CustomButton(
                            title: "Log In",
                            onTap: _signInButtonTap, // <-- calls separate method
                          ),
                        );
                      },
                    ),


                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    
    );
  }

///sign in button
  Future <void> _signInButtonTap()async{
    if (_key.currentState!.validate()){

      LogInModel logInModel = LogInModel(email: _emailController.text, password: _passwordController.text);
      final bool isSuccess =await logInController.logIn(logInModel);

      if(isSuccess){

        Get.offNamed(AppRoutes.emptyHome);
      }else{
        showSnackBarMessage(context, logInController.errorMessage!, true);
      }

    }
  }


  ///forget button
  Future <void> _forgetButtonTap()async{

   // _emailController.text.isEmpty?  Get.snackbar("Error", "Please Enter Your Email"):  Get.to(VerifyIdentityScreen(email: _emailController.text,));


    final bool isSuccess=  await forgetPasswordController.forgetPassword(_emailController.text);

     if(isSuccess && _emailController.text.isNotEmpty){
       Get.to(VerifyIdentityScreen(email: _emailController.text));
     }else {
       Get.snackbar("Error", "Please Enter Your Email");
     }


  }


  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }


}
