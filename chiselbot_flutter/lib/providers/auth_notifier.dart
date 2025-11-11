import 'package:ai_interview/core/constants.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:kakao_flutter_sdk_user/kakao_flutter_sdk_user.dart';

import '../models/auth/auth_state.dart';
import '../models/user_model.dart';
import '../repositories/auth_repository.dart';
import '../repositories/i_auth_repository.dart';
import '../services/api_service.dart';
import '../services/auth_api_service.dart';
import '../services/auth_client.dart';

// 1. AuthClient Provider
final authClientProvider = Provider<AuthClient>((ref) {
  return AuthClient();
});

// 2. AuthApiService Provider
final authApiServiceProvider = Provider<AuthApiService>((ref) {
  final apiService = ApiService(Constants.baseUrl);
  final authClient = ref.watch(authClientProvider);
  return AuthApiService(apiService, authClient);
});

// 3. IAuthRepository Provider
final authRepositoryProvider = Provider<IAuthRepository>((ref) {
  final authApiService = ref.watch(authApiServiceProvider);
  return AuthRepository(authApiService);
});

// 4. AuthState를 관리하는 Notifier Provider
final authNotifierProvider =
    StateNotifierProvider<AuthNotifier, AuthState>((ref) {
  final repository = ref.watch(authRepositoryProvider);

  // AuthApiService가 갖고 있는 ApiService를 뽑아서 전달
  final api = ref.watch(authApiServiceProvider).api;

  return AuthNotifier(repository, api);
});

final currentUserInfoProvider =
    Provider<(String, String, String?, bool)>((ref) {
  final authState = ref.watch(authNotifierProvider);

  return authState.maybeWhen(
    (isLoading, isLoggedIn, user, token, errorMessage) {
      if (isLoggedIn && user != null) {
        final name = user.name?.isNotEmpty == true ? user.name! : '개발자';
        final bool isKakaoUser = user.email.contains('placeholder.kakao');
        final String displayEmail = isKakaoUser ? '# 카카오 계정 연동' : user.email;
        return (name, displayEmail, user.profileImageUrl, true);
      }
      return ('개발자', '로그인해주세요', null, false);
    },
    orElse: () => ('개발자', '로그인해주세요', null, false),
  );
});

class AuthNotifier extends StateNotifier<AuthState> {
  final IAuthRepository _authRepository;
  final ApiService _api;

  AuthNotifier(this._authRepository, this._api) : super(const AuthState());

  /// 로그인
  Future<void> login({
    required String email,
    required String password,
  }) async {
    // 1. 로딩 상태 시작
    state = state.when(
      (isLoading, isLoggedIn, user, token, errorMessage) => AuthState(
        isLoading: true,
        isLoggedIn: isLoggedIn,
        user: user,
        token: token,
        errorMessage: null,
      ),
      unauthenticated: () => const AuthState(
        isLoading: true,
        errorMessage: null,
      ),
    );

    try {
      // 2. Repository 호출
      final result = await _authRepository.login(
        email: email,
        password: password,
      );

      // 3. 사용자 정보 생성 (실제로는 서버에서 받아옴)
      final user = UserModel(
        email: email,
        password: '',
        phoneNumber: '',
        name: result.name!,
        userId: result.userEmail,
      );

      // ApiService에 토큰 주입
      _api.setToken(result.token);

      // 4. 상태 업데이트 (성공)
      state = AuthState(
        isLoading: false,
        isLoggedIn: true,
        user: user,
        token: result.token,
      );
    } catch (e) {
      // 5. 에러 처리
      state = state.when(
        (isLoading, isLoggedIn, user, token, errorMessage) => AuthState(
          isLoading: false,
          isLoggedIn: isLoggedIn,
          user: user,
          token: token,
          errorMessage: '로그인에 실패했습니다. 아이디와 비밀번호를 확인해주세요.',
        ),
        unauthenticated: () => const AuthState(
          isLoading: false,
          errorMessage: '로그인에 실패했습니다. 아이디와 비밀번호를 확인해주세요.',
        ),
      );
      rethrow;
    }
  }

