// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'battle_result.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$BattleResultImpl _$$BattleResultImplFromJson(Map<String, dynamic> json) =>
    _$BattleResultImpl(
      winnerId: json['winnerId'] as String,
      loserId: json['loserId'] as String,
      winnerSteps: (json['winnerSteps'] as num).toInt(),
      loserSteps: (json['loserSteps'] as num).toInt(),
      stepsDifference: (json['stepsDifference'] as num).toInt(),
      amountChanged: (json['amountChanged'] as num).toInt(),
      multiplier: (json['multiplier'] as num).toInt(),
      createdAt: DateTime.parse(json['createdAt'] as String),
    );

Map<String, dynamic> _$$BattleResultImplToJson(_$BattleResultImpl instance) =>
    <String, dynamic>{
      'winnerId': instance.winnerId,
      'loserId': instance.loserId,
      'winnerSteps': instance.winnerSteps,
      'loserSteps': instance.loserSteps,
      'stepsDifference': instance.stepsDifference,
      'amountChanged': instance.amountChanged,
      'multiplier': instance.multiplier,
      'createdAt': instance.createdAt.toIso8601String(),
    };
