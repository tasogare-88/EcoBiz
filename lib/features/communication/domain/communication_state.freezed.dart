// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'communication_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$CommunicationState {
  List<BattleDevice> get devices => throw _privateConstructorUsedError;
  bool get isScanning => throw _privateConstructorUsedError;
  bool get isBluetoothAvailable => throw _privateConstructorUsedError;
  String? get error => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $CommunicationStateCopyWith<CommunicationState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $CommunicationStateCopyWith<$Res> {
  factory $CommunicationStateCopyWith(
          CommunicationState value, $Res Function(CommunicationState) then) =
      _$CommunicationStateCopyWithImpl<$Res, CommunicationState>;
  @useResult
  $Res call(
      {List<BattleDevice> devices,
      bool isScanning,
      bool isBluetoothAvailable,
      String? error});
}

/// @nodoc
class _$CommunicationStateCopyWithImpl<$Res, $Val extends CommunicationState>
    implements $CommunicationStateCopyWith<$Res> {
  _$CommunicationStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? devices = null,
    Object? isScanning = null,
    Object? isBluetoothAvailable = null,
    Object? error = freezed,
  }) {
    return _then(_value.copyWith(
      devices: null == devices
          ? _value.devices
          : devices // ignore: cast_nullable_to_non_nullable
              as List<BattleDevice>,
      isScanning: null == isScanning
          ? _value.isScanning
          : isScanning // ignore: cast_nullable_to_non_nullable
              as bool,
      isBluetoothAvailable: null == isBluetoothAvailable
          ? _value.isBluetoothAvailable
          : isBluetoothAvailable // ignore: cast_nullable_to_non_nullable
              as bool,
      error: freezed == error
          ? _value.error
          : error // ignore: cast_nullable_to_non_nullable
              as String?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$CommunicationStateImplCopyWith<$Res>
    implements $CommunicationStateCopyWith<$Res> {
  factory _$$CommunicationStateImplCopyWith(_$CommunicationStateImpl value,
          $Res Function(_$CommunicationStateImpl) then) =
      __$$CommunicationStateImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {List<BattleDevice> devices,
      bool isScanning,
      bool isBluetoothAvailable,
      String? error});
}

/// @nodoc
class __$$CommunicationStateImplCopyWithImpl<$Res>
    extends _$CommunicationStateCopyWithImpl<$Res, _$CommunicationStateImpl>
    implements _$$CommunicationStateImplCopyWith<$Res> {
  __$$CommunicationStateImplCopyWithImpl(_$CommunicationStateImpl _value,
      $Res Function(_$CommunicationStateImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? devices = null,
    Object? isScanning = null,
    Object? isBluetoothAvailable = null,
    Object? error = freezed,
  }) {
    return _then(_$CommunicationStateImpl(
      devices: null == devices
          ? _value._devices
          : devices // ignore: cast_nullable_to_non_nullable
              as List<BattleDevice>,
      isScanning: null == isScanning
          ? _value.isScanning
          : isScanning // ignore: cast_nullable_to_non_nullable
              as bool,
      isBluetoothAvailable: null == isBluetoothAvailable
          ? _value.isBluetoothAvailable
          : isBluetoothAvailable // ignore: cast_nullable_to_non_nullable
              as bool,
      error: freezed == error
          ? _value.error
          : error // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc

class _$CommunicationStateImpl implements _CommunicationState {
  const _$CommunicationStateImpl(
      {final List<BattleDevice> devices = const [],
      this.isScanning = false,
      this.isBluetoothAvailable = false,
      this.error})
      : _devices = devices;

  final List<BattleDevice> _devices;
  @override
  @JsonKey()
  List<BattleDevice> get devices {
    if (_devices is EqualUnmodifiableListView) return _devices;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_devices);
  }

  @override
  @JsonKey()
  final bool isScanning;
  @override
  @JsonKey()
  final bool isBluetoothAvailable;
  @override
  final String? error;

  @override
  String toString() {
    return 'CommunicationState(devices: $devices, isScanning: $isScanning, isBluetoothAvailable: $isBluetoothAvailable, error: $error)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$CommunicationStateImpl &&
            const DeepCollectionEquality().equals(other._devices, _devices) &&
            (identical(other.isScanning, isScanning) ||
                other.isScanning == isScanning) &&
            (identical(other.isBluetoothAvailable, isBluetoothAvailable) ||
                other.isBluetoothAvailable == isBluetoothAvailable) &&
            (identical(other.error, error) || other.error == error));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(_devices),
      isScanning,
      isBluetoothAvailable,
      error);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$CommunicationStateImplCopyWith<_$CommunicationStateImpl> get copyWith =>
      __$$CommunicationStateImplCopyWithImpl<_$CommunicationStateImpl>(
          this, _$identity);
}

abstract class _CommunicationState implements CommunicationState {
  const factory _CommunicationState(
      {final List<BattleDevice> devices,
      final bool isScanning,
      final bool isBluetoothAvailable,
      final String? error}) = _$CommunicationStateImpl;

  @override
  List<BattleDevice> get devices;
  @override
  bool get isScanning;
  @override
  bool get isBluetoothAvailable;
  @override
  String? get error;
  @override
  @JsonKey(ignore: true)
  _$$CommunicationStateImplCopyWith<_$CommunicationStateImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
