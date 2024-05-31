import 'package:flutter/material.dart';

class AppPalette {
  // Common Colors
  static const Color blackColor = Colors.black;
  static const Color blueColor = Colors.blue;
  static const Color purpleColor = Color.fromRGBO(103, 58, 183, 1);
  static const Color whiteColor = Colors.white;
  static const Color greyColor = Colors.grey;
  static const Color transparentColor = Colors.transparent;

  // Light Theme Colors
  static const Color lightBackgroundColor = whiteColor;
  static Color lightPrimaryColor = Colors.grey.shade300;
  static Color lightAccentColor = Colors.grey.shade500;
  static Color lightBorderColor = Colors.grey.shade200;
  static Color lightGreyColor = Colors.grey.shade200;

  // Dark Theme Colors
  static const Color darkBackgroundColor = blackColor;
  static Color darkPrimaryColor = Colors.grey.shade800;
  static Color darkAccentColor = Colors.grey.shade600;
  static Color darkBorderColor = Colors.grey.shade900;
  static Color darkGreyColor = Colors.grey.shade800;

  // Error Color (common for light and dark theme)
  static const Color errorColor = Colors.redAccent;

  // Additional shades of grey 
  static Color greyShade1 = Colors.grey.shade100;
  static Color greyShade2 = Colors.grey.shade500;
  static Color greyShade3 = Colors.grey.shade700;
}
