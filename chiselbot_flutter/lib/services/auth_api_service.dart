import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import '../models/auth/auth_result_model.dart';
import '../models/auth/user_update_request_model.dart';
import '../models/login/login_request_model.dart';
import '../models/user_model.dart';
import 'api_service.dart';
import 'auth_client.dart';

class AuthApiService {
  final ApiService _apiService;
  final AuthClient _authClient;

  AuthApiService(this._apiService, this._authClient);

  // 외부에서 동일 ApiService를 꺼내 쓰기 위한 게터
  ApiService get api => _apiService;

  Future<AuthResultModel> login({required LoginRequestModel request}) async {
    // URL 경로 확정 (type=Local 사용)
    const String path = '/api/users/login/Local';

    try {
      final Response<Map<String, dynamic>> response =
          await _authClient.dio.post(
        path,
        data: request.toJson(),
      );

      // Dio는 200 응답일 때만 try 블록을 실행
      final Map<String, dynamic> responseData = response.data!;
      final Map<String, dynamic> dataMap =
          responseData['data'] as Map<String, dynamic>;
      final AuthResultModel authResult = AuthResultModel.fromJson(dataMap);
      if (authResult.token != null) {
        _apiService.setToken(authResult.token);
      }
      return authResult;
    } on DioException catch (e) {
      final responseData = e.response?.data;
      final String errorMessage =
          responseData?['message'] ?? '알 수 없는 오류가 발생했습니다.';

      if (errorMessage.contains('가입되지 않은 이메일입니다') ||
          errorMessage.contains('잘못된 비밀번호 입니다')) {
        throw Exception(errorMessage);
      }
      throw Exception('로그인 실패: [${e.response?.statusCode}] $errorMessage');
    } catch (e) {
      rethrow;
    }
  }

  // 이메일 인증 코드 발송
  Future<void> sendEmailVerification({required String email}) async {
    const String path = '/api/auth/email/send';

    try {
      await _authClient.dio.post(
        path,
        data: {'email': email},
      );
    } on DioException catch (e) {
      final responseData = e.response?.data;
      final String errorMessage =
          responseData?['message'] ?? '인증번호 전송에 실패했습니다.';
      throw Exception(errorMessage);
    }
  }

  // 이메일 인증 코드 확인
  Future<void> verifyEmailCode({
    required String email,
    required String code,
  }) async {
    const String path = '/api/auth/email/verify';

    try {
      await _authClient.dio.post(
        path,
        data: {
          'email': email,
          'code': code,
        },
      );
    } on DioException catch (e) {
      final responseData = e.response?.data;
      final String errorMessage =
          responseData?['message'] ?? '인증번호 확인에 실패했습니다.';
      throw Exception(errorMessage);
    }
  }

  // 회원가입
  Future<void> signUp({
    required String email,
    required String password,
    required String name,
  }) async {
    const String path = '/api/users/signup';

    try {
      await _authClient.dio.post(
        path,
        data: {
          'email': email,
          'password': password,
          'name': name,
        },
      );
    } on DioException catch (e) {
      final responseData = e.response?.data;
      final String errorMessage = responseData?['message'] ?? '회원가입에 실패했습니다.';
      throw Exception(errorMessage);
    }
  }

  /// 내 정보 조회 (JWT 기반)
  /// GET /api/users/me
  Future<UserModel> getMyProfile({required String token}) async {
    const String path = '/api/users/me';

    try {
      final Response<Map<String, dynamic>> response = await _authClient.dio.get(
        path,
        options: Options(
          headers: {'Authorization': 'Bearer $token'},
        ),
      );

      final Map<String, dynamic> responseData = response.data!;
      final Map<String, dynamic> dataMap =
          responseData['data'] as Map<String, dynamic>;

      return UserModel.fromJson(dataMap);
    } on DioException catch (e) {
      final responseData = e.response?.data;
      final String errorMessage =
          responseData?['message'] ?? '회원정보 조회에 실패했습니다.';
      throw Exception(errorMessage);
    }
  }

  /// 회원정보 수정
  /// PATCH /api/users/update
  Future<void> updateProfile({
    required String token,
    required UserUpdateRequestModel request,
  }) async {
    const String path = '/api/users/update';

    try {
      await _authClient.dio.patch(
        path,
        data: request.toJson(),
        options: Options(
          headers: {'Authorization': 'Bearer $token'},
        ),
      );
    } on DioException catch (e) {
      final responseData = e.response?.data;
      final String errorMessage =
          responseData?['message'] ?? '회원정보 수정에 실패했습니다.';
      throw Exception(errorMessage);
    }
  }

  /// 이름으로 이메일 찾기 (마스킹된 이메일 반환)
  /// POST /api/users/find-email
  Future<String> findEmailByName({required String name}) async {
    const String path = '/api/users/find-email';

    try {
      final Response<Map<String, dynamic>> response =
          await _authClient.dio.post(
        path,
        data: {'name': name},
      );

      final Map<String, dynamic> responseData = response.data!;
      final Map<String, dynamic> dataMap =
          responseData['data'] as Map<String, dynamic>;

      return dataMap['email'] as String;
    } on DioException catch (e) {
      final responseData = e.response?.data;
      final String errorMessage = responseData?['message'] ?? '이메일 찾기에 실패했습니다.';
      throw Exception(errorMessage);
    }
  }

  /// 비밀번호 찾기용 인증번호 전송
  /// POST /api/users/find-password
  Future<void> sendPasswordResetCode({required String email}) async {
    const String path = '/api/users/find-password';

    try {
      await _authClient.dio.post(
        path,
        data: {'email': email},
      );
    } on DioException catch (e) {
      final responseData = e.response?.data;
      final String errorMessage =
          responseData?['message'] ?? '비밀번호 인증번호 전송에 실패했습니다.';
      throw Exception(errorMessage);
    }
  }

  /// 비밀번호 재설정
  /// POST /api/users/reset-password
  Future<void> resetPassword({
    required String email,
    required String newPassword,
  }) async {
    const String path = '/api/users/reset-password';

    try {
      await _authClient.dio.post(
        path,
        data: {
          'email': email,
          'newPassword': newPassword,
        },
      );
    } on DioException catch (e) {
      final responseData = e.response?.data;
      final String errorMessage =
          responseData?['message'] ?? '비밀번호 재설정에 실패했습니다.';
      throw Exception(errorMessage);
    }
  }

  /// 카카오 액세스 토큰으로 로그인
  Future<AuthResultModel> loginWithKakao({required String accessToken}) async {
    const String path = '/oauth/kakao/token';

    try {
      final Response<Map<String, dynamic>> response =
          await _authClient.dio.post(
        path,
        data: {'accessToken': accessToken},
      );

      final Map<String, dynamic> responseData = response.data!;
      debugPrint('[AUTH_API] 서버 응답: $responseData'); // 👈 추가

      final Map<String, dynamic> dataMap =
          responseData['data'] as Map<String, dynamic>;
      final AuthResultModel authResult = AuthResultModel.fromJson(dataMap);
      debugPrint('[AUTH_API] authResult: ${authResult.userEmail}'); // 👈 추가

      if (authResult.token != null) {
        _apiService.setToken(authResult.token);
      }
      return authResult;
    } on DioException catch (e) {
      final responseData = e.response?.data;
      final String errorMessage =
          responseData?['message'] ?? '카카오 로그인에 실패했습니다.';
      throw Exception(errorMessage);
    }
  }
}
