import 'package:dio/dio.dart';
import 'package:piano/models/api_response.dart';

class Request {
  Dio _dio;

  Request() {
    _dio = new Dio(BaseOptions(baseUrl: 'http://localhost:8080/api/'));
  }

  Future<ApiResponse> get(String path) async {
    Response response = await this
        ._dio
        .get(path, options: Options(responseType: ResponseType.json));

    return ApiResponse.fromJson(response.data);
  }

  Future<ApiResponse> post(String path) async {
    Response<Map<String, dynamic>> response = await this._dio.post(path);
    return ApiResponse.fromJson(response.data);
  }
}
