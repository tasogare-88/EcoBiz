// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'ble_device.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

BLEDevice _$BLEDeviceFromJson(Map<String, dynamic> json) {
  return _BLEDevice.fromJson(json);
}

/// @nodoc
mixin _$BLEDevice {
  String get id => throw _privateConstructorUsedError;
  String get userId => throw _privateConstructorUsedError;
  String get name => throw _privateConstructorUsedError;
  int get steps => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $BLEDeviceCopyWith<BLEDevice> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $BLEDeviceCopyWith<$Res> {
  factory $BLEDeviceCopyWith(BLEDevice value, $Res Function(BLEDevice) then) =
      _$BLEDeviceCopyWithImpl<$Res, BLEDevice>;
  @useResult
  $Res call({String id, String userId, String name, int steps});
}

/// @nodoc
class _$BLEDeviceCopyWithImpl<$Res, $Val extends BLEDevice>
    implements $BLEDeviceCopyWith<$Res> {
  _$BLEDeviceCopyWithImpl(this._value, this._then);

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
abstract class _$$BLEDeviceImplCopyWith<$Res>
    implements $BLEDeviceCopyWith<$Res> {
  factory _$$BLEDeviceImplCopyWith(
          _$BLEDeviceImpl value, $Res Function(_$BLEDeviceImpl) then) =
      __$$BLEDeviceImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String id, String userId, String name, int steps});
}

/// @nodoc
class __$$BLEDeviceImplCopyWithImpl<$Res>
    extends _$BLEDeviceCopyWithImpl<$Res, _$BLEDeviceImpl>
    implements _$$BLEDeviceImplCopyWith<$Res> {
  __$$BLEDeviceImplCopyWithImpl(
      _$BLEDeviceImpl _value, $Res Function(_$BLEDeviceImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? userId = null,
    Object? name = null,
    Object? steps = null,
  }) {
    return _then(_$BLEDeviceImpl(
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
class _$BLEDeviceImpl implements _BLEDevice {
  const _$BLEDeviceImpl(
      {required this.id,
      required this.userId,
      required this.name,
      required this.steps});

  factory _$BLEDeviceImpl.fromJson(Map<String, dynamic> json) =>
      _$$BLEDeviceImplFromJson(json);

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
    return 'BLEDevice(id: $id, userId: $userId, name: $name, steps: $steps)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$BLEDeviceImpl &&
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
  _$$BLEDeviceImplCopyWith<_$BLEDeviceImpl> get copyWith =>
      __$$BLEDeviceImplCopyWithImpl<_$BLEDeviceImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$BLEDeviceImplToJson(
      this,
    );
  }
}

abstract class _BLEDevice implements BLEDevice {
  const factory _BLEDevice(
      {required final String id,
      required final String userId,
      required final String name,
      required final int steps}) = _$BLEDeviceImpl;

  factory _BLEDevice.fromJson(Map<String, dynamic> json) =
      _$BLEDeviceImpl.fromJson;

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
  _$$BLEDeviceImplCopyWith<_$BLEDeviceImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
