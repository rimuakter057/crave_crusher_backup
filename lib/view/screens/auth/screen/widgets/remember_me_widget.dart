import 'package:crave_crusher/utils/app_colors/app_colors.dart';
import 'package:crave_crusher/view/components/custom_text/custom_text.dart';
import 'package:flutter/material.dart';

class RememberMeAndForgotPassword extends StatelessWidget {
  // Required: The current state of the Checkbox
  final bool isChecked;
  // Required: The function to call when the Checkbox state changes
  final ValueChanged<bool?> onRememberMeChanged;
  // Required: The function to call when the "Forget Password" link is tapped
  final VoidCallback onForgotPasswordTapped;

  const RememberMeAndForgotPassword({
    super.key,
    required this.isChecked,
    required this.onRememberMeChanged,
    required this.onForgotPasswordTapped,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        // 1. Remember Me Checkbox and Text
        Row(
          children: [
            Checkbox(
              value: isChecked,
              onChanged: onRememberMeChanged,
            ),
            const  CustomText(text: "Forget Password?",fontWeight: FontWeight.w600,fontSize: 12,color: Color(0xFF555555)),
          ],
        ),

        // 2. Forget Password Text Link
        TextButton(
          onPressed: onForgotPasswordTapped,
          child: CustomText(text: "Forget Password?",fontWeight: FontWeight.w600,fontSize: 12,color: AppColors.primary,),

        ),
      ],
    );
  }
}