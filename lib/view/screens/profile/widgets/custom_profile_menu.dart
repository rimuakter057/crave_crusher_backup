import 'package:crave_crusher/utils/app_colors/app_colors.dart';
import 'package:crave_crusher/view/components/custom_text/custom_text.dart';
import 'package:flutter/material.dart';

import '../my_profile/my_profile_screen.dart';


class CustomProfileMenu extends StatelessWidget {
  const CustomProfileMenu({
    super.key, required this.text, required this.icon, required this.onTap,
  });
  final String text;
  final Icon icon;
  final void Function() onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap:onTap,
      child: Container(
        decoration: BoxDecoration(
          border: Border.all(color: Colors.grey.shade200), // Grey border
          borderRadius: BorderRadius.circular(8), // Rounded corners (optional)
        ),
        child: ListTile(

          iconColor: AppColors.primary,
          leading: icon,
          title: CustomText(text:text, color: AppColors.primary),
          trailing: Icon(Icons.arrow_forward_ios),

        ),
      ),
    );
  }
}