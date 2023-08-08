import 'package:casa/app/core/utils/app_storage_keys.dart';
import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../data/api/end_points.dart';
import '../../../data/dio/dio_client.dart';
import '../../../data/error/api_error_handler.dart';
import '../../../data/error/failures.dart';

class RattingRepo {
  final DioClient dioClient;
  final SharedPreferences sharedPreferences;

  RattingRepo(
      {required this.dioClient, required this.sharedPreferences});

   getUserId()=>sharedPreferences.getString(AppStorageKey.userId);

  Future<Either<ServerFailure, Response>> sendRatting(body) async {
    try {
      Response response =
      await dioClient.post(uri: EndPoints.ratting,data: body);
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
