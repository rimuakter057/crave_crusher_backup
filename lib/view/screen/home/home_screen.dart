import 'package:crave_crusher/view/components/custom_nav_bar/navbar.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(bottomNavigationBar: NavBar(currentIndex: 0));
  }
}
