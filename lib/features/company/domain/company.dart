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

@freezed
class Company with _$Company {
  const factory Company({
    required String id,
    required String name,
    required CompanyGenre genre,
    required CompanyRank rank,
    @Default(0) int totalAssets,
    @Default(50) int stepsToYenRate,
    required DateTime createdAt,
    required DateTime updatedAt,
  }) = _Company;

  factory Company.fromJson(Map<String, dynamic> json) =>
      _$CompanyFromJson(json);
}
