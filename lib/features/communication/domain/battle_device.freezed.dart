// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'battle_device.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

BattleDevice _$BattleDeviceFromJson(Map<String, dynamic> json) {
  return _BattleDevice.fromJson(json);
}

/// @nodoc
mixin _$BattleDevice {
  String get id => throw _privateConstructorUsedError;
  String get userId => throw _privateConstructorUsedError;
  String get name => throw _privateConstructorUsedError;
  int get steps => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $BattleDeviceCopyWith<BattleDevice> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $BattleDeviceCopyWith<$Res> {
  factory $BattleDeviceCopyWith(
          BattleDevice value, $Res Function(BattleDevice) then) =
      _$BattleDeviceCopyWithImpl<$Res, BattleDevice>;
  @useResult
  $Res call({String id, String userId, String name, int steps});
}

/// @nodoc
class _$BattleDeviceCopyWithImpl<$Res, $Val extends BattleDevice>
    implements $BattleDeviceCopyWith<$Res> {
  _$BattleDeviceCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? userId = null,
    Object? name = null,
    Object? steps = null,
  }) {
    return _then(_value.copyWith(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      userId: null == userId
          ? _value.userId
          : userId // ignore: cast_nullable_to_non_nullable
              as String,
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      steps: null == steps
          ? _value.steps
          : steps // ignore: cast_nullable_to_non_nullable
              as int,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$BattleDeviceImplCopyWith<$Res>
    implements $BattleDeviceCopyWith<$Res> {
  factory _$$BattleDeviceImplCopyWith(
          _$BattleDeviceImpl value, $Res Function(_$BattleDeviceImpl) then) =
      __$$BattleDeviceImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String id, String userId, String name, int steps});
}

/// @nodoc
class __$$BattleDeviceImplCopyWithImpl<$Res>
    extends _$BattleDeviceCopyWithImpl<$Res, _$BattleDeviceImpl>
    implements _$$BattleDeviceImplCopyWith<$Res> {
  __$$BattleDeviceImplCopyWithImpl(
      _$BattleDeviceImpl _value, $Res Function(_$BattleDeviceImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? userId = null,
    Object? name = null,
    Object? steps = null,
  }) {
    return _then(_$BattleDeviceImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      userId: null == userId
          ? _value.userId
          : userId // ignore: cast_nullable_to_non_nullable
              as String,
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      steps: null == steps
          ? _value.steps
          : steps // ignore: cast_nullable_to_non_nullable
              as int,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$BattleDeviceImpl implements _BattleDevice {
  const _$BattleDeviceImpl(
      {required this.id,
      required this.userId,
      required this.name,
      required this.steps});

  factory _$BattleDeviceImpl.fromJson(Map<String, dynamic> json) =>
      _$$BattleDeviceImplFromJson(json);

  @override
  final String id;
  @override
  final String userId;
  @override
  final String name;
  @override
  final int steps;

  @override
  String toString() {
    return 'BattleDevice(id: $id, userId: $userId, name: $name, steps: $steps)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$BattleDeviceImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.userId, userId) || other.userId == userId) &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.steps, steps) || other.steps == steps));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, id, userId, name, steps);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$BattleDeviceImplCopyWith<_$BattleDeviceImpl> get copyWith =>
      __$$BattleDeviceImplCopyWithImpl<_$BattleDeviceImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$BattleDeviceImplToJson(
      this,
    );
  }
}

abstract class _BattleDevice implements BattleDevice {
  const factory _BattleDevice(
      {required final String id,
      required final String userId,
      required final String name,
      required final int steps}) = _$BattleDeviceImpl;

  factory _BattleDevice.fromJson(Map<String, dynamic> json) =
      _$BattleDeviceImpl.fromJson;

  @override
  String get id;
  @override
  String get userId;
  @override
  String get name;
  @override
  int get steps;
  @override
  @JsonKey(ignore: true)
  _$$BattleDeviceImplCopyWith<_$BattleDeviceImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
