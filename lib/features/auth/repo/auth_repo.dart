import 'dart:developer';
import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../app/core/utils/app_storage_keys.dart';
import '../../../data/api/end_points.dart';
import '../../../data/dio/dio_client.dart';
import '../../../data/error/api_error_handler.dart';
import '../../../data/error/failures.dart';

class AuthRepo {
  final SharedPreferences sharedPreferences;
  final DioClient dioClient;
  AuthRepo({required this.sharedPreferences, required this.dioClient});

  bool isLoggedIn() {
    return sharedPreferences.containsKey(AppStorageKey.isLogin);
  }

  setLoggedIn() {
    sharedPreferences.setBool(AppStorageKey.isLogin, true);
  }

  saveUserId(id) {
    sharedPreferences.setString(AppStorageKey.userId, id.toString());
  }

  // saveUserToken(apiToken) {
  //   sharedPreferences.setString(AppStorageKey.apiToken, apiToken.toString());
  // }

  getMail() {
    if (sharedPreferences.containsKey(
      AppStorageKey.mail,
    )) {
      return sharedPreferences.getString(
        AppStorageKey.mail,
      );
    }
  }

  remember(mail) {
    sharedPreferences.setString(AppStorageKey.mail, mail);
  }

  forget() {
    sharedPreferences.remove(AppStorageKey.mail);
  }

  Future<String?> saveDeviceToken() async {
    String? deviceToken;
    if (Platform.isIOS) {
      deviceToken = await FirebaseMessaging.instance.getAPNSToken();
    } else {
      deviceToken = await FirebaseMessaging.instance.getToken();
    }

    if (deviceToken != null) {
      log('--------Device Token---------- $deviceToken');
    }
    return deviceToken;
  }

  // Future<Either<ServerFailure, Response>> subscribeToTopic() async {
  //   try {
  //     FirebaseMessaging.instance.subscribeToTopic(EndPoints.topic);
  //     Response response = await dioClient.post(
  //       data: {"_method": "put", "cm_firebase_token": await saveDeviceToken()},
  //       uri: EndPoints.,
  //     );
  //   else {
  //   return left(ServerFailure(response.data['message']));
  //   }
  //   } catch (error) {
  //   return left(ServerFailure(ApiErrorHandler.getMessage(error)));
  //   }
  // }

  // Future<void> saveUserToken({required String token}) async {
  //   try {
  //     dioClient.updateHeader(token: token);
  //     await sharedPreferences.setString(AppStorageKey.token, token);
  //   } catch (e) {
  //     rethrow;
  //   }
  // }

  Future<Either<ServerFailure, Response>> logIn(
      {required String phone, required String password}) async {
    try {
      Response response = await dioClient.post(uri: EndPoints.logIn, data: {
        // "email": mail,
        "phone": phone,
        "password": password,
        "fcm_token": await saveDeviceToken()
      });

      if (response.statusCode == 200) {
        // dioClient.updateHeader(token: response.data['data']["api_token"]);
        return Right(response);
      } else {
        return left(ServerFailure(response.data['message']));
      }
    } catch (error) {
      return left(ServerFailure(ApiErrorHandler.getMessage(error)));
    }
  }

  Future<Either<ServerFailure, Response>> reset(
      {required String password, required String email}) async {
    try {
      Response response =
          await dioClient.post(uri: EndPoints.resetPassword, data: {
        "email": email,
        "newPassword": password,
      });

      if (response.statusCode == 200) {
        return Right(response);
      } else {
        return left(ServerFailure(response.data['message']));
      }
    } catch (error) {
      return left(ServerFailure(ApiErrorHandler.getMessage(error)));
    }
  }

  Future<Either<ServerFailure, Response>> change(
      {required String oldPassword, required String password}) async {
    try {
      Response response = await dioClient.post(
          uri: EndPoints.changePassword(
              sharedPreferences.getString(AppStorageKey.userId)),
          data: {
            "oldPassword": oldPassword,
            "newPassword": password,
          });

      if (response.statusCode == 200) {
        return Right(response);
      } else {
        return left(ServerFailure(response.data['message']));
      }
    } catch (error) {
      return left(ServerFailure(ApiErrorHandler.getMessage(error)));
    }
  }

  Future<Either<ServerFailure, Response>> forgetPassword(
      {required String mail}) async {
    try {
      Response response =
          await dioClient.post(uri: EndPoints.forgetPassword, data: {
        "email": mail,
      });

      if (response.statusCode == 200) {
        return Right(response);
      } else {
        return left(ServerFailure(response.data['message']));
      }
    } catch (error) {
      return left(ServerFailure(ApiErrorHandler.getMessage(error)));
    }
  }

  Future<Either<ServerFailure, Response>> register(
      {required String phone,
      required String name,
      required String mail,
      required String gender,
      required String password}) async {
    try {
      Response response = await dioClient.post(uri: EndPoints.register, data: {
        "name": name,
        "phone": phone,
        "email": mail,
        "gender": gender,
        "password": password,
        "fcm_token": await saveDeviceToken()
      });

      if (response.statusCode == 200) {
        return Right(response);
      } else {
        return left(ServerFailure(response.data['message']));
      }
    } catch (error) {
      return left(ServerFailure(ApiErrorHandler.getMessage(error)));
    }
  }

  Future<Either<ServerFailure, Response>> resendCode(
      {required String mail, required bool fromRegister}) async {
    try {
      Response response = await dioClient.post(
          uri: fromRegister ? EndPoints.resend : EndPoints.forgetPassword,
          data: {
            "email": mail,
          });

      if (response.statusCode == 200) {
        return Right(response);
      } else {
        return left(ServerFailure(response.data['message']));
      }
    } catch (error) {
      return left(ServerFailure(ApiErrorHandler.getMessage(error)));
    }
  }

  Future<Either<ServerFailure, Response>> verifyMail(
      {required String mail,
      required String code,
      required bool fromRegister,
      bool updateHeader = false}) async {
    try {
      Response response = await dioClient.post(
          uri: fromRegister
              ? EndPoints.verifyEmail
              : EndPoints.checkMailForResetPassword,
          data: {"code": code, "email": mail});
      if (response.statusCode == 200) {
        // if(updateHeader) {
        //   dioClient.updateHeader(token: response.data['data']["api_token"]);
        // }
        return Right(response);
      } else {
        return left(ServerFailure(response.data['message']));
      }
    } catch (error) {
      return left(ServerFailure(ApiErrorHandler.getMessage(error)));
    }
  }

  Future<bool> clearSharedData() async {
    await sharedPreferences.remove(AppStorageKey.userId);
    await sharedPreferences.remove(AppStorageKey.isLogin);
    return true;
  }
}
