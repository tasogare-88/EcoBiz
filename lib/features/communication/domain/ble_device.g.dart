// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'ble_device.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$BLEDeviceImpl _$$BLEDeviceImplFromJson(Map<String, dynamic> json) =>
    _$BLEDeviceImpl(
      id: json['id'] as String,
      userId: json['userId'] as String,
      name: json['name'] as String,
      steps: (json['steps'] as num).toInt(),
    );

Map<String, dynamic> _$$BLEDeviceImplToJson(_$BLEDeviceImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'userId': instance.userId,
      'name': instance.name,
      'steps': instance.steps,
    };
