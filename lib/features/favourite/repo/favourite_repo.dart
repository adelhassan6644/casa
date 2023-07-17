import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:casa/app/core/utils/app_storage_keys.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../data/api/end_points.dart';
import '../../../data/dio/dio_client.dart';
import '../../../data/error/api_error_handler.dart';
import '../../../data/error/failures.dart';

class FavouriteRepo {
  final DioClient dioClient;
  final SharedPreferences sharedPreferences;

  FavouriteRepo({required this.dioClient, required this.sharedPreferences});

  bool isLoggedIn() {
    return sharedPreferences.containsKey(AppStorageKey.isLogin);
  }

  Future<Either<ServerFailure, Response>> updateFavourite(id) async {
    try {
      Response response = await dioClient.post(
          uri: EndPoints.postFavourite,
          data: {
            "client_id": sharedPreferences.getString(AppStorageKey.userId),
            "place_id": id
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

  Future<Either<ServerFailure, Response>> getFavourites() async {
    try {
      Response response = await dioClient.get(
        uri: EndPoints.getFavourites(
            sharedPreferences.getString(AppStorageKey.userId)),
      );
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
