import 'package:crave_crusher/utils/app_colors/app_colors.dart';
import 'package:crave_crusher/view/components/custom_text/custom_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';



class CustomProfileMenu extends StatelessWidget {
  const CustomProfileMenu({
    super.key, required this.text, required this.icon, required this.onTap, this.textColor, this.iconColor,
  });
  final String text;
  final Icon icon;
  final void Function() onTap;
 final Color? textColor;
 final Color? iconColor;


  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap:onTap,
      child: Container(
        decoration: BoxDecoration(
          border: Border.all(color: Colors.grey.shade200), // Grey border
          borderRadius: BorderRadius.circular(8), // Rounded corners (optional)
        ),
        child:ListTile(

          horizontalTitleGap: 4.w,



          iconColor: iconColor ?? AppColors.primary,

          leading: IconTheme(
            data: IconThemeData(
              size: 24, // auto size for any icon
              color: iconColor ?? AppColors.primary, // auto color
            ),
            child: icon,
          ),

          title: CustomText(
            text: text,
            color: textColor ?? AppColors.primary,
          ),

          trailing: Icon(
            Icons.arrow_forward_ios,
            size: 20,
          ),
        ),

      ),
    );
  }
}