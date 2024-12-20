// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'daily_record.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

DailyRecord _$DailyRecordFromJson(Map<String, dynamic> json) {
  return _DailyRecord.fromJson(json);
}

/// @nodoc
mixin _$DailyRecord {
  String get userId => throw _privateConstructorUsedError;
  String get date => throw _privateConstructorUsedError;
  int get steps => throw _privateConstructorUsedError;
  int get earnedAmount => throw _privateConstructorUsedError;
  int get totalAssets => throw _privateConstructorUsedError;
  DateTime get createdAt => throw _privateConstructorUsedError;
  DateTime get updatedAt => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $DailyRecordCopyWith<DailyRecord> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $DailyRecordCopyWith<$Res> {
  factory $DailyRecordCopyWith(
          DailyRecord value, $Res Function(DailyRecord) then) =
      _$DailyRecordCopyWithImpl<$Res, DailyRecord>;
  @useResult
  $Res call(
      {String userId,
      String date,
      int steps,
      int earnedAmount,
      int totalAssets,
      DateTime createdAt,
      DateTime updatedAt});
}

/// @nodoc
class _$DailyRecordCopyWithImpl<$Res, $Val extends DailyRecord>
    implements $DailyRecordCopyWith<$Res> {
  _$DailyRecordCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? userId = null,
    Object? date = null,
    Object? steps = null,
    Object? earnedAmount = null,
    Object? totalAssets = null,
    Object? createdAt = null,
    Object? updatedAt = null,
  }) {
    return _then(_value.copyWith(
      userId: null == userId
          ? _value.userId
          : userId // ignore: cast_nullable_to_non_nullable
              as String,
      date: null == date
          ? _value.date
          : date // ignore: cast_nullable_to_non_nullable
              as String,
      steps: null == steps
          ? _value.steps
          : steps // ignore: cast_nullable_to_non_nullable
              as int,
      earnedAmount: null == earnedAmount
          ? _value.earnedAmount
          : earnedAmount // ignore: cast_nullable_to_non_nullable
              as int,
      totalAssets: null == totalAssets
          ? _value.totalAssets
          : totalAssets // ignore: cast_nullable_to_non_nullable
              as int,
      createdAt: null == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
      updatedAt: null == updatedAt
          ? _value.updatedAt
          : updatedAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$DailyRecordImplCopyWith<$Res>
    implements $DailyRecordCopyWith<$Res> {
  factory _$$DailyRecordImplCopyWith(
          _$DailyRecordImpl value, $Res Function(_$DailyRecordImpl) then) =
      __$$DailyRecordImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String userId,
      String date,
      int steps,
      int earnedAmount,
      int totalAssets,
      DateTime createdAt,
      DateTime updatedAt});
}

/// @nodoc
class __$$DailyRecordImplCopyWithImpl<$Res>
    extends _$DailyRecordCopyWithImpl<$Res, _$DailyRecordImpl>
    implements _$$DailyRecordImplCopyWith<$Res> {
  __$$DailyRecordImplCopyWithImpl(
      _$DailyRecordImpl _value, $Res Function(_$DailyRecordImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? userId = null,
    Object? date = null,
    Object? steps = null,
    Object? earnedAmount = null,
    Object? totalAssets = null,
    Object? createdAt = null,
    Object? updatedAt = null,
  }) {
    return _then(_$DailyRecordImpl(
      userId: null == userId
          ? _value.userId
          : userId // ignore: cast_nullable_to_non_nullable
              as String,
      date: null == date
          ? _value.date
          : date // ignore: cast_nullable_to_non_nullable
              as String,
      steps: null == steps
          ? _value.steps
          : steps // ignore: cast_nullable_to_non_nullable
              as int,
      earnedAmount: null == earnedAmount
          ? _value.earnedAmount
          : earnedAmount // ignore: cast_nullable_to_non_nullable
              as int,
      totalAssets: null == totalAssets
          ? _value.totalAssets
          : totalAssets // ignore: cast_nullable_to_non_nullable
              as int,
      createdAt: null == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
      updatedAt: null == updatedAt
          ? _value.updatedAt
          : updatedAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$DailyRecordImpl implements _DailyRecord {
  const _$DailyRecordImpl(
      {required this.userId,
      required this.date,
      required this.steps,
      required this.earnedAmount,
      required this.totalAssets,
      required this.createdAt,
      required this.updatedAt});

  factory _$DailyRecordImpl.fromJson(Map<String, dynamic> json) =>
      _$$DailyRecordImplFromJson(json);

  @override
  final String userId;
  @override
  final String date;
  @override
  final int steps;
  @override
  final int earnedAmount;
  @override
  final int totalAssets;
  @override
  final DateTime createdAt;
  @override
  final DateTime updatedAt;

  @override
  String toString() {
    return 'DailyRecord(userId: $userId, date: $date, steps: $steps, earnedAmount: $earnedAmount, totalAssets: $totalAssets, createdAt: $createdAt, updatedAt: $updatedAt)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$DailyRecordImpl &&
            (identical(other.userId, userId) || other.userId == userId) &&
            (identical(other.date, date) || other.date == date) &&
            (identical(other.steps, steps) || other.steps == steps) &&
            (identical(other.earnedAmount, earnedAmount) ||
                other.earnedAmount == earnedAmount) &&
            (identical(other.totalAssets, totalAssets) ||
                other.totalAssets == totalAssets) &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt) &&
            (identical(other.updatedAt, updatedAt) ||
                other.updatedAt == updatedAt));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, userId, date, steps,
      earnedAmount, totalAssets, createdAt, updatedAt);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$DailyRecordImplCopyWith<_$DailyRecordImpl> get copyWith =>
      __$$DailyRecordImplCopyWithImpl<_$DailyRecordImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$DailyRecordImplToJson(
      this,
    );
  }
}

abstract class _DailyRecord implements DailyRecord {
  const factory _DailyRecord(
      {required final String userId,
      required final String date,
      required final int steps,
      required final int earnedAmount,
      required final int totalAssets,
      required final DateTime createdAt,
      required final DateTime updatedAt}) = _$DailyRecordImpl;

  factory _DailyRecord.fromJson(Map<String, dynamic> json) =
      _$DailyRecordImpl.fromJson;

  @override
  String get userId;
  @override
  String get date;
  @override
  int get steps;
  @override
  int get earnedAmount;
  @override
  int get totalAssets;
  @override
  DateTime get createdAt;
  @override
  DateTime get updatedAt;
  @override
  @JsonKey(ignore: true)
  _$$DailyRecordImplCopyWith<_$DailyRecordImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
