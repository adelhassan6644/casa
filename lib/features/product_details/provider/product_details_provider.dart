import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:casa/features/product_details/repo/product_details_repo.dart';
import '../../../app/core/utils/app_snack_bar.dart';
import '../../../app/core/utils/styles.dart';
import '../../../data/error/failures.dart';
import '../../home/models/places_model.dart';

class ProductDetailsProvider extends ChangeNotifier {
  ProductDetailsRepo repo;
  ProductDetailsProvider({required this.repo});

  late int placesIndex = 0;
  void setPlacesIndex(int index) {
    placesIndex = index;
    notifyListeners();
  }

  ProductItem? model;
  bool isLoading = false;
  geDetails(id) async {
    try {
      isLoading = true;
      notifyListeners();
      Either<ServerFailure, Response> response = await repo.getPlaceDetails(id);
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
          model = ProductItem.fromJson(success.data["data"]);
        } else {
          model = null;
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
