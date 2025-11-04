import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../models/auth/find_auth_data.dart';
import '../models/user_model.dart';
import '../repositories/i_auth_repository.dart';
import 'auth_notifier.dart';

// SignUpNotifier Provider
final signUpNotifierProvider =
    StateNotifierProvider<SignUpNotifier, FindAuthState>((ref) {
  final repository = ref.watch(authRepositoryProvider);
  return SignUpNotifier(repository);
});

class SignUpNotifier extends StateNotifier<FindAuthState> {
  final IAuthRepository _authRepository;

  SignUpNotifier(this._authRepository) : super(const FindAuthState());

  /// 이메일 인증 코드 요청
  Future<void> sendVerificationCode(String email) async {
    state = state.copyWith(isLoading: true, errorMessage: null);
    try {
      final success = await _authRepository.requestVerification(
        contact: email,
        type: AuthType.signUp,
      );
      if (success) {
        state = state.copyWith(
          isLoading: false,
          isCodeSent: true,
          currentAuthType: AuthType.signUp,
        );
      } else {
        state = state.copyWith(
          isLoading: false,
          errorMessage: '인증 코드 전송에 실패했습니다.',
        );
      }
    } catch (e) {
      state = state.copyWith(
        isLoading: false,
        errorMessage: e.toString(),
      );
    }
  }

  /// 인증번호 검증
  Future<void> verifyCode(String email, String code) async {
    state = state.copyWith(isLoading: true, errorMessage: null);
    try {
      await _authRepository.verifyCode(
        contact: email,
        code: code,
        type: AuthType.signUp,
      );
      state = state.copyWith(
        isLoading: false,
        isVerified: true,
      );
    } catch (e) {
      state = state.copyWith(
        isLoading: false,
        errorMessage: '인증번호가 올바르지 않습니다.',
      );
    }
  }

  /// 회원가입 요청
  Future<void> signUp(UserModel user) async {
    state = state.copyWith(isLoading: true, errorMessage: null);
    try {
      await _authRepository.signUp(user);
      state = state.copyWith(
        isLoading: false,
        isVerified: false,
        isCodeSent: false,
        successMessage: '회원가입이 완료되었습니다!',
      );
    } catch (e) {
      state = state.copyWith(
        isLoading: false,
        errorMessage: '회원가입에 실패했습니다: ${e.toString()}',
      );
    }
  }

  /// 상태 초기화 (회원가입 화면 닫을 때 등)
  void reset() {
    state = const FindAuthState();
  }
}
