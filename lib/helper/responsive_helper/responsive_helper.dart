// ignore_for_file: unused_field

import 'package:flutter/material.dart';

/// Responsive Helper for perfect scaling on iPhone and iPad
class ResponsiveHelper {
  static late double _screenWidth;
  static late double _screenHeight;
  static late bool _isTablet;

  /// Initialize responsive helper
  static void init(BuildContext context) {
    final size = MediaQuery.of(context).size;
    _screenWidth = size.width;
    _screenHeight = size.height;
    _isTablet = _screenWidth > 600;
  }

  /// Check if device is tablet
  static bool get isTablet => _isTablet;

  /// Get responsive font size
  static double fontSize(double phoneSize) {
    if (_isTablet) {
      // Scale up for tablets but not too much
      if (_screenWidth > 800) {
        return phoneSize * 1.3; // iPad Pro
      }
      return phoneSize * 1.15; // iPad mini/regular
    }
    return phoneSize;
  }

  /// Get responsive spacing
  static double spacing(double phoneSpacing) {
    if (_isTablet) {
      if (_screenWidth > 800) {
        return phoneSpacing * 1.4;
      }
      return phoneSpacing * 1.2;
    }
    return phoneSpacing;
  }

  /// Get responsive padding
  static double padding(double phonePadding) {
    if (_isTablet) {
      return phonePadding * 2.5;
    }
    return phonePadding;
  }

  /// Get max content width
  static double get maxContentWidth {
    if (_isTablet) {
      return _screenWidth > 800 ? 600 : 500;
    }
    return _screenWidth;
  }

  /// Get responsive width multiplier
  static double width(double phoneWidth) {
    if (_isTablet) {
      return phoneWidth * 1.2;
    }
    return phoneWidth;
  }

  /// Get responsive height multiplier
  static double height(double phoneHeight) {
    if (_isTablet) {
      return phoneHeight * 1.2;
    }
    return phoneHeight;
  }
}
