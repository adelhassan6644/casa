import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:casa/data/error/api_error_handler.dart';
import '../../../app/core/utils/app_snack_bar.dart';
import '../../../app/core/utils/styles.dart';
import '../../../data/error/failures.dart';
import 'package:flutter/rendering.dart';
import '../model/address_model.dart';
import '../repo/addresses_repo.dart';

class AddressesProvider extends ChangeNotifier {
  AddressesRepo repo;
  AddressesProvider({required this.repo});

  bool goingDown = false;
  scroll(controller) {
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

  bool get isLogin => repo.isLoggedIn();

  AddressesModel? model;
  bool isLoading = false;
  getAddresses() async {
    try {
      isLoading = true;
      notifyListeners();
      Either<ServerFailure, Response> response =
      await repo.getAddresses();
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
        model = AddressesModel.fromJson(success.data);
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

  int type = 0;
  List<String> types = ["house", "other_address"];
  void selectType(v) {
    type = v;
    notifyListeners();
  }
  bool isAdding = false;
  addAddress() async {
    try {
      isAdding = true;
      notifyListeners();
      Either<ServerFailure, Response> response =
      await repo.addAddress();
      response.fold((fail) {
        isAdding = false;
        CustomSnackBar.showSnackBar(
            notification: AppNotification(
                message: ApiErrorHandler.getMessage(fail),
                isFloating: true,
                backgroundColor: Styles.IN_ACTIVE,
                borderColor: Colors.transparent));
        notifyListeners();
      }, (success) {
        getAddresses();
      });
    } catch (e) {
      isAdding = false;
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
