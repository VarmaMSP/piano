import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:phenopod/models/api_response.dart';

class Request {
  final Dio _dio = Dio(BaseOptions(baseUrl: 'https://phenopod.com/api'));

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
