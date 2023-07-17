import 'package:flutter/cupertino.dart';

import '../../../navigation/custom_navigation.dart';

class Dimensions {
  static const double FONT_SIZE_EXTRA_SMALL = 10.0;
  static const double FONT_SIZE_SMALL = 12.0;
  static const double FONT_SIZE_DEFAULT = 14.0;
  static const double FONT_SIZE_LARGE = 16.0;
  static const double FONT_SIZE_EXTRA_LARGE = 18.0;
  static const double FONT_SIZE_OVER_LARGE = 24.0;

  static const double PADDING_SIZE_EXTRA_SMALL = 8.0;
  static const double PADDING_SIZE_SMALL = 16.0;
  static const double PADDING_SIZE_DEFAULT = 18.0;
  static const double PADDING_SIZE_LARGE = 25.0;
  static const double PADDING_SIZE_EXTRA_LARGE = 30.0;


  static const double RADIUS_DEFAULT = 30.0;
  static const double RADIUS_LARGE = 16.0;
  static const double RADIUS_EXTRA_LARGE = 20.0;

}
extension ScreenScale on num {
  double get w =>
      MediaQuery.of(CustomNavigator.navigatorState.currentContext!).size.width *
          (toDouble() / 390);
  double get h =>
      MediaQuery.of(CustomNavigator.navigatorState.currentContext!)
          .size
          .height *
          (toDouble() / 844);
}