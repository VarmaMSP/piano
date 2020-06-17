import 'package:cookie_jar/cookie_jar.dart';
import 'package:dio/dio.dart';
import 'package:dio_cookie_manager/dio_cookie_manager.dart';
import 'package:flutter/foundation.dart';
import 'package:phenopod/model/main.dart';

class HttpClient {
  Dio _dio;

  HttpClient({@required String appDocDir}) {
    final baseOptions = BaseOptions(
      baseUrl: kReleaseMode
          ? 'https://phenopod.com/api'
          : 'https://phenopod.com/api',
      connectTimeout: 5000,
      receiveTimeout: 3000,
      headers: <String, dynamic>{'X-PHENOPOD-CLIENT': 'android'},
    );

    _dio = Dio(baseOptions)
      ..interceptors.add(
        CookieManager(PersistCookieJar(dir: '$appDocDir/.cookies/')),
      );
  }

  Future<ApiResponse> makeRequest({
    String path,
    String method,
    Map<String, String> queryParams,
    Map<String, dynamic> body,
  }) async {
    final response = await _dio.request(
      path,
      data: body,
      queryParameters: queryParams,
      options: Options(
        method: method,
        responseType: ResponseType.json,
      ),
    );

    return ApiResponse.fromJson(response.data);
  }
}
