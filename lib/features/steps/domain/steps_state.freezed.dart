// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'steps_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$StepsState {
  DailyRecord? get dailyRecord => throw _privateConstructorUsedError;
  bool get isLoading => throw _privateConstructorUsedError;
  String? get error => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $StepsStateCopyWith<StepsState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $StepsStateCopyWith<$Res> {
  factory $StepsStateCopyWith(
          StepsState value, $Res Function(StepsState) then) =
      _$StepsStateCopyWithImpl<$Res, StepsState>;
  @useResult
  $Res call({DailyRecord? dailyRecord, bool isLoading, String? error});

  $DailyRecordCopyWith<$Res>? get dailyRecord;
}

/// @nodoc
class _$StepsStateCopyWithImpl<$Res, $Val extends StepsState>
    implements $StepsStateCopyWith<$Res> {
  _$StepsStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? dailyRecord = freezed,
    Object? isLoading = null,
    Object? error = freezed,
  }) {
    return _then(_value.copyWith(
      dailyRecord: freezed == dailyRecord
          ? _value.dailyRecord
          : dailyRecord // ignore: cast_nullable_to_non_nullable
              as DailyRecord?,
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

  @override
  @pragma('vm:prefer-inline')
  $DailyRecordCopyWith<$Res>? get dailyRecord {
    if (_value.dailyRecord == null) {
      return null;
    }

    return $DailyRecordCopyWith<$Res>(_value.dailyRecord!, (value) {
      return _then(_value.copyWith(dailyRecord: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$StepsStateImplCopyWith<$Res>
    implements $StepsStateCopyWith<$Res> {
  factory _$$StepsStateImplCopyWith(
          _$StepsStateImpl value, $Res Function(_$StepsStateImpl) then) =
      __$$StepsStateImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({DailyRecord? dailyRecord, bool isLoading, String? error});

  @override
  $DailyRecordCopyWith<$Res>? get dailyRecord;
}

/// @nodoc
class __$$StepsStateImplCopyWithImpl<$Res>
    extends _$StepsStateCopyWithImpl<$Res, _$StepsStateImpl>
    implements _$$StepsStateImplCopyWith<$Res> {
  __$$StepsStateImplCopyWithImpl(
      _$StepsStateImpl _value, $Res Function(_$StepsStateImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? dailyRecord = freezed,
    Object? isLoading = null,
    Object? error = freezed,
  }) {
    return _then(_$StepsStateImpl(
      dailyRecord: freezed == dailyRecord
          ? _value.dailyRecord
          : dailyRecord // ignore: cast_nullable_to_non_nullable
              as DailyRecord?,
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

class _$StepsStateImpl implements _StepsState {
  const _$StepsStateImpl(
      {this.dailyRecord, this.isLoading = false, this.error});

  @override
  final DailyRecord? dailyRecord;
  @override
  @JsonKey()
  final bool isLoading;
  @override
  final String? error;

  @override
  String toString() {
    return 'StepsState(dailyRecord: $dailyRecord, isLoading: $isLoading, error: $error)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$StepsStateImpl &&
            (identical(other.dailyRecord, dailyRecord) ||
                other.dailyRecord == dailyRecord) &&
            (identical(other.isLoading, isLoading) ||
                other.isLoading == isLoading) &&
            (identical(other.error, error) || other.error == error));
  }

  @override
  int get hashCode => Object.hash(runtimeType, dailyRecord, isLoading, error);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$StepsStateImplCopyWith<_$StepsStateImpl> get copyWith =>
      __$$StepsStateImplCopyWithImpl<_$StepsStateImpl>(this, _$identity);
}

abstract class _StepsState implements StepsState {
  const factory _StepsState(
      {final DailyRecord? dailyRecord,
      final bool isLoading,
      final String? error}) = _$StepsStateImpl;

  @override
  DailyRecord? get dailyRecord;
  @override
  bool get isLoading;
  @override
  String? get error;
  @override
  @JsonKey(ignore: true)
  _$$StepsStateImplCopyWith<_$StepsStateImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
