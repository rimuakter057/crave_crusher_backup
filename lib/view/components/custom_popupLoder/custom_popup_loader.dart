import 'package:crave_crusher/helper/responsive_helper/responsive_helper.dart';
import 'package:crave_crusher/utils/app_colors/app_colors.dart';
import 'package:crave_crusher/view/components/custom_loader/custom_loader.dart';

import 'package:flutter/material.dart';

class CustomPopUpLoader {
  static void show(BuildContext context, {String message = "Loading..."}) {
    showDialog(
      context: context,
      barrierDismissible: false, // Prevent user from closing it manually
      builder: (BuildContext context) {
        return Dialog(
          backgroundColor: Colors.transparent,
          child: Container(
            padding:  EdgeInsets.all(ResponsiveHelper.padding(20),),
            decoration: BoxDecoration(
              color: Colors.transparent,
              borderRadius: BorderRadius.circular(ResponsiveHelper.borderRadius(10),),
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const CustomLoader(),
                 SizedBox(height: ResponsiveHelper.height(20),),
                Text(
                  message,
                  style:  TextStyle(
                    fontSize:ResponsiveHelper.fontSize(16),
                    fontWeight: FontWeight.bold,
                    color: AppColors.primary,
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  static void hide(BuildContext context) {
    Navigator.pop(context);
  }
}
