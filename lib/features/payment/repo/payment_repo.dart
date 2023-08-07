import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../app/core/utils/app_storage_keys.dart';
import '../../../data/api/end_points.dart';
import '../../../data/dio/dio_client.dart';
import '../../../data/error/api_error_handler.dart';
import '../../../data/error/failures.dart';

class PaymentRepo {
  final DioClient dioClient;
  final SharedPreferences sharedPreferences;
  PaymentRepo({required this.dioClient, required this.sharedPreferences});

  Future<Either<ServerFailure, Response>> reserveOffer(
      {required requestModel}) async {
    try {
      Response response = await dioClient.post(uri: EndPoints.checkOut, data: {
        'client_id': sharedPreferences.getString(AppStorageKey.userId),
        "sub_service_id":
            requestModel.driverModel?.id ?? requestModel.offer?.driverModel?.id,
      });
      if (response.statusCode == 200) {
        return Right(response);
      } else {
        return left(ServerFailure(response.data['message']));
      }
    } catch (e) {
      return left(ServerFailure(ApiErrorHandler.getMessage(e)));
    }
  }
}
