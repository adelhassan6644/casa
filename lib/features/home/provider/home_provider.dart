import 'package:carousel_slider/carousel_controller.dart';
import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:casa/data/error/api_error_handler.dart';
import 'package:casa/features/home/models/banner_model.dart';
import '../../../app/core/utils/app_snack_bar.dart';
import '../../../app/core/utils/styles.dart';
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

  List<String> tabs = ["all","pedicure","massage"];
  late int currentTab = 0;
  void selectTab(index) {
    currentTab = index;
    notifyListeners();
  }

  bool get isLogin => homeRepo.isLoggedIn();

  CarouselController bannerController = CarouselController();
  late int _bannerIndex = 0;
  int get bannerIndex => _bannerIndex;
  void setBannerIndex(int index) {
    _bannerIndex = index;
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
                backgroundColor: Styles.IN_ACTIVE,
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
              backgroundColor: Styles.IN_ACTIVE,
              borderColor: Colors.transparent));
      notifyListeners();
    }
  }

  ProductsModel? productsModel;
  bool isGetProducts = false;
  getProducts() async {
    try {
      isGetProducts = true;
      notifyListeners();
      Either<ServerFailure, Response> response = await homeRepo.getHomeProducts();
      response.fold((fail) {
        isGetProducts = false;
        CustomSnackBar.showSnackBar(
            notification: AppNotification(
                message: ApiErrorHandler.getMessage(fail),
                isFloating: true,
                backgroundColor: Styles.IN_ACTIVE,
                borderColor: Colors.transparent));
        notifyListeners();
      }, (success) {
        productsModel = ProductsModel.fromJson(success.data);
        isGetProducts = false;
        notifyListeners();
      });
    } catch (e) {
      isGetProducts = false;
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