  /// 카카오 로그인
  Future<void> loginWithKakao() async {
    state = state.when(
      (isLoading, isLoggedIn, user, token, errorMessage) => AuthState(
        isLoading: true,
        isLoggedIn: isLoggedIn,
        user: user,
        token: token,
        errorMessage: null,
      ),
      unauthenticated: () =>
          const AuthState(isLoading: true, errorMessage: null),
    );

    try {
      // 1. 카카오톡 설치 여부 확인
      bool isInstalled = await isKakaoTalkInstalled();

      OAuthToken token;
      if (isInstalled) {
        // 카카오톡으로 로그인
        token = await UserApi.instance.loginWithKakaoTalk();
      } else {
        // 카카오 계정으로 로그인
        token = await UserApi.instance.loginWithKakaoAccount();
      }

      // 2. 서버에 액세스 토큰 전송
      final result = await _authRepository.loginWithKakao(
        accessToken: token.accessToken,
      );

      // 3. 사용자 정보 생성
      final user = UserModel(
        email: result.userEmail.toString(),
        password: '',
        phoneNumber: '',
        name: result.name ?? '카카오 사용자',
        userId: '',
        profileImageUrl: result.profileImageUrl,
      );

      // 4. 상태 업데이트
      state = AuthState(
        isLoading: false,
        isLoggedIn: true,
        user: user,
        token: result.token,
      );
    } catch (e) {
      state = state.when(
        (isLoading, isLoggedIn, user, token, errorMessage) => AuthState(
          isLoading: false,
          isLoggedIn: isLoggedIn,
          user: user,
          token: token,
          errorMessage: '카카오 로그인에 실패했습니다.',
        ),
        unauthenticated: () => const AuthState(
          isLoading: false,
          errorMessage: '카카오 로그인에 실패했습니다.',
        ),
      );
      rethrow;
    }
  }

  /// 회원가입
  Future<void> signUp(UserModel user) async {
    // 1. 로딩 상태 시작
    state = state.when(
      (isLoading, isLoggedIn, userModel, token, errorMessage) => AuthState(
        isLoading: true,
        isLoggedIn: isLoggedIn,
        user: userModel,
        token: token,
        errorMessage: null,
      ),
      unauthenticated: () => const AuthState(
        isLoading: true,
        errorMessage: null,
      ),
    );

    try {
      // 2. Repository 호출
      await _authRepository.signUp(user);

      // 3. 상태 업데이트 (성공)
      state = state.when(
        (isLoading, isLoggedIn, userModel, token, errorMessage) => AuthState(
          isLoading: false,
          isLoggedIn: isLoggedIn,
          user: userModel,
          token: token,
        ),
        unauthenticated: () => const AuthState(isLoading: false),
      );
    } catch (e) {
      // 4. 에러 처리
      state = state.when(
        (isLoading, isLoggedIn, userModel, token, errorMessage) => AuthState(
          isLoading: false,
          isLoggedIn: isLoggedIn,
          user: userModel,
          token: token,
          errorMessage: '회원가입에 실패했습니다. 다시 시도해주세요.',
        ),
        unauthenticated: () => const AuthState(
          isLoading: false,
          errorMessage: '회원가입에 실패했습니다. 다시 시도해주세요.',
        ),
      );
      rethrow;
    }
  }

  /// 로그아웃
  Future<void> logout() async {
    // ApiService에서 토큰 제거 — 헤더 Authorization 지우기
    _api.setToken(null);
    // 상태 비우기
    state = const AuthState.unauthenticated();
  }

  /// 사용자 이름 업데이트 (프로필 수정 후)
  void updateUserName(String name) {
    state = state.when(
      (isLoading, isLoggedIn, user, token, errorMessage) {
        if (user != null) {
          return AuthState(
            isLoading: isLoading,
            isLoggedIn: isLoggedIn,
            user: user.copyWith(name: name),
            token: token,
            errorMessage: errorMessage,
          );
        }
        return AuthState(
          isLoading: isLoading,
          isLoggedIn: isLoggedIn,
          user: user,
          token: token,
          errorMessage: errorMessage,
        );
      },
      unauthenticated: () => const AuthState.unauthenticated(),
    );
  }

  /// 에러 메시지 초기화
  void clearError() {
    state = state.when(
      (isLoading, isLoggedIn, user, token, errorMessage) => AuthState(
        isLoading: isLoading,
        isLoggedIn: isLoggedIn,
        user: user,
        token: token,
        errorMessage: null,
      ),
      unauthenticated: () => const AuthState.unauthenticated(),
    );
  }
}
