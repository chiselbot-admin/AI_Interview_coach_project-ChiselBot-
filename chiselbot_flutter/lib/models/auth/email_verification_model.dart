import 'package:freezed_annotation/freezed_annotation.dart';

part 'email_verification_model.freezed.dart';
part 'email_verification_model.g.dart';

@freezed
class EmailVerificationRequest with _$EmailVerificationRequest {
  const factory EmailVerificationRequest({
    required String email,
  }) = _EmailVerificationRequest;

  factory EmailVerificationRequest.fromJson(Map<String, dynamic> json) =>
      _$EmailVerificationRequestFromJson(json);
}

@freezed
class EmailVerificationVerifyRequest with _$EmailVerificationVerifyRequest {
  const factory EmailVerificationVerifyRequest({
    required String email,
    required String code,
  }) = _EmailVerificationVerifyRequest;

  factory EmailVerificationVerifyRequest.fromJson(Map<String, dynamic> json) =>
      _$EmailVerificationVerifyRequestFromJson(json);
}
