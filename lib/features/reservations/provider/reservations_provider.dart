import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:casa/data/error/api_error_handler.dart';
import '../../../app/core/utils/app_snack_bar.dart';
import '../../../app/core/utils/styles.dart';
import '../../../data/error/failures.dart';
import 'package:flutter/rendering.dart';

import '../../../main_models/item_model.dart';
import '../repo/reservations_repo.dart';

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

  List<ItemModel>? nextReservations;
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
        if( success.data["data"] != null) {
          nextReservations = List<ItemModel>.from(
            success.data["data"].map((x) => ItemModel.fromJson(x)));
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

  List<ItemModel>? previousReservations;
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
        if( success.data["data"] != null) {
          previousReservations = List<ItemModel>.from(
            success.data["data"].map((x) => ItemModel.fromJson(x)));
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
}
