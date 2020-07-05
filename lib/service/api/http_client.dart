import 'package:cookie_jar/cookie_jar.dart';
import 'package:dio/dio.dart';
import 'package:dio_cookie_manager/dio_cookie_manager.dart';
import 'package:flutter/foundation.dart';
import 'package:phenopod/model/main.dart';

class HttpClient {
  final Dio dio;

  HttpClient({String appDocDirPath})
      : dio = Dio(
          BaseOptions(
            baseUrl: kReleaseMode
                ? 'https://phenopod.com/api'
                : 'https://phenopod.com/api', //  'http://192.168.1.27:8080/api',
            connectTimeout: 5000,
            receiveTimeout: 3000,
            headers: <String, dynamic>{'X-PHENOPOD-CLIENT': 'android'},
          ),
        )..interceptors.add(
            CookieManager(PersistCookieJar(dir: '$appDocDirPath/.cookies/')),
          );

  Future<ApiResponse> makeRequest({
    @required String path,
    String method,
    Map<String, String> queryParams,
    Map<String, dynamic> body,
  }) async {
    final response = await dio.request(
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
