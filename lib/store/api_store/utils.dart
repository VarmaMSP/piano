import 'package:cookie_jar/cookie_jar.dart';
import 'package:dio/dio.dart';
import 'package:dio_cookie_manager/dio_cookie_manager.dart';
import 'package:flutter/foundation.dart';
import 'package:path_provider/path_provider.dart';
import 'package:phenopod/model/main.dart';

final Future<Dio> dioF = () async {
  final baseOptions = BaseOptions(
    baseUrl:
        kReleaseMode ? 'https://phenopod.com/api' : 'https://phenopod.com/api',
    connectTimeout: 5000,
    receiveTimeout: 3000,
    headers: <String, dynamic>{'X-PHENOPOD-CLIENT': 'android'},
  );

  final appDocDir = await getApplicationDocumentsDirectory();
  final cookieManager = CookieManager(
    PersistCookieJar(dir: '${appDocDir.path}/.cookies/'),
  );

  return Dio(baseOptions)..interceptors.add(cookieManager);
}();

Future<ApiResponse> makeRequest({
  String path,
  String method,
  Map<String, String> queryParams,
  Map<String, dynamic> body,
}) async {
  final dio = await dioF;
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