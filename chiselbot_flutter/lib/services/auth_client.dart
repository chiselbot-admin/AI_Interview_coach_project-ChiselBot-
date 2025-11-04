import 'package:dio/dio.dart';

class AuthClient {
  static const String baseUrl = 'http://10.0.2.2:8080'; // 에뮬레이터용

  final Dio _dio;

  AuthClient()
      : _dio = Dio(BaseOptions(
          baseUrl: baseUrl,
          connectTimeout: const Duration(seconds: 5),
          receiveTimeout: const Duration(seconds: 10),
          headers: {
            'Content-Type': 'application/json',
          },
        )) {
    _dio.interceptors.add(LogInterceptor(
      requestBody: true,
      responseBody: true,
    ));
  }

  Dio get dio => _dio;
}
