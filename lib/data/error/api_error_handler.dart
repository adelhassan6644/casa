import 'dart:developer';

import 'package:dio/dio.dart';

class ApiErrorHandler {
  static dynamic getMessage(error) {
    dynamic errorDescription = "";
    if (error is Exception) {
      try {
        if (error is DioError) {
          switch (error.type) {
            case DioErrorType.cancel:
              errorDescription = "Request to API server was cancelled";
              break;
            case DioErrorType.connectionTimeout:
              errorDescription = "Connection timeout with API server";
              break;
            case DioErrorType.unknown:
              errorDescription =
                  "Connection to API server failed due to internet connection";
              break;
            case DioErrorType.receiveTimeout:
              errorDescription =
                  "Receive timeout in connection with API server";
              break;
            case DioErrorType.badResponse:
              switch (error.response!.statusCode) {
                case 404:
                  return errorDescription = error.response!.data["message"];
                case 500:
                case 503:
                  errorDescription = error.response!.statusMessage;
                  break;
                default:
                  log(error.response!.data.toString());

                  try {
                    errorDescription = error.response!.data["message"];
                  } catch (e) {
                    errorDescription = error.response!.data['data']["message"];
                  }
              }
              break;
            case DioErrorType.sendTimeout:
              errorDescription = "Send timeout with server";
              break;
            case DioErrorType.badCertificate:
              errorDescription = "Bad Certificate with server";
              break;
            case DioErrorType.connectionError:
              errorDescription = "Connection Error with server";
              break;
          }
        } else {
          errorDescription = "Unexpected error occured";
        }
      } on FormatException catch (e) {
        errorDescription = e.toString();
      }
    } else {
      errorDescription = "Some thing went wrong";
    }
    return errorDescription;
  }
}
