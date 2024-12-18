// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'battle_result.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

BattleResult _$BattleResultFromJson(Map<String, dynamic> json) {
  return _BattleResult.fromJson(json);
}

/// @nodoc
mixin _$BattleResult {
  String get winnerId => throw _privateConstructorUsedError;
  String get loserId => throw _privateConstructorUsedError;
  int get winnerSteps => throw _privateConstructorUsedError;
  int get loserSteps => throw _privateConstructorUsedError;
  int get stepsDifference => throw _privateConstructorUsedError;
  int get amountChanged => throw _privateConstructorUsedError;
  int get multiplier => throw _privateConstructorUsedError;
  DateTime get createdAt => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $BattleResultCopyWith<BattleResult> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $BattleResultCopyWith<$Res> {
  factory $BattleResultCopyWith(
          BattleResult value, $Res Function(BattleResult) then) =
      _$BattleResultCopyWithImpl<$Res, BattleResult>;
  @useResult
  $Res call(
      {String winnerId,
      String loserId,
      int winnerSteps,
      int loserSteps,
      int stepsDifference,
      int amountChanged,
      int multiplier,
      DateTime createdAt});
}

/// @nodoc
class _$BattleResultCopyWithImpl<$Res, $Val extends BattleResult>
    implements $BattleResultCopyWith<$Res> {
  _$BattleResultCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? winnerId = null,
    Object? loserId = null,
    Object? winnerSteps = null,
    Object? loserSteps = null,
    Object? stepsDifference = null,
    Object? amountChanged = null,
    Object? multiplier = null,
    Object? createdAt = null,
  }) {
    return _then(_value.copyWith(
      winnerId: null == winnerId
          ? _value.winnerId
          : winnerId // ignore: cast_nullable_to_non_nullable
              as String,
      loserId: null == loserId
          ? _value.loserId
          : loserId // ignore: cast_nullable_to_non_nullable
              as String,
      winnerSteps: null == winnerSteps
          ? _value.winnerSteps
          : winnerSteps // ignore: cast_nullable_to_non_nullable
              as int,
      loserSteps: null == loserSteps
          ? _value.loserSteps
          : loserSteps // ignore: cast_nullable_to_non_nullable
              as int,
      stepsDifference: null == stepsDifference
          ? _value.stepsDifference
          : stepsDifference // ignore: cast_nullable_to_non_nullable
              as int,
      amountChanged: null == amountChanged
          ? _value.amountChanged
          : amountChanged // ignore: cast_nullable_to_non_nullable
              as int,
      multiplier: null == multiplier
          ? _value.multiplier
          : multiplier // ignore: cast_nullable_to_non_nullable
              as int,
      createdAt: null == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$BattleResultImplCopyWith<$Res>
    implements $BattleResultCopyWith<$Res> {
  factory _$$BattleResultImplCopyWith(
          _$BattleResultImpl value, $Res Function(_$BattleResultImpl) then) =
      __$$BattleResultImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String winnerId,
      String loserId,
      int winnerSteps,
      int loserSteps,
      int stepsDifference,
      int amountChanged,
      int multiplier,
      DateTime createdAt});
}

/// @nodoc
class __$$BattleResultImplCopyWithImpl<$Res>
    extends _$BattleResultCopyWithImpl<$Res, _$BattleResultImpl>
    implements _$$BattleResultImplCopyWith<$Res> {
  __$$BattleResultImplCopyWithImpl(
      _$BattleResultImpl _value, $Res Function(_$BattleResultImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? winnerId = null,
    Object? loserId = null,
    Object? winnerSteps = null,
    Object? loserSteps = null,
    Object? stepsDifference = null,
    Object? amountChanged = null,
    Object? multiplier = null,
    Object? createdAt = null,
  }) {
    return _then(_$BattleResultImpl(
      winnerId: null == winnerId
          ? _value.winnerId
          : winnerId // ignore: cast_nullable_to_non_nullable
              as String,
      loserId: null == loserId
          ? _value.loserId
          : loserId // ignore: cast_nullable_to_non_nullable
              as String,
      winnerSteps: null == winnerSteps
          ? _value.winnerSteps
          : winnerSteps // ignore: cast_nullable_to_non_nullable
              as int,
      loserSteps: null == loserSteps
          ? _value.loserSteps
          : loserSteps // ignore: cast_nullable_to_non_nullable
              as int,
      stepsDifference: null == stepsDifference
          ? _value.stepsDifference
          : stepsDifference // ignore: cast_nullable_to_non_nullable
              as int,
      amountChanged: null == amountChanged
          ? _value.amountChanged
          : amountChanged // ignore: cast_nullable_to_non_nullable
              as int,
      multiplier: null == multiplier
          ? _value.multiplier
          : multiplier // ignore: cast_nullable_to_non_nullable
              as int,
      createdAt: null == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$BattleResultImpl implements _BattleResult {
  const _$BattleResultImpl(
      {required this.winnerId,
      required this.loserId,
      required this.winnerSteps,
      required this.loserSteps,
      required this.stepsDifference,
      required this.amountChanged,
      required this.multiplier,
      required this.createdAt});

  factory _$BattleResultImpl.fromJson(Map<String, dynamic> json) =>
      _$$BattleResultImplFromJson(json);

  @override
  final String winnerId;
  @override
  final String loserId;
  @override
  final int winnerSteps;
  @override
  final int loserSteps;
  @override
  final int stepsDifference;
  @override
  final int amountChanged;
  @override
  final int multiplier;
  @override
  final DateTime createdAt;

  @override
  String toString() {
    return 'BattleResult(winnerId: $winnerId, loserId: $loserId, winnerSteps: $winnerSteps, loserSteps: $loserSteps, stepsDifference: $stepsDifference, amountChanged: $amountChanged, multiplier: $multiplier, createdAt: $createdAt)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$BattleResultImpl &&
            (identical(other.winnerId, winnerId) ||
                other.winnerId == winnerId) &&
            (identical(other.loserId, loserId) || other.loserId == loserId) &&
            (identical(other.winnerSteps, winnerSteps) ||
                other.winnerSteps == winnerSteps) &&
            (identical(other.loserSteps, loserSteps) ||
                other.loserSteps == loserSteps) &&
            (identical(other.stepsDifference, stepsDifference) ||
                other.stepsDifference == stepsDifference) &&
            (identical(other.amountChanged, amountChanged) ||
                other.amountChanged == amountChanged) &&
            (identical(other.multiplier, multiplier) ||
                other.multiplier == multiplier) &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, winnerId, loserId, winnerSteps,
      loserSteps, stepsDifference, amountChanged, multiplier, createdAt);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$BattleResultImplCopyWith<_$BattleResultImpl> get copyWith =>
      __$$BattleResultImplCopyWithImpl<_$BattleResultImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$BattleResultImplToJson(
      this,
    );
  }
}

abstract class _BattleResult implements BattleResult {
  const factory _BattleResult(
      {required final String winnerId,
      required final String loserId,
      required final int winnerSteps,
      required final int loserSteps,
      required final int stepsDifference,
      required final int amountChanged,
      required final int multiplier,
      required final DateTime createdAt}) = _$BattleResultImpl;

  factory _BattleResult.fromJson(Map<String, dynamic> json) =
      _$BattleResultImpl.fromJson;

  @override
  String get winnerId;
  @override
  String get loserId;
  @override
  int get winnerSteps;
  @override
  int get loserSteps;
  @override
  int get stepsDifference;
  @override
  int get amountChanged;
  @override
  int get multiplier;
  @override
  DateTime get createdAt;
  @override
  @JsonKey(ignore: true)
  _$$BattleResultImplCopyWith<_$BattleResultImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
