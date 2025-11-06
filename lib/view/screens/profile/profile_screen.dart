import 'package:crave_crusher/view/components/custom_nav_bar/navbar.dart';
import 'package:flutter/material.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(bottomNavigationBar: NavBar(currentIndex: 4));
  }
}
