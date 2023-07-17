import 'package:carousel_slider/carousel_controller.dart';
import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:casa/data/error/api_error_handler.dart';
import 'package:casa/features/home/models/banner_model.dart';
import '../../../app/core/utils/app_snack_bar.dart';
import '../../../app/core/utils/color_resources.dart';
import '../../../data/error/failures.dart';
import '../models/categories_model.dart';
import '../models/news_model.dart';
import '../models/offers_model.dart';
import '../models/places_model.dart';
import '../repo/home_repo.dart';
import 'package:flutter/rendering.dart';

class HomeProvider extends ChangeNotifier {
  HomeRepo homeRepo;
  HomeProvider({required this.homeRepo});

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

  bool get isLogin => homeRepo.isLoggedIn();

  CarouselController bannerController = CarouselController();
  late int _placesIndex = 0;
  int get bannerIndex => _placesIndex;
  void setPlacesIndex(int index) {
    _placesIndex = index;
    notifyListeners();
  }

  late int _offersIndex = 0;
  int get offersIndex => _offersIndex;
  void setOffersIndex(int index) {
    _offersIndex = index;
    notifyListeners();
  }

  BannerModel? bannerModel;
  bool isGetBanners = false;
  getBanners() async {
    try {
      isGetBanners = true;
      notifyListeners();
      Either<ServerFailure, Response> response = await homeRepo.getHomeBanner();
      response.fold((fail) {
        isGetBanners = false;
        CustomSnackBar.showSnackBar(
            notification: AppNotification(
                message: ApiErrorHandler.getMessage(fail),
                isFloating: true,
                backgroundColor: ColorResources.IN_ACTIVE,
                borderColor: Colors.transparent));
        notifyListeners();
      }, (success) {
        bannerModel = BannerModel.fromJson(success.data);
        isGetBanners = false;
        notifyListeners();
      });
    } catch (e) {
      isGetBanners = false;
      CustomSnackBar.showSnackBar(
          notification: AppNotification(
              message: e.toString(),
              isFloating: true,
              backgroundColor: ColorResources.IN_ACTIVE,
              borderColor: Colors.transparent));
      notifyListeners();
    }
  }

  PlacesModel? placesModel;
  bool isGetPlaces = false;
  getPlaces() async {
    try {
      isGetPlaces = true;
      notifyListeners();
      Either<ServerFailure, Response> response = await homeRepo.getHomePlaces();
      response.fold((fail) {
        isGetPlaces = false;
        CustomSnackBar.showSnackBar(
            notification: AppNotification(
                message: ApiErrorHandler.getMessage(fail),
                isFloating: true,
                backgroundColor: ColorResources.IN_ACTIVE,
                borderColor: Colors.transparent));
        notifyListeners();
      }, (success) {
        placesModel = PlacesModel.fromJson(success.data);
        isGetPlaces = false;
        notifyListeners();
      });
    } catch (e) {
      isGetPlaces = false;
      CustomSnackBar.showSnackBar(
          notification: AppNotification(
              message: e.toString(),
              isFloating: true,
              backgroundColor: ColorResources.IN_ACTIVE,
              borderColor: Colors.transparent));
      notifyListeners();
    }
  }

  CategoriesModel? categoriesModel;
  bool isGetCategories = false;
  getCategories() async {
    try {
      isGetCategories = true;
      notifyListeners();
      Either<ServerFailure, Response> response =
          await homeRepo.getHomeCategories();
      response.fold((fail) {
        isGetCategories = false;
        CustomSnackBar.showSnackBar(
            notification: AppNotification(
                message: ApiErrorHandler.getMessage(fail),
                isFloating: true,
                backgroundColor: ColorResources.IN_ACTIVE,
                borderColor: Colors.transparent));
        notifyListeners();
      }, (success) {
        categoriesModel = CategoriesModel.fromJson(success.data);
        isGetCategories = false;
        notifyListeners();
      });
    } catch (e) {
      isGetCategories = false;
      CustomSnackBar.showSnackBar(
          notification: AppNotification(
              message: e.toString(),
              isFloating: true,
              backgroundColor: ColorResources.IN_ACTIVE,
              borderColor: Colors.transparent));
      notifyListeners();
    }
  }

  // bool show = false;
  // showAllNews() {
  //   show = true;
  //   notifyListeners();
  // }

  NewsModel? newsModel;
  bool isExploring = false;
  getNews() async {
    try {
      isExploring = true;
      notifyListeners();
      Either<ServerFailure, Response> response = await homeRepo.getHomeNews();
      response.fold((fail) {
        isExploring = false;
        CustomSnackBar.showSnackBar(
            notification: AppNotification(
                message: ApiErrorHandler.getMessage(fail),
                isFloating: true,
                backgroundColor: ColorResources.IN_ACTIVE,
                borderColor: Colors.transparent));
        notifyListeners();
      }, (success) {
        newsModel = NewsModel.fromJson(success.data);
        isExploring = false;
        notifyListeners();
      });
    } catch (e) {
      isExploring = false;
      CustomSnackBar.showSnackBar(
          notification: AppNotification(
              message: e.toString(),
              isFloating: true,
              backgroundColor: ColorResources.IN_ACTIVE,
              borderColor: Colors.transparent));
      notifyListeners();
    }
  }

  OffersModel? offersModel;
  bool isGetOffers = false;
  getOffers() async {
    try {
      isGetOffers = true;
      notifyListeners();
      Either<ServerFailure, Response> response = await homeRepo.getHomeOffers();
      response.fold((fail) {
        isGetOffers = false;
        CustomSnackBar.showSnackBar(
            notification: AppNotification(
                message: ApiErrorHandler.getMessage(fail),
                isFloating: true,
                backgroundColor: ColorResources.IN_ACTIVE,
                borderColor: Colors.transparent));
        notifyListeners();
      }, (success) {
        offersModel = OffersModel.fromJson(success.data);
        isGetOffers = false;
        notifyListeners();
      });
    } catch (e) {
      isGetOffers = false;
      CustomSnackBar.showSnackBar(
          notification: AppNotification(
              message: e.toString(),
              isFloating: true,
              backgroundColor: ColorResources.IN_ACTIVE,
              borderColor: Colors.transparent));
      notifyListeners();
    }
  }
}
