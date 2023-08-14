import 'package:casa/app/localization/localization/language_constant.dart';
import 'package:casa/navigation/custom_navigation.dart';
import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:casa/data/error/api_error_handler.dart';
import '../../../app/core/utils/app_snack_bar.dart';
import '../../../app/core/utils/styles.dart';
import '../../../components/custom_simple_dialog.dart';
import '../../../data/config/di.dart';
import '../../../data/error/failures.dart';
import 'package:flutter/rendering.dart';

import '../model/reservation_model.dart';
import '../repo/reservations_repo.dart';
import '../widgets/cancellation_dialog.dart';

class ReservationsProvider extends ChangeNotifier {
  ReservationsRepo repo;
  ReservationsProvider({required this.repo});

  bool goingDown = false;
  nextScroll(controller) {
    controller.addListener(() {
      if (controller.position.userScrollDirection == ScrollDirection.forward) {
        goingDown = false;
        notifyListeners();
      } else {
        goingDown = true;
        notifyListeners();
      }
    });
  }

  previousScroll(controller) {
    controller.addListener(() {
      if (controller.position.userScrollDirection == ScrollDirection.forward) {
        goingDown = false;
        notifyListeners();
      } else {
        goingDown = true;
        notifyListeners();
      }
    });
  }

  List<String> tabs = ["next", "previous"];
  late int currentTab = 0;
  void selectTab(index) {
    currentTab = index;
    notifyListeners();
  }

  bool get isLogin => repo.isLoggedIn();

  List<ReservationModel>? nextReservations;
  bool isGetting = false;
  getNextReservations() async {
    try {
      isGetting = true;
      nextReservations?.clear();
      notifyListeners();
      Either<ServerFailure, Response> response =
          await repo.getNextReservations();
      response.fold((fail) {
        isGetting = false;
        CustomSnackBar.showSnackBar(
            notification: AppNotification(
                message: ApiErrorHandler.getMessage(fail),
                isFloating: true,
                backgroundColor: Styles.IN_ACTIVE,
                borderColor: Colors.transparent));
        notifyListeners();
      }, (success) {
        if (success.data["data"] != null) {
          nextReservations = List<ReservationModel>.from(
              success.data["data"].map((x) => ReservationModel.fromJson(x)));
        }
        isGetting = false;
        notifyListeners();
      });
    } catch (e) {
      isGetting = false;
      CustomSnackBar.showSnackBar(
          notification: AppNotification(
              message: e.toString(),
              isFloating: true,
              backgroundColor: Styles.IN_ACTIVE,
              borderColor: Colors.transparent));
      notifyListeners();
    }
  }

  List<ReservationModel>? previousReservations;
  bool isLoading = false;
  getPreviousReservations() async {
    try {
      isLoading = true;
      previousReservations?.clear();
      notifyListeners();
      Either<ServerFailure, Response> response =
          await repo.getPreviousReservations();
      response.fold((fail) {
        isLoading = false;
        CustomSnackBar.showSnackBar(
            notification: AppNotification(
                message: ApiErrorHandler.getMessage(fail),
                isFloating: true,
                backgroundColor: Styles.IN_ACTIVE,
                borderColor: Colors.transparent));
        notifyListeners();
      }, (success) {
        if (success.data["data"] != null) {
          previousReservations = List<ReservationModel>.from(
              success.data["data"].map((x) => ReservationModel.fromJson(x)));
        }
        isLoading = false;
        notifyListeners();
      });
    } catch (e) {
      isLoading = false;
      CustomSnackBar.showSnackBar(
          notification: AppNotification(
              message: e.toString(),
              isFloating: true,
              backgroundColor: Styles.IN_ACTIVE,
              borderColor: Colors.transparent));
      notifyListeners();
    }
  }

  bool isCancelling = false;
  bool cancelled = false;
  cancelReservation(id) async {
    try {
      isCancelling = true;
      notifyListeners();
      Either<ServerFailure, Response> response =
          await repo.cancelReservations(id);
      response.fold((fail) {
        CustomSnackBar.showSnackBar(
            notification: AppNotification(
                message: ApiErrorHandler.getMessage(fail),
                isFloating: true,
                backgroundColor: Styles.IN_ACTIVE,
                borderColor: Colors.transparent));
      }, (success) {
        CustomNavigator.pop();
        CustomSimpleDialog.parentSimpleDialog(
          customListWidget: [const CancelledDialog()],
        );
        sl<ReservationsProvider>().getNextReservations();
        // showToast(getTranslated("reservation_cancel_successfully",
        //     CustomNavigator.navigatorState.currentContext!));
        nextReservations?.removeWhere((e) => e.id == id);
      });
      isCancelling = false;
      notifyListeners();
    } catch (e) {
      isCancelling = false;
      CustomSnackBar.showSnackBar(
          notification: AppNotification(
              message: e.toString(),
              isFloating: true,
              backgroundColor: Styles.IN_ACTIVE,
              borderColor: Colors.transparent));
      notifyListeners();
    }
  }
}
