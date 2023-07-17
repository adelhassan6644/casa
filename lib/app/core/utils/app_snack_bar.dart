import 'dart:async';
import 'package:casa/app/core/utils/dimensions.dart';
import 'package:casa/app/core/utils/extensions.dart';
import 'package:casa/app/core/utils/text_styles.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:motion_toast/motion_toast.dart';
import 'package:motion_toast/resources/arrays.dart';
import '../../../navigation/custom_navigation.dart';
import '../../localization/localization/language_constant.dart';
import 'color_resources.dart';

class AppNotification {
  final String message;
  final String? iconName;
  final Color backgroundColor;
  final Color borderColor;
  final bool isFloating;
  late final double radius;
  final Widget? action;
  final bool withAction;
  final void Function()? onVisible;
  AppNotification(
      {required this.message,
      this.onVisible,
      this.iconName,
      this.backgroundColor = Colors.black,
      this.borderColor = Colors.transparent,
      this.isFloating = false,
      this.withAction = false,
      this.action,
      double? radius}) {
    this.radius = radius ?? (isFloating ? 15 : 0);
  }
}

class CustomSnackBar {
  static showSnackBar({required AppNotification notification}) {
    Timer(Duration.zero, () {
      CustomNavigator.scaffoldState.currentState!.showSnackBar(
        SnackBar(
          padding: const EdgeInsets.all(0),
          duration: const Duration(seconds: 2),
          behavior: notification.isFloating
              ? SnackBarBehavior.floating
              : SnackBarBehavior.fixed,
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(notification.radius),
              side: BorderSide(width: 1, color: notification.borderColor)),
          margin: notification.isFloating ? EdgeInsets.all(24.w) : null,
          onVisible: notification.onVisible,
          content: SizedBox(
            height: notification.withAction ? null : 60.h,
            child: Row(
              children: [
                if (notification.iconName != null)
                  Image.asset(
                    notification.iconName!,
                    height: 20.h,
                    width: 20.w,
                  ),
                if (notification.iconName == null) SizedBox(width: 24.w),
                Expanded(
                  child: Text(
                    notification.message,
                    style: AppTextStyles.semiBold.copyWith(fontSize: 13),
                  ),
                ),
                if (notification.withAction)
                  notification.action ?? const SizedBox(),
              ],
            ),
          ),
          backgroundColor: notification.backgroundColor,
        ),
      );
    });
  }

  static hideSnackBar() {
    CustomNavigator.scaffoldState.currentState!
        .hideCurrentSnackBar(reason: SnackBarClosedReason.remove);
  }
}

showToast(msg, {Color? backGroundColor, Color? textColor, Toast? toastLength}) {
  return Fluttertoast.showToast(
      msg: msg,
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.TOP,
      timeInSecForIosWeb: 1,
      backgroundColor: backGroundColor ?? Colors.black.withOpacity(0.5),
      textColor: textColor ?? ColorResources.WHITE_COLOR,
      fontSize: 16.0);
}

successMotionToast(msg,
    {MotionToastPosition? position, AnimationType? animationType}) {
  return MotionToast.success(
    title: Text(
      getTranslated("success", CustomNavigator.navigatorState.currentContext!),
      style: AppTextStyles.semiBold
          .copyWith(fontSize: 13, color: ColorResources.ACTIVE),
    ),
    description: Text(
      msg,
      style: AppTextStyles.regular
          .copyWith(fontSize: 11, color: ColorResources.ACTIVE),
    ),
    height: 70.h,
    width: CustomNavigator.navigatorState.currentContext!.width - 60.w,
    layoutOrientation: ToastOrientation.ltr,
    animationType: animationType ?? AnimationType.fromTop,
    position: position ?? MotionToastPosition.top,
  ).show(CustomNavigator.navigatorState.currentContext!);
}

errorMotionToast(msg,
    {MotionToastPosition? position, AnimationType? animationType}) {
  return MotionToast.error(
    title: Text(
      getTranslated("error", CustomNavigator.navigatorState.currentContext!),
      style: AppTextStyles.semiBold
          .copyWith(fontSize: 13, color: ColorResources.IN_ACTIVE),
    ),
    description: Text(
      msg,
      style: AppTextStyles.regular
          .copyWith(fontSize: 11, color: ColorResources.IN_ACTIVE),
    ),
    height: 70.h,
    width: CustomNavigator.navigatorState.currentContext!.width - 60.w,
    layoutOrientation: ToastOrientation.ltr,
    animationType: animationType ?? AnimationType.fromTop,
    position: position ?? MotionToastPosition.top,
  ).show(CustomNavigator.navigatorState.currentContext!);
}
