import 'package:crave_crusher/helper/responsive_helper/responsive_helper.dart';
import 'package:flutter/material.dart';

void showSnackBarMessage(
  BuildContext context,
  String message, [
  bool isError = false,
]) {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      content: Text(message),
      backgroundColor: isError ? Colors.red : Colors.green,
      behavior:
          SnackBarBehavior.floating, // floating makes it appear above bottom
      margin: EdgeInsets.only(
        top: ResponsiveHelper.height(20), // top position
        left:ResponsiveHelper.width(16), // side padding
        right: ResponsiveHelper.width(16), // side padding
      ),
    ),
  );
}
