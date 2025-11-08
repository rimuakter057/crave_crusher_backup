import 'package:crave_crusher/view/components/custom_app_bar/custom_app_bar.dart';
import 'package:crave_crusher/view/components/custom_nav_bar/navbar.dart';
import 'package:flutter/material.dart';

class BattleScreen extends StatelessWidget {
  const BattleScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: ,
      appBar: CustomAppBar(title: 'My Battle'),

      bottomNavigationBar: NavBar(currentIndex: 1),
    );
  }
}
