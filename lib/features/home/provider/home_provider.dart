import 'package:carousel_slider/carousel_controller.dart';
import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:casa/data/error/api_error_handler.dart';
import 'package:casa/features/home/models/banner_model.dart';
import '../../../app/core/utils/app_snack_bar.dart';
import '../../../app/core/utils/styles.dart';
import '../../../data/error/failures.dart';
import '../../../main_models/item_model.dart';
import '../repo/home_repo.dart';
import 'package:flutter/rendering.dart';

class HomeProvider extends ChangeNotifier {
  HomeRepo homeRepo;
  HomeProvider({required this.homeRepo}) {
    getCategories();
  }

  bool get isLogin => homeRepo.isLoggedIn();

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

  late int currentTab = 0;
  void selectTab(v) {
    currentTab = v;
    getProducts();
    notifyListeners();
  }

  List<ItemModel>? categories;
  bool isGetCategories = false;
  getCategories() async {
    try {
      isGetCategories = true;
      notifyListeners();
      Either<ServerFailure, Response> response =
          await homeRepo.getHomeCategory();
      response.fold((fail) {
        isGetCategories = false;
        CustomSnackBar.showSnackBar(
            notification: AppNotification(
                message: ApiErrorHandler.getMessage(fail),
                isFloating: true,
                backgroundColor: Styles.IN_ACTIVE,
                borderColor: Colors.transparent));
        notifyListeners();
      }, (success) {
        if (success.data["data"] != null) {
          categories = List<ItemModel>.from(
              success.data["data"].map((x) => ItemModel.fromJson(x)));
          categories!.insert(0, ItemModel(title: "الكل", id: 0));
        }
        isGetCategories = false;
        notifyListeners();
      });
    } catch (e) {
      isGetCategories = false;
      CustomSnackBar.showSnackBar(
          notification: AppNotification(
              message: e.toString(),
              isFloating: true,
              backgroundColor: Styles.IN_ACTIVE,
              borderColor: Colors.transparent));
      notifyListeners();
    }
  }

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
      Either<ServerFailure, Response> response =
          await homeRepo.getHomeBanner(currentTab);
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

  List<ItemModel> products = [];
  bool isGetProducts = false;
  getProducts() async {
    try {
      isGetProducts = true;
      products = [];
      notifyListeners();
      Either<ServerFailure, Response> response =
          await homeRepo.getHomeProducts(currentTab);
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
        if (currentTab == 0) {
          if (success.data["data"] != null) {
            products = List<ItemModel>.from(
                success.data["data"].map((x) => ItemModel.fromJson(x)));
          }
        } else {
          if (success.data["data"] != null &&
              success.data["data"]["subServices"] != null) {
            products = List<ItemModel>.from(success.data["data"]["subServices"]
                .map((x) => ItemModel.fromJson(x)));
          }
        }
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
