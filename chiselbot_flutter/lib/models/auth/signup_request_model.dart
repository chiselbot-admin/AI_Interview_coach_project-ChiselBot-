import 'package:freezed_annotation/freezed_annotation.dart';

part 'signup_request_model.freezed.dart';
part 'signup_request_model.g.dart';

@freezed
class SignUpRequestModel with _$SignUpRequestModel {
  const factory SignUpRequestModel({
    required String email,
    required String password,
    required String phoneNumber,
    required String name,
  }) = _SignUpRequestModel;

  factory SignUpRequestModel.fromJson(Map<String, dynamic> json) =>
      _$SignUpRequestModelFromJson(json);
}
