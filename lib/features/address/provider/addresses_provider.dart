import 'package:casa/navigation/custom_navigation.dart';
import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:casa/data/error/api_error_handler.dart';
import '../../../app/core/utils/app_snack_bar.dart';
import '../../../app/core/utils/styles.dart';
import '../../../app/localization/localization/language_constant.dart';
import '../../../components/loading_dialog.dart';
import '../../../data/error/failures.dart';
import 'package:flutter/rendering.dart';
import '../../maps/models/location_model.dart';
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

  AddressItem? selectedAddress;
  void selectAddress(v) {
    selectedAddress = v;
    notifyListeners();
  }

  AddressesModel? model;
  bool isLoading = false;
  getAddresses() async {
    try {
      isLoading = true;
      notifyListeners();
      Either<ServerFailure, Response> response = await repo.getAddresses();
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

  LocationModel? address;
  onSelectStartLocation(v) {
    address = v;
    if (address != null) {
      addAddress();
    }
    notifyListeners();
  }

  addAddress() async {
    try {
      loadingDialog();
      notifyListeners();
      Either<ServerFailure, Response> response =
          await repo.addAddress(type: type, address: address!);
      response.fold((fail) {
        CustomNavigator.pop();
        CustomSnackBar.showSnackBar(
            notification: AppNotification(
                message: ApiErrorHandler.getMessage(fail),
                isFloating: true,
                backgroundColor: Styles.IN_ACTIVE,
                borderColor: Colors.transparent));
      }, (success) {
        model?.data?.add(AddressItem(
            id: success.data["data"]["id"],
            lat: address?.latitude,
            long: address?.longitude,
            address: address?.address,
            type: type));
        CustomNavigator.pop();
        CustomSnackBar.showSnackBar(
            notification: AppNotification(
                message: success.data["message"],
                isFloating: true,
                backgroundColor: Styles.ACTIVE,
                borderColor: Colors.transparent));
      });
      notifyListeners();
    } catch (e) {
      CustomNavigator.pop();
      CustomSnackBar.showSnackBar(
          notification: AppNotification(
              message: e.toString(),
              isFloating: true,
              backgroundColor: Styles.IN_ACTIVE,
              borderColor: Colors.transparent));
      notifyListeners();
    }
  }

  bool isDelete = false;
  deleteAddress(id) async {
    try {
      isDelete = true;
      notifyListeners();
      Either<ServerFailure, Response> response = await repo.deleteAddress(id);
      response.fold((fail) {
        CustomNavigator.pop();
        CustomSnackBar.showSnackBar(
            notification: AppNotification(
                message: ApiErrorHandler.getMessage(fail),
                isFloating: true,
                backgroundColor: Styles.IN_ACTIVE,
                borderColor: Colors.transparent));
      }, (success) {
        if(id == selectedAddress?.id) {
          selectedAddress = null;
        }
        model?.data?.removeWhere((e) => e.id == id);
        CustomNavigator.pop();
        showToast(getTranslated("address_deleted_successfully",
            CustomNavigator.navigatorState.currentContext!));
      });
      isDelete = false;
      notifyListeners();
    } catch (e) {
      isDelete = false;
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
