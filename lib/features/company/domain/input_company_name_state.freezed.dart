// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'input_company_name_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$InputCompanyNameState {
  String get companyName => throw _privateConstructorUsedError;
  bool get isLoading => throw _privateConstructorUsedError;
  String? get error => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $InputCompanyNameStateCopyWith<InputCompanyNameState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $InputCompanyNameStateCopyWith<$Res> {
  factory $InputCompanyNameStateCopyWith(InputCompanyNameState value,
          $Res Function(InputCompanyNameState) then) =
      _$InputCompanyNameStateCopyWithImpl<$Res, InputCompanyNameState>;
  @useResult
  $Res call({String companyName, bool isLoading, String? error});
}

/// @nodoc
class _$InputCompanyNameStateCopyWithImpl<$Res,
        $Val extends InputCompanyNameState>
    implements $InputCompanyNameStateCopyWith<$Res> {
  _$InputCompanyNameStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? companyName = null,
    Object? isLoading = null,
    Object? error = freezed,
  }) {
    return _then(_value.copyWith(
      companyName: null == companyName
          ? _value.companyName
          : companyName // ignore: cast_nullable_to_non_nullable
              as String,
      isLoading: null == isLoading
          ? _value.isLoading
          : isLoading // ignore: cast_nullable_to_non_nullable
              as bool,
      error: freezed == error
          ? _value.error
          : error // ignore: cast_nullable_to_non_nullable
              as String?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$InputCompanyNameStateImplCopyWith<$Res>
    implements $InputCompanyNameStateCopyWith<$Res> {
  factory _$$InputCompanyNameStateImplCopyWith(
          _$InputCompanyNameStateImpl value,
          $Res Function(_$InputCompanyNameStateImpl) then) =
      __$$InputCompanyNameStateImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String companyName, bool isLoading, String? error});
}

/// @nodoc
class __$$InputCompanyNameStateImplCopyWithImpl<$Res>
    extends _$InputCompanyNameStateCopyWithImpl<$Res,
        _$InputCompanyNameStateImpl>
    implements _$$InputCompanyNameStateImplCopyWith<$Res> {
  __$$InputCompanyNameStateImplCopyWithImpl(_$InputCompanyNameStateImpl _value,
      $Res Function(_$InputCompanyNameStateImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? companyName = null,
    Object? isLoading = null,
    Object? error = freezed,
  }) {
    return _then(_$InputCompanyNameStateImpl(
      companyName: null == companyName
          ? _value.companyName
          : companyName // ignore: cast_nullable_to_non_nullable
              as String,
      isLoading: null == isLoading
          ? _value.isLoading
          : isLoading // ignore: cast_nullable_to_non_nullable
              as bool,
      error: freezed == error
          ? _value.error
          : error // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc

class _$InputCompanyNameStateImpl implements _InputCompanyNameState {
  const _$InputCompanyNameStateImpl(
      {this.companyName = '', this.isLoading = false, this.error});

  @override
  @JsonKey()
  final String companyName;
  @override
  @JsonKey()
  final bool isLoading;
  @override
  final String? error;

  @override
  String toString() {
    return 'InputCompanyNameState(companyName: $companyName, isLoading: $isLoading, error: $error)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$InputCompanyNameStateImpl &&
            (identical(other.companyName, companyName) ||
                other.companyName == companyName) &&
            (identical(other.isLoading, isLoading) ||
                other.isLoading == isLoading) &&
            (identical(other.error, error) || other.error == error));
  }

  @override
  int get hashCode => Object.hash(runtimeType, companyName, isLoading, error);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$InputCompanyNameStateImplCopyWith<_$InputCompanyNameStateImpl>
      get copyWith => __$$InputCompanyNameStateImplCopyWithImpl<
          _$InputCompanyNameStateImpl>(this, _$identity);
}

abstract class _InputCompanyNameState implements InputCompanyNameState {
  const factory _InputCompanyNameState(
      {final String companyName,
      final bool isLoading,
      final String? error}) = _$InputCompanyNameStateImpl;

  @override
  String get companyName;
  @override
  bool get isLoading;
  @override
  String? get error;
  @override
  @JsonKey(ignore: true)
  _$$InputCompanyNameStateImplCopyWith<_$InputCompanyNameStateImpl>
      get copyWith => throw _privateConstructorUsedError;
}
