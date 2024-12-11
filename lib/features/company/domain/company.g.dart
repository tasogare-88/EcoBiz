// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'company.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$CompanyImpl _$$CompanyImplFromJson(Map<String, dynamic> json) =>
    _$CompanyImpl(
      id: json['id'] as String,
      name: json['name'] as String,
      genre: $enumDecode(_$CompanyGenreEnumMap, json['genre']),
      rank: $enumDecode(_$CompanyRankEnumMap, json['rank']),
      totalAssets: (json['totalAssets'] as num?)?.toInt() ?? 0,
      todaySteps: (json['todaySteps'] as num?)?.toInt() ?? 0,
      stepsToYenRate: (json['stepsToYenRate'] as num?)?.toInt() ?? 0,
    );

Map<String, dynamic> _$$CompanyImplToJson(_$CompanyImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'genre': _$CompanyGenreEnumMap[instance.genre]!,
      'rank': _$CompanyRankEnumMap[instance.rank]!,
      'totalAssets': instance.totalAssets,
      'todaySteps': instance.todaySteps,
      'stepsToYenRate': instance.stepsToYenRate,
    };

const _$CompanyGenreEnumMap = {
  CompanyGenre.it: 'it',
  CompanyGenre.manufacturing: 'manufacturing',
  CompanyGenre.food: 'food',
  CompanyGenre.transport: 'transport',
  CompanyGenre.advertising: 'advertising',
  CompanyGenre.construction: 'construction',
};

const _$CompanyRankEnumMap = {
  CompanyRank.startup: 'startup',
  CompanyRank.localBusiness: 'localBusiness',
  CompanyRank.regionalBusiness: 'regionalBusiness',
  CompanyRank.sme: 'sme',
  CompanyRank.corporation: 'corporation',
  CompanyRank.globalCompany: 'globalCompany',
};
