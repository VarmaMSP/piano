import 'dart:developer';

import 'package:cookie_jar/cookie_jar.dart';
import 'package:dio/dio.dart';
import 'package:dio_cookie_manager/dio_cookie_manager.dart';
import 'package:flutter/foundation.dart';
import 'package:path_provider/path_provider.dart';
import 'package:phenopod/models/api_response.dart';

const String apiUrl =
    kReleaseMode ? 'https://phenopod.com/api' : 'http://192.168.1.27:8080/api';

const String thumbnailUrl = kReleaseMode
    ? 'https://cdn.phenopod.com/thumbnails'
    : 'http://192.168.1.27:8080/thumbnails';

final Future<Dio> dioF = () async {
  final appDocDir = await getApplicationDocumentsDirectory();
  final baseOptions = BaseOptions(
    baseUrl: kReleaseMode
        ? 'https://phenopod.com/api'
        : 'http://192.168.1.27:8080/api',
    connectTimeout: 5000,
    receiveTimeout: 3000,
  );
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

class Request {
  final Dio _dio = Dio(BaseOptions(baseUrl: apiUrl));

  Future<ApiResponse> get(String path) async {
    log('making request');

    final response =
        await _dio.get(path, options: Options(responseType: ResponseType.json));

    log(response.toString());

    return ApiResponse.fromJson(response.data as Map<String, dynamic>);
  }

  Future<ApiResponse> post(String path) async {
    final response = await _dio.post(path);
    return ApiResponse.fromJson(response.data as Map<String, dynamic>);
  }
}
