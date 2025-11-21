

import 'package:crave_crusher/view/components/custom_text/custom_text.dart';
import 'package:flutter/material.dart';

class OrDivider extends StatelessWidget {
  const OrDivider({super.key});

  @override
  Widget build(BuildContext context) {
    // Defines the color for the dividing lines
    const Color dividerColor = Color(0xFF555555);

    return const Row(
      children: [
        // Left Divider Line
        Expanded(
          child: Divider(
            color: dividerColor,
            thickness: 1.5, // Line thickness
          ),
        ),

        // "OR" Text in the center
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 10.0),
          child: CustomText(text: "OR",),
        ),

        // Right Divider Line
        Expanded(
          child: Divider(
            color: dividerColor,
            thickness: 1.5,
          ),
        ),
      ],
    );
  }
}