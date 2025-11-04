// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'email_verification_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

EmailVerificationRequest _$EmailVerificationRequestFromJson(
    Map<String, dynamic> json) {
  return _EmailVerificationRequest.fromJson(json);
}

/// @nodoc
mixin _$EmailVerificationRequest {
  String get email => throw _privateConstructorUsedError;

  /// Serializes this EmailVerificationRequest to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of EmailVerificationRequest
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $EmailVerificationRequestCopyWith<EmailVerificationRequest> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $EmailVerificationRequestCopyWith<$Res> {
  factory $EmailVerificationRequestCopyWith(EmailVerificationRequest value,
          $Res Function(EmailVerificationRequest) then) =
      _$EmailVerificationRequestCopyWithImpl<$Res, EmailVerificationRequest>;
  @useResult
  $Res call({String email});
}

/// @nodoc
class _$EmailVerificationRequestCopyWithImpl<$Res,
        $Val extends EmailVerificationRequest>
    implements $EmailVerificationRequestCopyWith<$Res> {
  _$EmailVerificationRequestCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of EmailVerificationRequest
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? email = null,
  }) {
    return _then(_value.copyWith(
      email: null == email
          ? _value.email
          : email // ignore: cast_nullable_to_non_nullable
              as String,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$EmailVerificationRequestImplCopyWith<$Res>
    implements $EmailVerificationRequestCopyWith<$Res> {
  factory _$$EmailVerificationRequestImplCopyWith(
          _$EmailVerificationRequestImpl value,
          $Res Function(_$EmailVerificationRequestImpl) then) =
      __$$EmailVerificationRequestImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String email});
}

/// @nodoc
class __$$EmailVerificationRequestImplCopyWithImpl<$Res>
    extends _$EmailVerificationRequestCopyWithImpl<$Res,
        _$EmailVerificationRequestImpl>
    implements _$$EmailVerificationRequestImplCopyWith<$Res> {
  __$$EmailVerificationRequestImplCopyWithImpl(
      _$EmailVerificationRequestImpl _value,
      $Res Function(_$EmailVerificationRequestImpl) _then)
      : super(_value, _then);

  /// Create a copy of EmailVerificationRequest
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? email = null,
  }) {
    return _then(_$EmailVerificationRequestImpl(
      email: null == email
          ? _value.email
          : email // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$EmailVerificationRequestImpl implements _EmailVerificationRequest {
  const _$EmailVerificationRequestImpl({required this.email});

  factory _$EmailVerificationRequestImpl.fromJson(Map<String, dynamic> json) =>
      _$$EmailVerificationRequestImplFromJson(json);

  @override
  final String email;

  @override
  String toString() {
    return 'EmailVerificationRequest(email: $email)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$EmailVerificationRequestImpl &&
            (identical(other.email, email) || other.email == email));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, email);

  /// Create a copy of EmailVerificationRequest
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$EmailVerificationRequestImplCopyWith<_$EmailVerificationRequestImpl>
      get copyWith => __$$EmailVerificationRequestImplCopyWithImpl<
          _$EmailVerificationRequestImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$EmailVerificationRequestImplToJson(
      this,
    );
  }
}

abstract class _EmailVerificationRequest implements EmailVerificationRequest {
  const factory _EmailVerificationRequest({required final String email}) =
      _$EmailVerificationRequestImpl;

  factory _EmailVerificationRequest.fromJson(Map<String, dynamic> json) =
      _$EmailVerificationRequestImpl.fromJson;

  @override
  String get email;

  /// Create a copy of EmailVerificationRequest
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$EmailVerificationRequestImplCopyWith<_$EmailVerificationRequestImpl>
      get copyWith => throw _privateConstructorUsedError;
}

EmailVerificationVerifyRequest _$EmailVerificationVerifyRequestFromJson(
    Map<String, dynamic> json) {
  return _EmailVerificationVerifyRequest.fromJson(json);
}

