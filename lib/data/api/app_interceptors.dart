import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';

import '../../app/core/utils/app_strings.dart';

class AppInterceptors extends Interceptor {
  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    options.headers[AppStrings.contentType] = AppStrings.applicationJson;
    super.onRequest(options, handler);
  }

  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) {

    super.onResponse(response, handler);
  }

  @override
  void onError(DioError err, ErrorInterceptorHandler handler) {

    super.onError(err, handler);
  }
}
