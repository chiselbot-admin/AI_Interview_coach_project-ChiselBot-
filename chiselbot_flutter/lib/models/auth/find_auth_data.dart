import 'package:freezed_annotation/freezed_annotation.dart';

part 'find_auth_data.freezed.dart';
part 'find_auth_data.g.dart';

@JsonEnum()
enum AuthType { findId, findPw, signUp }

@freezed
class FindAuthState with _$FindAuthState {
  const factory FindAuthState({
    @Default(false) bool isLoading,
    @Default(false) bool isCodeSent,
    @Default(false) bool isVerified,
    AuthType? currentAuthType,
    String? foundId,
    String? resetToken,
    String? inputContact,
    String? errorMessage,
    String? successMessage,
  }) = _FindAuthState;

  factory FindAuthState.fromJson(Map<String, dynamic> json) =>
      _$FindAuthStateFromJson(json);
}
