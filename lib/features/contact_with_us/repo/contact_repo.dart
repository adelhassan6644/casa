import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:casa/data/dio/dio_client.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../data/api/end_points.dart';
import '../../../data/error/api_error_handler.dart';
import '../../../data/error/failures.dart';

class ContactRepo {
  DioClient dioClient;
  SharedPreferences sharedPreferences;
  ContactRepo({required this.dioClient, required this.sharedPreferences});

  Future<Either<ServerFailure, Response>> getContact() async {
    try {
      Response response = await dioClient.get(
        uri: "",
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
