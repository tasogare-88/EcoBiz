import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'company.freezed.dart';
part 'company.g.dart';

enum CompanyGenre {
  it,
  manufacturing,
  food,
  transport,
  advertising,
  construction,
}

enum CompanyRank {
  startup,
  localBusiness,
  regionalBusiness,
  sme,
  corporation,
  globalCompany,
}

DateTime _timestampToDateTime(dynamic timestamp) {
  if (timestamp is Timestamp) {
    return timestamp.toDate();
  }
  return DateTime.parse(timestamp.toString());
}

dynamic _dateTimeToTimestamp(DateTime dateTime) {
  return Timestamp.fromDate(dateTime);
}

@freezed
class Company with _$Company {
  const Company._();

  const factory Company({
    required String id,
    required String name,
    required CompanyGenre genre,
    required CompanyRank rank,
    @Default(0) int totalAssets,
    @Default(50) int stepsToYenRate,
    @JsonKey(fromJson: _timestampToDateTime, toJson: _dateTimeToTimestamp)
    required DateTime createdAt,
    @JsonKey(fromJson: _timestampToDateTime, toJson: _dateTimeToTimestamp)
    required DateTime updatedAt,
  }) = _Company;

  factory Company.fromJson(Map<String, dynamic> json) =>
      _$CompanyFromJson(json);
}
