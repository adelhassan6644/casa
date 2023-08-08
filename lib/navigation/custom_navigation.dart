import 'package:casa/features/auth/pages/change_password.dart';
import 'package:casa/features/auth/pages/reset_password.dart';
import 'package:casa/features/favourite/page/favourite_page.dart';
import 'package:casa/features/notifications/page/notifications_page.dart';
import 'package:casa/features/payment/pages/check_out.dart';
import 'package:casa/features/payment/pages/success_page.dart';
import 'package:casa/features/product_details/page/product_details.dart';
import 'package:casa/features/product_schedule/model/schedule_model.dart';
import 'package:casa/features/setting/pages/terms.dart';
import 'package:casa/main_models/base_model.dart';
import 'package:casa/main_page/pages/dashboard.dart';
import 'package:flutter/material.dart';
import '../features/address/page/addresses_page.dart';
import '../features/auth/pages/forget_password.dart';
import '../features/auth/pages/login.dart';
import '../features/auth/pages/register.dart';
import '../features/auth/pages/verification.dart';
import '../features/contact_with_us/page/contact_with_us.dart';
import '../features/maps/page/map_page.dart';
import '../features/on_boarding/pages/on_boarding.dart';
import '../features/payment/pages/payment_web_view.dart';
import '../features/product_schedule/page/product_schedule.dart';
import '../features/setting/pages/about_us.dart';
import '../features/splash/page/splash.dart';
import '../main.dart';
import 'routes.dart';

abstract class CustomNavigator {
  static final GlobalKey<NavigatorState> navigatorState =
      GlobalKey<NavigatorState>();
  static final RouteObserver<PageRoute> routeObserver =
      RouteObserver<PageRoute>();
  static final GlobalKey<ScaffoldMessengerState> scaffoldState =
      GlobalKey<ScaffoldMessengerState>();

  static Route<dynamic> onCreateRoute(RouteSettings settings) {
    switch (settings.name) {
      case Routes.APP:
        return _pageRoute(const MyApp());
      case Routes.SPLASH:
        return _pageRoute(const Splash());
      case Routes.ON_BOARDING:
        return _pageRoute(const OnBoarding());
      case Routes.DASHBOARD:
        return _pageRoute(const DashBoard());
      case Routes.LOGIN:
        return _pageRoute(Login(
          fromMain:
              settings.arguments != null ? settings.arguments as bool : false,
        ));
      case Routes.FORGET_PASSWORD:
        return _pageRoute(const ForgetPassword());
      case Routes.RESET_PASSWORD:
        return _pageRoute(const ResetPassword());
      case Routes.REGISTER:
        return _pageRoute(const Register());
      case Routes.CHANGE_PASSWORD:
        return _pageRoute(const ChangePassword());

      case Routes.NOTIFICATIONS:
        return _pageRoute(const NotificationsPage());
      case Routes.VERIFICATION:
        return _pageRoute(
            Verification(fromRegister: settings.arguments as bool));

      case Routes.PICK_LOCATION:
        return _pageRoute(MapPage(
            baseModel: settings.arguments != null
                ? settings.arguments as BaseModel
                : null));

      case Routes.PRODUCT_DETAILS:
        return _pageRoute(ProductDetails(id: settings.arguments as int));

      case Routes.PRODUCT_SCHEDULE:
        return _pageRoute(ProductSchedule(data: settings.arguments as Map));

      case Routes.PAYMENT_WEB_VIEW:
        return _pageRoute(PaymentWebView(id: settings.arguments as int));

      case Routes.CHECK_OUT:
        return _pageRoute(const CheckOut());

      case Routes.SUCCESS:
        return _pageRoute(SuccessPage(data: settings.arguments as Map));

      case Routes.ADDRESS:
        return _pageRoute(AddressPage(
          model: settings.arguments != null
              ? settings.arguments as ScheduleModel
              : null,
        ));

      case Routes.FAVOURITE:
        return _pageRoute(const FavouritePage());

      case Routes.CONTACT_WITH_US:
        return _pageRoute(const ContactWithUs());

      case Routes.ABOUT_US:
        return _pageRoute(const AboutUs());

      case Routes.TERMS:
        return _pageRoute(const Terms());

      default:
        return MaterialPageRoute(builder: (_) => const MyApp());
    }
  }

  static PageRouteBuilder<dynamic> _pageRoute(Widget child) => PageRouteBuilder(
      transitionDuration: const Duration(milliseconds: 100),
      reverseTransitionDuration: const Duration(milliseconds: 100),
      transitionsBuilder: (c, anim, a2, child) {
        var begin = const Offset(1.0, 0.0);
        var end = Offset.zero;
        var tween = Tween(begin: begin, end: end);
        var curveAnimation =
            CurvedAnimation(parent: anim, curve: Curves.linearToEaseOut);
        return SlideTransition(
          position: tween.animate(curveAnimation),
          child: child,
        );
      },
      opaque: false,
      pageBuilder: (_, __, ___) => child);

  static pop({dynamic result}) {
    if (navigatorState.currentState!.canPop()) {
      navigatorState.currentState!.pop(result);
    }
  }

  static push(String routeName,
      {arguments, bool replace = false, bool clean = false}) {
    if (clean) {
      return navigatorState.currentState!.pushNamedAndRemoveUntil(
          routeName, (_) => false,
          arguments: arguments);
    } else if (replace) {
      return navigatorState.currentState!.pushReplacementNamed(
        routeName,
        arguments: arguments,
      );
    } else {
      return navigatorState.currentState!
          .pushNamed(routeName, arguments: arguments);
    }
  }
}
