import 'dart:developer';

import 'package:casa/features/setting/provider/config_provider.dart';
import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import '../../../app/core/utils/app_snack_bar.dart';
import '../../../app/core/utils/styles.dart';
import '../../../app/localization/localization/language_constant.dart';
import '../../../data/config/di.dart';
import '../../../data/error/failures.dart';
import '../../../navigation/custom_navigation.dart';
import '../../../navigation/routes.dart';
import '../repo/payment_repo.dart';

class PaymentProvider extends ChangeNotifier {
  final PaymentRepo paymentRepo;

  PaymentProvider({required this.paymentRepo});

  int? taxPercentage;
  int? feesPercentage;
  double? tax;
  double? fees=0.0;
  double total = 0.0;

  calcTotal(price) {

    taxPercentage = sl<ConfigProvider>().setting?.tax??0;
    feesPercentage = sl<ConfigProvider>().setting?.serviceFee??0;
    print(taxPercentage);
    //
    tax = double.parse(((price ?? "0") * taxPercentage / 100).toStringAsFixed(2));
    // fees = double.parse(((price ?? "0") * feesPercentage / 100).toStringAsFixed(2));
    total = (price + tax!  );
    print(total);
    //
    notifyListeners();
  }

  ///checkout & payment
  bool isCheckOut = false;
  checkOut() async {
    try {
      isCheckOut = true;
      notifyListeners();

      Either<ServerFailure, Response> response =
          await paymentRepo.reserveOffer(requestModel: "");
      response.fold((fail) {
        CustomSnackBar.showSnackBar(
            notification: AppNotification(
                message: fail.error,
                isFloating: true,
                backgroundColor: Styles.IN_ACTIVE,
                borderColor: Colors.transparent));
      }, (success) {
        if (success.data["resID"] != null) {
          CustomNavigator.push(Routes.PAYMENT_WEB_VIEW,
              arguments: success.data["resID"]);
        } else {
          CustomSnackBar.showSnackBar(
              notification: AppNotification(
                  message: getTranslated(
                      "fail", CustomNavigator.navigatorState.currentContext!),
                  isFloating: true,
                  backgroundColor: Styles.IN_ACTIVE,
                  borderColor: Colors.transparent));
        }
      });
      isCheckOut = false;
      notifyListeners();
    } catch (e) {
      CustomSnackBar.showSnackBar(
          notification: AppNotification(
              message: e.toString(),
              isFloating: true,
              backgroundColor: Styles.IN_ACTIVE,
              borderColor: Colors.transparent));
      isCheckOut = false;
      notifyListeners();
    }
  }
}
