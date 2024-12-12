// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'daily_record.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$DailyRecordImpl _$$DailyRecordImplFromJson(Map<String, dynamic> json) =>
    _$DailyRecordImpl(
      userId: json['userId'] as String,
      date: json['date'] as String,
      steps: (json['steps'] as num).toInt(),
      earnedAmount: (json['earnedAmount'] as num).toInt(),
      totalAssets: (json['totalAssets'] as num).toInt(),
      createdAt: DateTime.parse(json['createdAt'] as String),
      updatedAt: DateTime.parse(json['updatedAt'] as String),
    );

Map<String, dynamic> _$$DailyRecordImplToJson(_$DailyRecordImpl instance) =>
    <String, dynamic>{
      'userId': instance.userId,
      'date': instance.date,
      'steps': instance.steps,
      'earnedAmount': instance.earnedAmount,
      'totalAssets': instance.totalAssets,
      'createdAt': instance.createdAt.toIso8601String(),
      'updatedAt': instance.updatedAt.toIso8601String(),
    };
