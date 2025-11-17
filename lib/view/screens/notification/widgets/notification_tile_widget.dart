import 'package:crave_crusher/utils/app_colors/app_colors.dart';
import 'package:crave_crusher/view/components/custom_text/custom_text.dart';
import 'package:flutter/material.dart';

class NotificationTileWidget extends StatelessWidget {
  final String title;
  final String subtitle;
  final Widget? leading;
  final Widget? trailing;

  const NotificationTileWidget({
    super.key,
    required this.title,
    required this.subtitle,
    this.leading,
    this.trailing,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: ListTile(

        leading: leading,
        title:CustomText(
          textAlign: TextAlign.start,
          text: title,
        fontWeight: FontWeight.w500,
        fontSize: 14,
          color:AppColors.black,
        ),


        subtitle: CustomText(
             maxLines: 8,
            textAlign: TextAlign.start,
            text: subtitle,
          fontWeight: FontWeight.w400,
          fontSize: 10,
          color:Color(0xFFA1A1AA)
        ),




        trailing: trailing,
      ),
    );
  }
}
