import 'package:flutter/material.dart';

abstract class ColorResources {
  static const Color BORDER_COLOR = Color(0xFF9C6FBF);
  static const Color SECOUND_PRIMARY_COLOR = Color(0xFFB48DD2);
  static const Color PRIMARY_COLOR = Color(0xffFF4F65);
  static const Color APP_BAR_BACKGROUND_COLOR = Color(0xffFFF9F9);
  static const Color BACKGROUND_COLOR = Color(0xFFFAFAFA);
  static const Color CONTAINER_BACKGROUND_COLOR = Color(0xffF3F3F3);
  static const Color BLUE_COLOR = Color(0xff3A5ACD);
  static const Color SYSTEM_COLOR = Color(0xff007AFF);
  static const Color RATE_COLOR = Color(0xffFFC600);
  static const Color NAV_BAR_BACKGROUND_COLOR = Color(0xFFFFFFFF);
  static const Color ACCENT_PRIMARY_COLOR = Color(0xffF7F1FC);
  static const Color ACTIVE = Color(0xff209370);
  static const Color IN_ACTIVE = Color(0xFFDB5353);
  static const Color PENDING = Color(0xFFF1A129);
  static const Color PLACE_HOLDER = Color(0xFF7F8B93);
  static const Color FILL_COLOR = Color(0xFFFFFFFF);
  static const Color PROGRASS_BACKGROUND = Color(0xffE7E7E7);
  static const Color DISABLED = Color(0xFF969696);
  static const Color WHITE_COLOR = Color(0xFFFFFFFF);
  static const Color SMOKED_WHITE_COLOR = Color(0xFFFAFAFA);
  static const Color OFFER_COLOR = Color(0xff22BB55);
  static const Color LOGOUT_COLOR = Color(0xffDF4759);
  static const Color GREEN = Color(0xff34C759);
  static const Color GREY_BORDER = Color(0xFFF5F5F5);
  static const Color LIGHT_BORDER_COLOR = Color(0xffE8ECF4);
  static const Color ALERT_COLOR = Color(0xffDBAB02);
  static const Color FAILED_COLOR = Colors.red;
  static const Color ERORR_COLOR = Color(0xFFFF4F65);
  static const Color RED_COLOR = Color(0xffFF3B30);
   static const Color HEADER = Color(0xFF530B8B);
  static const Color TITLE = Color(0xFF151416);
  static const Color SUBTITLE = Color(0xff373737);
  static const Color DETAILS_COLOR = Color(0xff737373);
  static const Color HINT_COLOR = Color(0xffA5B7B8);


  static const Color SPLASH_BACKGROUND_COLOR = Color(0xff530B8B);


  static tripStatus(status) {
    if (status == "pending") {
      return DISABLED;
    } else if (status == "pay") {
      return PRIMARY_COLOR;
    } else if (status == "replay") {
      return PRIMARY_COLOR;
    } else {
      return WHITE_COLOR;
    }
  }
}
