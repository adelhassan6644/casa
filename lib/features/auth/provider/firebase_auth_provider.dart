import 'dart:developer';
import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:casa/app/localization/localization/language_constant.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import '../../../app/core/utils/app_snack_bar.dart';
import '../../../app/core/utils/color_resources.dart';
import '../../../components/loading_dialog.dart';
import '../../../data/config/di.dart';
import '../../../data/error/api_error_handler.dart';
import '../../../data/error/failures.dart';
import '../../../navigation/custom_navigation.dart';
import '../../../navigation/routes.dart';
import '../../home/provider/home_provider.dart';
import '../../profile/provider/profile_provider.dart';
import '../repo/firebase_auth_repo.dart';

class FirebaseAuthProvider extends ChangeNotifier {
  final FirebaseAuthRepo firebaseAuthRepo;
  FirebaseAuthProvider({
    required this.firebaseAuthRepo,
  }) {
    _phoneTEC = TextEditingController(text: kDebugMode ? "555666777" : null);
  }

  late final TextEditingController _phoneTEC;
  TextEditingController get phoneTEC => _phoneTEC;

  String? firebaseVerificationId;

  bool _isAgree = true;
  bool get isAgree => _isAgree;
  void onAgree(bool value) {
    _isAgree = value;
    notifyListeners();
  }

  String countryPhoneCode = "+966";
  String countryCode = "SA";
  void onSelectCountry({required String code, required String phone}) {
    countryPhoneCode = "+$phone";
    countryCode = code;
    notifyListeners();
  }

  int _userType = 0;
  int get userType => _userType;
  List<String> usersTypes = ["passenger", "captain"];
  List<String> role = ["client", "driver"];
  void selectedUserType(int value) {
    _userType = value;
    notifyListeners();
  }

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  bool _isSubmit = false;
  bool get isSubmit => _isSubmit;

  bool get isLogin => firebaseAuthRepo.isLoggedIn();

  signInWithMobileNo({bool? fromVerification}) async {
    try {
      _isLoading = true;
      notifyListeners();
      await FirebaseAuth.instance.verifyPhoneNumber(
          phoneNumber: "$countryPhoneCode${_phoneTEC.text.trim()}",
          timeout: const Duration(seconds: 60),
          verificationCompleted: (authCredential) =>
              phoneVerificationCompleted(authCredential),
          verificationFailed: (authException) =>
              phoneVerificationFailed(authException),
          codeSent: (verificationId, code) => phoneCodeSent(
              verificationId: verificationId,
              code: code ?? 0,
              fromVerification: fromVerification ?? false),
          codeAutoRetrievalTimeout: phoneCodeAutoRetrievalTimeout);
    } catch (e) {
      _isLoading = false;
      CustomSnackBar.showSnackBar(
          notification: AppNotification(
              message: ApiErrorHandler.getMessage(e),
              isFloating: true,
              backgroundColor: ColorResources.IN_ACTIVE,
              borderColor: Colors.transparent));
    }
  }

  phoneVerificationCompleted(AuthCredential authCredential) {
    log("====>phoneVerificationCompleted ${authCredential.token}");
  }

  phoneVerificationFailed(FirebaseException authException) {
    CustomNavigator.pop();
    if (authException.code == 'invalid-phone-number') {
      CustomSnackBar.showSnackBar(
          notification: AppNotification(
              message: getTranslated("invalid_phone",
                  CustomNavigator.navigatorState.currentContext!),
              backgroundColor: ColorResources.IN_ACTIVE,
              borderColor: Colors.transparent));
    } else {
      CustomSnackBar.showSnackBar(
          notification: AppNotification(
              message: authException.message.toString(),
              backgroundColor: ColorResources.IN_ACTIVE,
              borderColor: Colors.transparent));
    }
    log("======>Fail when Auth with Firebase : ${authException.message}");
    _isLoading = false;
    _isSubmit = false;
    notifyListeners();
  }

  phoneCodeAutoRetrievalTimeout(String verificationCode) {
    log("====>phoneCodeAutoRetrievalTimeout is $firebaseVerificationId");
    firebaseVerificationId = verificationCode;
    _isSubmit = false;
    _isLoading = false;
    notifyListeners();
  }

  phoneCodeSent(
      {required String verificationId,
      required int code,
      required bool fromVerification}) async {
    _isLoading = false;
    firebaseVerificationId = verificationId;
    if (fromVerification == false) {
      CustomNavigator.pop();
      CustomNavigator.push(
        Routes.VERIFICATION,
      );
    }
    notifyListeners();
  }

