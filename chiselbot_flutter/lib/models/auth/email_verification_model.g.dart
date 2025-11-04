// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'email_verification_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$EmailVerificationRequestImpl _$$EmailVerificationRequestImplFromJson(
        Map<String, dynamic> json) =>
    _$EmailVerificationRequestImpl(
      email: json['email'] as String,
    );

Map<String, dynamic> _$$EmailVerificationRequestImplToJson(
        _$EmailVerificationRequestImpl instance) =>
    <String, dynamic>{
      'email': instance.email,
    };

_$EmailVerificationVerifyRequestImpl
    _$$EmailVerificationVerifyRequestImplFromJson(Map<String, dynamic> json) =>
        _$EmailVerificationVerifyRequestImpl(
          email: json['email'] as String,
          code: json['code'] as String,
        );

Map<String, dynamic> _$$EmailVerificationVerifyRequestImplToJson(
        _$EmailVerificationVerifyRequestImpl instance) =>
    <String, dynamic>{
      'email': instance.email,
      'code': instance.code,
    };
