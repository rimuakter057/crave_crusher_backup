import 'package:crave_crusher/view/components/custom_text/custom_text.dart';
import 'package:flutter/material.dart';

class RememberMeAndForgotPassword extends StatelessWidget {
  final bool isChecked;

  final ValueChanged<bool?> onRememberMeChanged;

  final Widget child;
  const RememberMeAndForgotPassword({
    super.key,
    required this.isChecked,
    required this.onRememberMeChanged,
    required this.child,
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
              materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
            ),
            const CustomText(
              text: "Remember Me",
              fontWeight: FontWeight.w600,
              fontSize: 12,
              color: Color(0xFF555555),
            ),
          ],
        ),

        // 2. Forget Password Text Link
        child,
      ],
    );
  }
}
