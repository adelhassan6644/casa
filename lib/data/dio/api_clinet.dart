abstract class ApiClient {
  Future<dynamic> post(
      {required String uri, Map<String, dynamic>? queryParameters, data});

  Future get({
    required String uri,
    Map<String, dynamic> queryParameters,
  });

  Future<dynamic> put(
      {required String uri, Map<String, dynamic>? queryParameters, data});


  Future<dynamic> patch(
      {required String uri, Map<String, dynamic>? queryParameters, data});

  Future<dynamic> delete(
      {required String uri, Map<String, dynamic>? queryParameters, data});
}
