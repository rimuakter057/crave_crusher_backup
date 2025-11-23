import 'package:flutter/material.dart';
import 'package:pin_code_fields/pin_code_fields.dart';

class OtpFieldWidget extends StatefulWidget {
  final int length;
  final ValueChanged<String>? onCompleted;

  const OtpFieldWidget({
    super.key,
    this.length = 6,
    this.onCompleted,
  });

  @override
  State<OtpFieldWidget> createState() => _OtpFieldWidgetState();
}

class _OtpFieldWidgetState extends State<OtpFieldWidget> {
  TextEditingController? _controller;
  bool _isTyping = false;

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController();
  }

  @override
  void dispose() {
    _controller?.dispose();
    _controller = null;
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: [
        PinCodeTextField(
          appContext: context,
          length: widget.length,
          controller: _controller,
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
            activeColor: Color(0xFFEEF2FF),
            inactiveColor: Color(0xFFEEF2FF),
            selectedColor: Color(0xFFEEF2FF),
            activeFillColor: Color(0xFFEEF2FF),
            selectedFillColor: Color(0xFFEEF2FF),
            inactiveFillColor: Color(0xFFEEF2FF),
          ),
          onChanged: (value) {
            if (!mounted) return;
            setState(() {
              _isTyping = value.isNotEmpty;
            });
          },
          onCompleted: (value) {
            if (!mounted) return;
            if (widget.onCompleted != null) {
              widget.onCompleted!(value);
            }
          },
        ),
      ],
    );
  }
}
