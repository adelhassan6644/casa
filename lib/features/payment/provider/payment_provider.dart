import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import '../../../app/core/utils/app_snack_bar.dart';
import '../../../app/core/utils/styles.dart';
import '../../../app/localization/localization/language_constant.dart';
import '../../../data/error/failures.dart';
import '../../../navigation/custom_navigation.dart';
import '../../../navigation/routes.dart';
import '../repo/payment_repo.dart';

class PaymentProvider extends ChangeNotifier {
  final PaymentRepo paymentRepo;

  PaymentProvider({required this.paymentRepo});

  double total = 0.0;

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
