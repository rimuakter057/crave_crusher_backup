import 'package:crave_crusher/utils/app_colors/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:pin_code_fields/pin_code_fields.dart';

class OtpFieldWidget extends StatelessWidget {
  final int length;
  final ValueChanged<String>? onCompleted;
  final TextEditingController? controller;
  const OtpFieldWidget({
    super.key,
    this.length = 6,
    this.onCompleted,
    this.controller,
  });

  @override
  Widget build(BuildContext context) {
    return PinCodeTextField(
      appContext: context,
      length: length,
      keyboardType: TextInputType.number,
      animationType: AnimationType.fade,
      enableActiveFill: true,

      textStyle: const TextStyle(
        color: Colors.grey,
        fontSize: 20,
        fontWeight: FontWeight.bold,
      ),

      pinTheme: PinTheme(
        shape: PinCodeFieldShape.box,
        borderRadius: BorderRadius.circular(8),
        fieldHeight: 50,
        fieldWidth: 50,
        activeColor: AppColors.naveBordar,
        inactiveColor: AppColors.naveBordar,
        selectedColor: AppColors.naveBordar,
        activeFillColor: AppColors.naveBordar,
        selectedFillColor: AppColors.naveBordar,
        inactiveFillColor: AppColors.naveBordar,
      ),

      onChanged: (value) {},
      controller: controller,
      onCompleted: (value) {
        onCompleted?.call(value);
      },
    );
  }
}
