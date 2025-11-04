import 'package:freezed_annotation/freezed_annotation.dart';

import '../user_model.dart';

part 'auth_state.freezed.dart';
part 'auth_state.g.dart';

// 상태관리 : 로그인 상태 + UserModel 포함
@freezed
class AuthState with _$AuthState {
  const factory AuthState({
    @Default(false) bool isLoading,
    @Default(false) bool isLoggedIn,
    UserModel? user, // UserModel
    String? token,
    String? errorMessage,
  }) = _AuthState;

  const factory AuthState.unauthenticated() = _Unauthenticated;

  factory AuthState.fromJson(Map<String, dynamic> json) =>
      _$AuthStateFromJson(json);
}
