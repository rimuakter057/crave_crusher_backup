import 'package:crave_crusher/utils/app_colors/app_colors.dart';
import 'package:crave_crusher/view/components/custom_text/custom_text.dart';
import 'package:flutter/material.dart';

class ActionPromptWidget extends StatelessWidget {
  final String prefixText; // Normal text
  final String actionText; // Clickable text
  final VoidCallback onActionTapped; // Function when link tapped
  final Color prefixColor;
  final Color actionColor;
  final double fontSize;

  const ActionPromptWidget({
    super.key,
    required this.prefixText,
    required this.actionText,
    required this.onActionTapped,
    this.prefixColor = Colors.grey,
    this.actionColor = Colors.blue,
    this.fontSize = 14,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Flexible(
          child: CustomText(
            text: prefixText,
            fontSize: 14,
            fontWeight: FontWeight.w400,
            color: Color(0xFF555555),
          ),
        ),
        GestureDetector(
          onTap: onActionTapped,
          child: Padding(
            padding: const EdgeInsets.only(left: 4.0),
            child: CustomText(
              text: actionText,
              fontSize: 14,
              fontWeight: FontWeight.w500,
              color: AppColors.primary,
            ),
          ),
        ),
      ],
    );
  }
}
