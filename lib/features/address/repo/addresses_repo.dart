import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../app/core/utils/app_storage_keys.dart';
import '../../../data/api/end_points.dart';
import '../../../data/dio/dio_client.dart';
import '../../../data/error/api_error_handler.dart';
import '../../../data/error/failures.dart';
import '../../maps/models/location_model.dart';

class AddressesRepo {
  final DioClient dioClient;
  final SharedPreferences sharedPreferences;

  AddressesRepo({required this.dioClient, required this.sharedPreferences});

  bool isLoggedIn() {
    return sharedPreferences.containsKey(AppStorageKey.isLogin);
  }

  Future<Either<ServerFailure, Response>> getAddresses() async {
    try {
      Response response = await dioClient.get(
          uri: EndPoints.getAddresses(
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

  Future<Either<ServerFailure, Response>> addAddress(
      {required LocationModel address, required int type}) async {
    try {
      Response response =
          await dioClient.post(uri: EndPoints.addAddress, queryParameters: {
        "client_id": sharedPreferences.getString(AppStorageKey.userId),
        "lat": address.latitude,
        "long": address.longitude,
        "address": address.address,
        "type": type,
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
}
