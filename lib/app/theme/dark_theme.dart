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
    primary: Colors.white, textStyle: const TextStyle(color: Colors.white),
  )),
  pageTransitionsTheme: const PageTransitionsTheme(builders: {
    TargetPlatform.android: CupertinoPageTransitionsBuilder(),
    TargetPlatform.iOS: CupertinoPageTransitionsBuilder(),
    TargetPlatform.fuchsia:CupertinoPageTransitionsBuilder(),
  }),

  textTheme: const TextTheme(

    button: TextStyle(color: Color(0xFF252525)),

    headline1: TextStyle(fontWeight: FontWeight.w300, fontSize: Dimensions.FONT_SIZE_DEFAULT),
    headline2: TextStyle(fontWeight: FontWeight.w400, fontSize: Dimensions.FONT_SIZE_DEFAULT),
    headline3: TextStyle(fontWeight: FontWeight.w500, fontSize: Dimensions.FONT_SIZE_DEFAULT),
    headline4: TextStyle(fontWeight: FontWeight.w600, fontSize: Dimensions.FONT_SIZE_DEFAULT),
    headline5: TextStyle(fontWeight: FontWeight.w700, fontSize: Dimensions.FONT_SIZE_DEFAULT),
    headline6: TextStyle(fontWeight: FontWeight.w800, fontSize: Dimensions.FONT_SIZE_DEFAULT),
    caption: TextStyle(fontWeight: FontWeight.w900, fontSize: Dimensions.FONT_SIZE_DEFAULT),

    subtitle1: TextStyle(fontSize: 15.0, fontWeight: FontWeight.w500),
    bodyText2: TextStyle(fontSize: 12.0),
    bodyText1: TextStyle(fontSize: 14.0, fontWeight: FontWeight.w600),
  ),
);
