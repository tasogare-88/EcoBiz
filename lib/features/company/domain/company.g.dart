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
      stepsToYenRate: (json['stepsToYenRate'] as num?)?.toInt() ?? 50,
      createdAt: DateTime.parse(json['createdAt'] as String),
      updatedAt: DateTime.parse(json['updatedAt'] as String),
    );

Map<String, dynamic> _$$CompanyImplToJson(_$CompanyImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'genre': _$CompanyGenreEnumMap[instance.genre]!,
      'rank': _$CompanyRankEnumMap[instance.rank]!,
      'totalAssets': instance.totalAssets,
      'stepsToYenRate': instance.stepsToYenRate,
      'createdAt': instance.createdAt.toIso8601String(),
      'updatedAt': instance.updatedAt.toIso8601String(),
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
