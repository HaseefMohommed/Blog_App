import 'package:blog_app/core/theme/app_pallete.dart';
import 'package:flutter/material.dart';

class AppTheme {
  static _border([Color color = AppPalette.blackColor]) => OutlineInputBorder(
        borderSide: BorderSide(
          color: color,
          width: 3,
        ),
        borderRadius: BorderRadius.circular(10),
      );

  static final lightThemeMode = ThemeData(
    scaffoldBackgroundColor: AppPalette.lightBackgroundColor,
    appBarTheme: AppBarTheme(
      backgroundColor: AppPalette.lightPrimaryColor,
      iconTheme: const IconThemeData(
        color: AppPalette.blackColor,
      ),
      toolbarTextStyle: TextTheme(
        headline6: TextStyle(
          color: AppPalette.darkGreyColor,
          fontSize: 20,
        ),
      ).bodyText2,
      titleTextStyle: TextTheme(
        headline6: TextStyle(
          color: AppPalette.darkGreyColor,
          fontSize: 20,
        ),
      ).headline6,
    ),
    inputDecorationTheme: InputDecorationTheme(
      contentPadding: const EdgeInsets.all(27),
      border: _border(AppPalette.lightBorderColor),
      enabledBorder: _border(AppPalette.lightBorderColor),
      focusedBorder: _border(AppPalette.blackColor),
      errorBorder: _border(AppPalette.errorColor),
    ),
    chipTheme: ChipThemeData(
      backgroundColor: AppPalette.greyShade2,
      side: BorderSide.none,
    ),
    floatingActionButtonTheme: const FloatingActionButtonThemeData(
      backgroundColor: AppPalette.blackColor,
    ),
    bottomAppBarTheme: BottomAppBarTheme(
      color: AppPalette.lightGreyColor,
    ),
  );

  static final darkThemeMode = ThemeData.dark().copyWith(
    scaffoldBackgroundColor: AppPalette.darkBackgroundColor,
    appBarTheme: AppBarTheme(
      backgroundColor: AppPalette.darkBackgroundColor,
      iconTheme: const IconThemeData(
        color: AppPalette.whiteColor,
      ),
      toolbarTextStyle: const TextTheme(
        headline6: TextStyle(color: AppPalette.blackColor, fontSize: 20),
      ).bodyText2,
      titleTextStyle: const TextTheme(
        headline6: TextStyle(color: AppPalette.blackColor, fontSize: 20),
      ).headline6,
    ),
    inputDecorationTheme: InputDecorationTheme(
      contentPadding: const EdgeInsets.all(27),
      border: _border(AppPalette.darkBorderColor),
      enabledBorder: _border(AppPalette.darkBorderColor),
      focusedBorder: _border(AppPalette.greyShade2),
      errorBorder: _border(AppPalette.errorColor),
    ),
    chipTheme:const ChipThemeData(
      backgroundColor: AppPalette.blackColor,
      side: BorderSide.none,
    ),

    floatingActionButtonTheme: const FloatingActionButtonThemeData(
      backgroundColor: AppPalette.greyColor,
    ),
    bottomAppBarTheme: BottomAppBarTheme(
      color: AppPalette.darkGreyColor,
    ),

  );
}
