import 'package:flutter/material.dart';
import 'package:pin_code_fields/pin_code_fields.dart';

class OtpFieldWidget extends StatelessWidget {
  final int length;
  final ValueChanged<String>? onCompleted;
 final TextEditingController? controller;
  const OtpFieldWidget({
    super.key,
    this.length = 6,
    this.onCompleted, this.controller,
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
        activeColor: const Color(0xFFEEF2FF),
        inactiveColor: const Color(0xFFEEF2FF),
        selectedColor: const Color(0xFFEEF2FF),
        activeFillColor: const Color(0xFFEEF2FF),
        selectedFillColor: const Color(0xFFEEF2FF),
        inactiveFillColor: const Color(0xFFEEF2FF),
      ),

      onChanged: (value) {},
       controller:controller ,
      onCompleted: (value) {
        onCompleted?.call(value);
      },
    );
  }
}
