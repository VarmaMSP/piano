import 'package:cookie_jar/cookie_jar.dart';
import 'package:dio/dio.dart';
import 'package:dio_cookie_manager/dio_cookie_manager.dart';
import 'package:flutter/foundation.dart';
import 'package:path_provider/path_provider.dart';
import 'package:phenopod/model/main.dart';

/// Because you cannot use platform channels in background isolate
/// you need to pass appDocDirPath if this method is being called from
/// a background isolate
Future<HttpClient> newHttpClient({String appDocDirPath}) async {
  appDocDirPath ??= (await getApplicationDocumentsDirectory()).path;
  return HttpClient.new_(appDocDirPath);
}

class HttpClient {
  final Dio dio;

  HttpClient({this.dio});

  factory HttpClient.new_(String appDocDir) {
    final baseOptions = BaseOptions(
      baseUrl: kReleaseMode
          ? 'https://phenopod.com/api'
          : 'https://phenopod.com/api',
      connectTimeout: 5000,
      receiveTimeout: 3000,
      headers: <String, dynamic>{'X-PHENOPOD-CLIENT': 'android'},
    );

    return HttpClient(
      dio: Dio(baseOptions)
        ..interceptors.add(
          CookieManager(PersistCookieJar(dir: '$appDocDir/.cookies/')),
        ),
    );
  }

  Future<ApiResponse> makeRequest({
    String path,
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
