import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:casa/features/favourite/repo/favourite_repo.dart';
import '../../../app/core/utils/app_snack_bar.dart';
import '../../../app/core/utils/styles.dart';
import '../../../app/localization/localization/language_constant.dart';
import '../../../data/error/failures.dart';
import '../../../navigation/custom_navigation.dart';
import '../model/favourite_model.dart';

class FavouriteProvider extends ChangeNotifier {
  final FavouriteRepo favouriteRepo;
  FavouriteProvider({
    required this.favouriteRepo,
  }) {
    favouritesId.clear();
  }

  bool get isLogin => favouriteRepo.isLoggedIn();

  List<int> favouritesId = [];

  bool isLoading = false;
  FavouriteModel? favouriteModel;
  getFavourites() async {
    try {
      isLoading = true;
      notifyListeners();
      Either<ServerFailure, Response> response =
          await favouriteRepo.getFavourites();
      response.fold((l) {
        CustomSnackBar.showSnackBar(
            notification: AppNotification(
                message: l.error,
                isFloating: true,
                backgroundColor: Styles.IN_ACTIVE,
                borderColor: Colors.transparent));
        isLoading = false;
        notifyListeners();
      }, (response) {
        favouriteModel = FavouriteModel.fromJson(response.data);
        favouritesId = [];
        if (favouriteModel!.data != null && favouriteModel!.data!.isNotEmpty) {
          for (var e in favouriteModel!.data!) {
            if (e.id != null) {
              favouritesId.add(e.id!);
            }
          }
        }
        isLoading = false;
        notifyListeners();
      });
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

  updateFavourites({required int id, bool isExist = false}) async {
    try {
      if (isExist) {
        favouritesId.remove(id);
      } else {
        favouritesId.add(id);
      }
      notifyListeners();

      Either<ServerFailure, Response> response =
          await favouriteRepo.updateFavourite(id);
      response.fold((l) {
        showToast(l.error);
      }, (response) {
        if (isExist) {
          showToast("تم الازالة من الاماكن المفضلة");
        } else {
          showToast("تم الاضافة الي الاماكن المفضلة");
        }
      });
      getFavourites();
      notifyListeners();
    } catch (e) {
      showToast(
        getTranslated("something_went_wrong",
            CustomNavigator.navigatorState.currentContext!),
      );
      notifyListeners();
    }
  }
}
