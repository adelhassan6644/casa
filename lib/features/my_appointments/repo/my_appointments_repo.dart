import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../app/core/utils/app_storage_keys.dart';
import '../../../data/api/end_points.dart';
import '../../../data/dio/dio_client.dart';
import '../../../data/error/api_error_handler.dart';
import '../../../data/error/failures.dart';

class MyAppointmentsRepo {
  final DioClient dioClient;
  final SharedPreferences sharedPreferences;

  MyAppointmentsRepo(
      {required this.dioClient, required this.sharedPreferences});

  bool isLoggedIn() {
    return sharedPreferences.containsKey(AppStorageKey.isLogin);
  }

  Future<Either<ServerFailure, Response>> getNextMyAppointments() async {
    try {
      Response response = await dioClient.get(
          uri: EndPoints.myNextAppointments(
              sharedPreferences.getString(AppStorageKey.userId)));
      if (response.statusCode == 200) {
        return Right(response);
      } else {
        return left(ServerFailure(response.data['message']));
      }
    } catch (error) {
      return left(ServerFailure(ApiErrorHandler.getMessage(error)));
    }
  }

  Future<Either<ServerFailure, Response>> getPreviousMyAppointments() async {
    try {
      Response response = await dioClient.get(
          uri: EndPoints.myPreviousAppointments(
              sharedPreferences.getString(AppStorageKey.userId)));
      if (response.statusCode == 200) {
        return Right(response);
      } else {
        return left(ServerFailure(response.data['message']));
      }
    } catch (error) {
      return left(ServerFailure(ApiErrorHandler.getMessage(error)));
    }
  }
}
