// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'find_auth_data.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$FindAuthStateImpl _$$FindAuthStateImplFromJson(Map<String, dynamic> json) =>
    _$FindAuthStateImpl(
      isLoading: json['isLoading'] as bool? ?? false,
      isCodeSent: json['isCodeSent'] as bool? ?? false,
      isVerified: json['isVerified'] as bool? ?? false,
      currentAuthType:
          $enumDecodeNullable(_$AuthTypeEnumMap, json['currentAuthType']),
      foundId: json['foundId'] as String?,
      resetToken: json['resetToken'] as String?,
      inputContact: json['inputContact'] as String?,
      errorMessage: json['errorMessage'] as String?,
      successMessage: json['successMessage'] as String?,
    );

Map<String, dynamic> _$$FindAuthStateImplToJson(_$FindAuthStateImpl instance) =>
    <String, dynamic>{
      'isLoading': instance.isLoading,
      'isCodeSent': instance.isCodeSent,
      'isVerified': instance.isVerified,
      'currentAuthType': _$AuthTypeEnumMap[instance.currentAuthType],
      'foundId': instance.foundId,
      'resetToken': instance.resetToken,
      'inputContact': instance.inputContact,
      'errorMessage': instance.errorMessage,
      'successMessage': instance.successMessage,
    };

const _$AuthTypeEnumMap = {
  AuthType.findId: 'findId',
  AuthType.findPw: 'findPw',
  AuthType.signUp: 'signUp',
};
