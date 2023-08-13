import 'package:casa/features/setting/model/setting_model.dart';
import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:casa/features/setting/model/contact_model.dart';
import '../../../app/core/utils/app_snack_bar.dart';
import '../../../app/core/utils/styles.dart';
import '../../../data/error/api_error_handler.dart';
import '../../../data/error/failures.dart';
import '../repo/config_repo.dart';

class ConfigProvider extends ChangeNotifier {
  final ConfigRepo repo;

  ConfigProvider({required this.repo});

  bool isLoading = false;
  SettingModel? setting;
  getSetting() async {
    try {
      isLoading = true;
      notifyListeners();

      Either<ServerFailure, Response> response = await repo.getSetting();
      response.fold((l) {
        CustomSnackBar.showSnackBar(
            notification: AppNotification(
                message: ApiErrorHandler.getMessage(l),
                isFloating: true,
                backgroundColor: Styles.IN_ACTIVE,
                borderColor: Colors.transparent));
      }, (response) {
        setting = SettingModel.fromJson(response.data["data"]);
      });

      isLoading = false;
      notifyListeners();
    } catch (e) {
      CustomSnackBar.showSnackBar(
          notification: AppNotification(
              message: e.toString(),
              isFloating: true,
              backgroundColor: Styles.IN_ACTIVE,
              borderColor: Colors.transparent));
      isLoading = false;
      notifyListeners();
    }
  }

  bool isGetting = false;
  ContactModel? contact;
  getContact() async {
    try {
      isGetting = true;
      notifyListeners();
      Either<ServerFailure, Response> response = await repo.getContact();
      response.fold((l) {
        CustomSnackBar.showSnackBar(
            notification: AppNotification(
                message: ApiErrorHandler.getMessage(l),
                isFloating: true,
                backgroundColor: Styles.IN_ACTIVE,
                borderColor: Colors.transparent));
      }, (response) {
        contact = ContactModel.fromJson(response.data["data"]);
      });

      isGetting = false;
      notifyListeners();
    } catch (e) {
      CustomSnackBar.showSnackBar(
          notification: AppNotification(
              message: e.toString(),
              isFloating: true,
              backgroundColor: Styles.IN_ACTIVE,
              borderColor: Colors.transparent));
      isGetting = false;
      notifyListeners();
    }
  }
}
