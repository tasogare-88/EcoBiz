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
      locationIndex: (json['locationIndex'] as num?)?.toInt(),
      createdAt: _timestampToDateTime(json['createdAt']),
      updatedAt: _timestampToDateTime(json['updatedAt']),
    );

Map<String, dynamic> _$$CompanyImplToJson(_$CompanyImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'genre': _$CompanyGenreEnumMap[instance.genre]!,
      'rank': _$CompanyRankEnumMap[instance.rank]!,
      'totalAssets': instance.totalAssets,
      'stepsToYenRate': instance.stepsToYenRate,
      'locationIndex': instance.locationIndex,
      'createdAt': _dateTimeToTimestamp(instance.createdAt),
      'updatedAt': _dateTimeToTimestamp(instance.updatedAt),
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
  CompanyRank.localCompany: 'localCompany',
  CompanyRank.regionalCompany: 'regionalCompany',
  CompanyRank.smallMediumCompany: 'smallMediumCompany',
  CompanyRank.largeCompany: 'largeCompany',
  CompanyRank.globalCompany: 'globalCompany',
};
