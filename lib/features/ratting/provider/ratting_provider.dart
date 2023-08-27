import 'package:casa/features/ratting/repo/ratting_repo.dart';
import 'package:casa/features/reservations/model/reservation_model.dart';
import 'package:casa/navigation/custom_navigation.dart';
import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import '../../../app/core/utils/app_snack_bar.dart';
import '../../../app/core/utils/styles.dart';
import '../../../app/localization/localization/language_constant.dart';
import '../../../data/error/failures.dart';

class RattingProvider extends ChangeNotifier {
  final RattingRepo rattingRepo;
  RattingProvider({
    required this.rattingRepo,
  }) {
    ratting = -1;
  }

  TextEditingController feedback = TextEditingController();
  int? ratting;
  selectedRate(value) {
    ratting = value;
    notifyListeners();
  }

  clear() {
    ratting = -1;
  }

  bool isLoading = false;

  sendFeedback(ReservationModel reservation) async {
    if (ratting != -1) {
      try {
        isLoading = true;
        notifyListeners();
        var body = {
          "client_id": rattingRepo.getUserId(),
          "id": reservation.id,
          "sub_service_id":reservation.subService,
          "rating": ratting! + 1,
          // "feedback": feedback.text.trim()
        };
        Either<ServerFailure, Response> response =
            await rattingRepo.sendRatting(body);
        response.fold((fail) {
          clear();
          CustomNavigator.pop();
          CustomSnackBar.showSnackBar(
              notification: AppNotification(
                  message: fail.error,
                  isFloating: true,
                  backgroundColor: Styles.IN_ACTIVE,
                  borderColor: Colors.transparent));
        }, (response) {
          CustomNavigator.pop();
          clear();
        });
        isLoading = false;
        notifyListeners();
      } catch (e) {
        CustomNavigator.pop();
        clear();
        CustomSnackBar.showSnackBar(
            notification: AppNotification(
                message: e.toString(),
                isFloating: true,
                backgroundColor: Styles.IN_ACTIVE,
                borderColor: Colors.transparent));
        isLoading = false;
        notifyListeners();
      }
    } else {
      showToast(getTranslated("please_enter_ratting",
          CustomNavigator.navigatorState.currentContext!));
    }
  }
}
