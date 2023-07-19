import 'package:app_settings/app_settings.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';

import '../navigation/custom_navigation.dart';

abstract class LocationHelper {
  static checkLocation({bool isSplash = true}) async {
    bool serviceEnabled;
    LocationPermission permission;

    // Test if location services are enabled.
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      // Location services are not enabled don't continue
      // accessing the position and request users of the
      // App to enable the location services.
      showCustomDialog(isSplash: isSplash);
      Future.error('Location services are disabled.');
      return false;
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        permission = await Geolocator.requestPermission();
        await showCustomDialog(isSplash: isSplash);
        Future.error('Location permissions are denied');
        return false;
      }
    }

    if (permission == LocationPermission.deniedForever) {
      // Permissions are denied forever, handle appropriately.
      permission = await Geolocator.requestPermission();
      await showCustomDialog(isSplash: isSplash);
      Future.error(
          'Location permissions are permanently denied, we cannot request permissions.');
      return false;
    }
    // When we reach here, permissions are granted and we can
    // continue accessing the position of the device.
    return true;
  }

  static showCustomDialog({bool isSplash = true}) {
    showDialog(
        context: CustomNavigator.navigatorState.currentContext!,
        builder: (_) => CupertinoAlertDialog(
              title: const Text("هل تريد السماح لتطبيق “casa” باستخدام موقعك؟"),
              content: const Text(
                  "لإجراء رحلة مضمونه، يجمع في طريقي بيانات الموقع بداءاً من وقت فتح التطبيق. ويعمل ذلك على تحسين عمليات الالتقاء بالكباتن، ونسب التوافق، وغير ذلك الكثير."),
              actions: [
                CupertinoDialogAction(
                    child: const Text("OK"),
                    onPressed: () async {
                      CustomNavigator.pop();
                      // AppSettings.openLocationSettings(asAnotherTask: true);
                    }),
                CupertinoDialogAction(
                    child: const Text("Cancel"),
                    onPressed: () async {
                      CustomNavigator.pop();
                    }),
              ],
            ));
  }
}
