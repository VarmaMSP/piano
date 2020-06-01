import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:phenopod/models/api_response.dart';

const String apiUrl =
    kReleaseMode ? 'https://phenopod.com/api' : 'http://192.168.1.27:8080/api';

const String thumbnailUrl = kReleaseMode
    ? 'https://cdn.phenopod.com/thumbnails'
    : 'http://192.168.1.27:8080/thumbnails';

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
