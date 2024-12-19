// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'battle_device.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$BattleDeviceImpl _$$BattleDeviceImplFromJson(Map<String, dynamic> json) =>
    _$BattleDeviceImpl(
      id: json['id'] as String,
      userId: json['userId'] as String,
      name: json['name'] as String,
      steps: (json['steps'] as num).toInt(),
    );

Map<String, dynamic> _$$BattleDeviceImplToJson(_$BattleDeviceImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'userId': instance.userId,
      'name': instance.name,
      'steps': instance.steps,
    };