/// @nodoc
mixin _$EmailVerificationVerifyRequest {
  String get email => throw _privateConstructorUsedError;
  String get code => throw _privateConstructorUsedError;

  /// Serializes this EmailVerificationVerifyRequest to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of EmailVerificationVerifyRequest
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $EmailVerificationVerifyRequestCopyWith<EmailVerificationVerifyRequest>
      get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $EmailVerificationVerifyRequestCopyWith<$Res> {
  factory $EmailVerificationVerifyRequestCopyWith(
          EmailVerificationVerifyRequest value,
          $Res Function(EmailVerificationVerifyRequest) then) =
      _$EmailVerificationVerifyRequestCopyWithImpl<$Res,
          EmailVerificationVerifyRequest>;
  @useResult
  $Res call({String email, String code});
}

/// @nodoc
class _$EmailVerificationVerifyRequestCopyWithImpl<$Res,
        $Val extends EmailVerificationVerifyRequest>
    implements $EmailVerificationVerifyRequestCopyWith<$Res> {
  _$EmailVerificationVerifyRequestCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of EmailVerificationVerifyRequest
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? email = null,
    Object? code = null,
  }) {
    return _then(_value.copyWith(
      email: null == email
          ? _value.email
          : email // ignore: cast_nullable_to_non_nullable
              as String,
      code: null == code
          ? _value.code
          : code // ignore: cast_nullable_to_non_nullable
              as String,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$EmailVerificationVerifyRequestImplCopyWith<$Res>
    implements $EmailVerificationVerifyRequestCopyWith<$Res> {
  factory _$$EmailVerificationVerifyRequestImplCopyWith(
          _$EmailVerificationVerifyRequestImpl value,
          $Res Function(_$EmailVerificationVerifyRequestImpl) then) =
      __$$EmailVerificationVerifyRequestImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String email, String code});
}

/// @nodoc
class __$$EmailVerificationVerifyRequestImplCopyWithImpl<$Res>
    extends _$EmailVerificationVerifyRequestCopyWithImpl<$Res,
        _$EmailVerificationVerifyRequestImpl>
    implements _$$EmailVerificationVerifyRequestImplCopyWith<$Res> {
  __$$EmailVerificationVerifyRequestImplCopyWithImpl(
      _$EmailVerificationVerifyRequestImpl _value,
      $Res Function(_$EmailVerificationVerifyRequestImpl) _then)
      : super(_value, _then);

  /// Create a copy of EmailVerificationVerifyRequest
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? email = null,
    Object? code = null,
  }) {
    return _then(_$EmailVerificationVerifyRequestImpl(
      email: null == email
          ? _value.email
          : email // ignore: cast_nullable_to_non_nullable
              as String,
      code: null == code
          ? _value.code
          : code // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$EmailVerificationVerifyRequestImpl
    implements _EmailVerificationVerifyRequest {
  const _$EmailVerificationVerifyRequestImpl(
      {required this.email, required this.code});

  factory _$EmailVerificationVerifyRequestImpl.fromJson(
          Map<String, dynamic> json) =>
      _$$EmailVerificationVerifyRequestImplFromJson(json);

  @override
  final String email;
  @override
  final String code;

  @override
  String toString() {
    return 'EmailVerificationVerifyRequest(email: $email, code: $code)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$EmailVerificationVerifyRequestImpl &&
            (identical(other.email, email) || other.email == email) &&
            (identical(other.code, code) || other.code == code));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, email, code);

  /// Create a copy of EmailVerificationVerifyRequest
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$EmailVerificationVerifyRequestImplCopyWith<
          _$EmailVerificationVerifyRequestImpl>
      get copyWith => __$$EmailVerificationVerifyRequestImplCopyWithImpl<
          _$EmailVerificationVerifyRequestImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$EmailVerificationVerifyRequestImplToJson(
      this,
    );
  }
}

abstract class _EmailVerificationVerifyRequest
    implements EmailVerificationVerifyRequest {
  const factory _EmailVerificationVerifyRequest(
      {required final String email,
      required final String code}) = _$EmailVerificationVerifyRequestImpl;

  factory _EmailVerificationVerifyRequest.fromJson(Map<String, dynamic> json) =
      _$EmailVerificationVerifyRequestImpl.fromJson;

  @override
  String get email;
  @override
  String get code;

  /// Create a copy of EmailVerificationVerifyRequest
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$EmailVerificationVerifyRequestImplCopyWith<
          _$EmailVerificationVerifyRequestImpl>
      get copyWith => throw _privateConstructorUsedError;
}
