import 'package:dio/dio.dart';
import 'package:phenopod/models/api_response.dart';

class Request {
  final Dio _dio = Dio(BaseOptions(baseUrl: 'https://phenopod.com/api/'));

  Future<ApiResponse> get(String path) async {
    final Response<Map<String, dynamic>> response =
        await _dio.get(path, options: Options(responseType: ResponseType.json));

    return ApiResponse.fromJson(response.data);
  }

  Future<ApiResponse> post(String path) async {
    final Response<Map<String, dynamic>> response = await _dio.post(path);
    return ApiResponse.fromJson(response.data);
  }
}
