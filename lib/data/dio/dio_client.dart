import 'dart:io';
import 'package:dio/dio.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../app/localization/provider/localization_provider.dart';
import '../api/end_points.dart';
import '../config/di.dart';
import 'api_clinet.dart';
import 'logging_interceptor.dart';

class DioClient extends ApiClient {
  final String baseUrl;
  final LoggingInterceptor loggingInterceptor;
  final SharedPreferences sharedPreferences;

  final Dio dio;

  DioClient(
    this.baseUrl, {
    required this.dio,
    required this.loggingInterceptor,
    required this.sharedPreferences,
  }) {
    dio
      ..options.baseUrl = baseUrl
      ..options.connectTimeout = const Duration(seconds: 60)
      ..options.receiveTimeout = const Duration(seconds: 60)
      ..httpClientAdapter
      ..options.headers = {
        'Content-Type': 'application/json; charset=UTF-8',
        "Accept": " application/json",
        'x-api-key': EndPoints.apiKey,
        "lang": sl.get<LocalizationProvider>().locale.languageCode
        // if (sharedPreferences.getString(AppStorageKey.apiToken) != null)
        //   'x-api-key': sharedPreferences.getString(AppStorageKey.apiToken)
      };
    dio.interceptors.add(PrettyDioLogger(
        request: true,
        responseBody: true,
        requestBody: true,
        requestHeader: true));
  }

  // Future<void> updateHeader({required String token}) async {
  //   dio.options.headers = {
  //     'Content-Type': 'application/json; charset=UTF-8',
  //     "Accept": " application/json",
  //     'x-api-key': token
  //   };
  // }

  @override
  Future<Response> get({
    required String uri,
    bool useGoogleUri = false,
    Map<String, dynamic>? queryParameters,
  }) async {
    try {
      if (useGoogleUri) {
        dio.options.baseUrl = EndPoints.googleMapsBaseUrl;
      } else {
        dio.options.baseUrl = baseUrl;
      }
      var response = await dio.get(uri, queryParameters: queryParameters);

      return response;
    } on SocketException catch (e) {
      throw SocketException(e.toString());
    } on FormatException catch (_) {
      throw const FormatException("Unable to process the data");
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future post(
      {required String uri,
      Map<String, dynamic>? queryParameters,
      data}) async {
    try {
      dio.options.baseUrl = baseUrl;
      var response = await dio.post(
        uri,
        data: data,
        queryParameters: queryParameters,
      );
      return response;
    } on FormatException catch (_) {
      throw const FormatException("Unable to process the data");
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future put(
      {required String uri,
      Map<String, dynamic>? queryParameters,
      data}) async {
    try {
      dio.options.baseUrl = baseUrl;
      var response = await dio.put(
        uri,
        data: data,
        queryParameters: queryParameters,
      );
      return response;
    } on FormatException catch (_) {
      throw const FormatException("Unable to process the data");
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future patch(
      {required String uri,
        Map<String, dynamic>? queryParameters,
        data}) async {
    try {
      dio.options.baseUrl = baseUrl;
      var response = await dio.patch(
        uri,
        data: data,
        queryParameters: queryParameters,
      );
      return response;
    } on FormatException catch (_) {
      throw const FormatException("Unable to process the data");
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future delete(
      {required String uri,
      Map<String, dynamic>? queryParameters,
      data}) async {
    try {
      dio.options.baseUrl = baseUrl;
      var response = await dio.delete(
        uri,
        data: data,
        queryParameters: queryParameters,
      );
      return response;
    } on FormatException catch (_) {
      throw const FormatException("Unable to process the data");
    } catch (e) {
      rethrow;
    }
  }
}
