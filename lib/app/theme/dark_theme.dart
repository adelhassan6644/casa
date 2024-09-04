import 'package:flutter/material.dart';
import '../core/utils/app_strings.dart';
import '../core/utils/dimensions.dart';

ThemeData dark = ThemeData(
  fontFamily: AppStrings.fontFamily,
  primaryColor: const Color(0xFF7338A4),
  brightness: Brightness.dark,
  scaffoldBackgroundColor: Colors.black,
  // accentColor: const Color(0xFF252525),
  hintColor: const Color(0xFFE7F6F8),
  appBarTheme: const AppBarTheme(
    backgroundColor:Colors.black,
  ),
  focusColor: const Color(0xFFADC4C8),

  textButtonTheme: TextButtonThemeData(style: TextButton.styleFrom(
    foregroundColor: Colors.white, textStyle: const TextStyle(color: Colors.white),
  )),
  pageTransitionsTheme: const PageTransitionsTheme(builders: {
    TargetPlatform.android: CupertinoPageTransitionsBuilder(),
    TargetPlatform.iOS: CupertinoPageTransitionsBuilder(),
    TargetPlatform.fuchsia:CupertinoPageTransitionsBuilder(),
  }),

  textTheme: const TextTheme(

    labelLarge: TextStyle(color: Color(0xFF252525)),

    displayLarge: TextStyle(fontWeight: FontWeight.w300, fontSize: Dimensions.FONT_SIZE_DEFAULT),
    displayMedium: TextStyle(fontWeight: FontWeight.w400, fontSize: Dimensions.FONT_SIZE_DEFAULT),
    displaySmall: TextStyle(fontWeight: FontWeight.w500, fontSize: Dimensions.FONT_SIZE_DEFAULT),
    headlineMedium: TextStyle(fontWeight: FontWeight.w600, fontSize: Dimensions.FONT_SIZE_DEFAULT),
    headlineSmall: TextStyle(fontWeight: FontWeight.w700, fontSize: Dimensions.FONT_SIZE_DEFAULT),
    titleLarge: TextStyle(fontWeight: FontWeight.w800, fontSize: Dimensions.FONT_SIZE_DEFAULT),
    bodySmall: TextStyle(fontWeight: FontWeight.w900, fontSize: Dimensions.FONT_SIZE_DEFAULT),

    titleMedium: TextStyle(fontSize: 15.0, fontWeight: FontWeight.w500),
    bodyMedium: TextStyle(fontSize: 12.0),
    bodyLarge: TextStyle(fontSize: 14.0, fontWeight: FontWeight.w600),
  ),
);
