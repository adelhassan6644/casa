import 'package:casa/app/localization/localization/language_constant.dart';
import 'package:casa/navigation/custom_navigation.dart';
import 'package:casa/navigation/routes.dart';
import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import '../../../app/core/utils/app_snack_bar.dart';
import '../../../app/core/utils/styles.dart';
import '../../../data/error/failures.dart';
import '../../../main_models/item_model.dart';
import '../../reservations/model/reservation_model.dart';
import '../repo/session_details_repo.dart';

class SessionDetailsProvider extends ChangeNotifier {
  SessionDetailsRepo repo;
  SessionDetailsProvider({required this.repo});

  late int placesIndex = 0;
  void setPlacesIndex(int index) {
    placesIndex = index;
    notifyListeners();
  }

  ReservationModel? model;
  bool isLoading = false;
  getSessionDetails(id) async {
    isLoading = true;
    notifyListeners();
    model=null;
    Either<ServerFailure, Response> response = await repo.getSessionDetails(id);
    response.fold((fail) {
      isLoading = false;
      CustomSnackBar.showSnackBar(
          notification: AppNotification(
              message: fail.error,
              isFloating: true,
              backgroundColor: Styles.IN_ACTIVE,
              borderColor: Colors.transparent));
      notifyListeners();
    }, (success) {
      if (success.data["data"] != null) {
        model = ReservationModel.fromJson(success.data["data"]);
      } else {
        model = null;
      }
      isLoading = false;
      notifyListeners();
    });
  }


}
