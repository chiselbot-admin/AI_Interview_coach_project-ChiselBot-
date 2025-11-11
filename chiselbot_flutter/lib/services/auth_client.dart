import 'package:dio/dio.dart';

import '../core/constants.dart';

class AuthClient {
  final Dio _dio;
  AuthClient()
      : _dio = Dio(BaseOptions(
          baseUrl: Constants.baseUrl,
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