  sendOTP({required String code}) async {
    spinKitDialog();
    _isSubmit = true;
    notifyListeners();
    try {
      if (firebaseVerificationId != null) {
        PhoneAuthCredential phoneAuthCredential = PhoneAuthProvider.credential(
          verificationId: firebaseVerificationId!,
          smsCode: code,
        );
        await FirebaseAuth.instance
            .signInWithCredential(phoneAuthCredential)
            .then((value) async {
          ///  to send Device token
          await userLogin();
          CustomNavigator.pop();
          _isSubmit = false;
          notifyListeners();
        }).catchError((error) {
          log(error.toString());
          CustomNavigator.pop();
          CustomSnackBar.showSnackBar(
              notification: AppNotification(
                  message: getTranslated("invalid_code",
                      CustomNavigator.navigatorState.currentContext!),
                  isFloating: true,
                  backgroundColor: ColorResources.IN_ACTIVE,
                  borderColor: Colors.transparent));
          _isSubmit = false;
          notifyListeners();
        });
      } else {
        log("====>has error in firebaseVerificationId $firebaseVerificationId");
        CustomNavigator.pop();
        _isSubmit = false;
        CustomSnackBar.showSnackBar(
            notification: AppNotification(
                message: "has error in firebaseVerificationId",
                isFloating: true,
                backgroundColor: ColorResources.IN_ACTIVE,
                borderColor: Colors.transparent));
        notifyListeners();
      }
    } catch (e) {
      log("====>$e");
      CustomNavigator.pop();
      CustomSnackBar.showSnackBar(
          notification: AppNotification(
              message: e.toString(),
              isFloating: true,
              backgroundColor: ColorResources.IN_ACTIVE,
              borderColor: Colors.transparent));
      _isSubmit = false;
      notifyListeners();
    }
  }

  userLogin() async {
    try {
      Either<ServerFailure, Response> res =
          await firebaseAuthRepo.sendDeviceToken(
              phone: "$countryPhoneCode${_phoneTEC.text.trim()}",
              role: role[_userType]);
      res.fold((fail) {
        log(ApiErrorHandler.getMessage(fail));
        CustomSnackBar.showSnackBar(
            notification: AppNotification(
                message: ApiErrorHandler.getMessage(fail),
                isFloating: true,
                backgroundColor: ColorResources.IN_ACTIVE,
                borderColor: Colors.transparent));
      }, (success) async {
        firebaseAuthRepo.setLoggedIn();
        firebaseAuthRepo.saveUserRole(
            type: role[_userType],
            id: success.data['data'][role[_userType]]["id"].toString());

        firebaseAuthRepo.remember(
            phone: "$countryPhoneCode${_phoneTEC.text.trim()}");

        if (success.data['data'][role[_userType]]["new_user"].toString() ==
                "1" ||
            success.data['data'][role[_userType]]["first_name"] == null) {
          CustomNavigator.pop();
          CustomNavigator.push(Routes.EDIT_PROFILE,
              clean: true, arguments: true);
        } else {
          CustomNavigator.push(Routes.DASHBOARD, arguments: 0, clean: true);
        }
        CustomSnackBar.showSnackBar(
            notification: AppNotification(
                message: getTranslated("successfully_login",
                    CustomNavigator.navigatorState.currentContext!),
                isFloating: true,
                backgroundColor: ColorResources.ACTIVE,
                borderColor: Colors.transparent));
      });
    } catch (e) {
      CustomSnackBar.showSnackBar(
          notification: AppNotification(
              message: e.toString(),
              isFloating: true,
              backgroundColor: ColorResources.IN_ACTIVE,
              borderColor: Colors.transparent));
    }
  }

  logOut() async {
    try {
      Future.delayed(Duration.zero, () async {
        await FirebaseAuth.instance.signOut();
        await firebaseAuthRepo.clearSharedData();
      });
      CustomNavigator.push(Routes.SPLASH, clean: true);
      notifyListeners();
    } catch (e) {
      CustomSnackBar.showSnackBar(
          notification: AppNotification(
              message: e.toString(),
              isFloating: true,
              backgroundColor: ColorResources.ACTIVE,
              borderColor: Colors.transparent));
      notifyListeners();
    }
  }
}
