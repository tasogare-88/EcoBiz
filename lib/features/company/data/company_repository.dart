import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../core/providers/firebase_providers.dart';
import '../../../shared/constants/company_constants.dart';
import '../../../shared/constants/company_error_messages.dart';
import '../domain/company.dart';

part 'company_repository.g.dart';

@riverpod
class CompanyRepository extends _$CompanyRepository {
  @override
  FutureOr<void> build() {}

  Future<Company> createCompany({
    required String userId,
    required String name,
    required CompanyGenre genre,
  }) async {
    try {
      final firestore = ref.read(firestoreProvider);
      final company = Company(
        id: userId,
        name: name,
        genre: genre,
        rank: CompanyRank.startup,
        totalAssets: CompanyConstants.initialAssets,
        stepsToYenRate: CompanyConstants.initialStepsToYenRate,
        createdAt: DateTime.now(),
        updatedAt: DateTime.now(),
      );

      await firestore.collection('companies').doc(userId).set(company.toJson());

      return company;
    } catch (e) {
      throw Exception('会社の作成に失敗しました: $e');
    }
  }

  Future<Company?> getCompany(String userId) async {
    try {
      final firestore = ref.read(firestoreProvider);
      final doc = await firestore.collection('companies').doc(userId).get();

      if (!doc.exists) return null;
      return Company.fromJson(doc.data()!);
    } catch (e) {
      throw Exception(CompanyErrorMessages.companyFetchFailed);
    }
  }

  Future<Company> updateCompanyRankAndRate(
      String userId, int newTotalAssets) async {
    try {
      final firestore = ref.read(firestoreProvider);
      final companyDoc = firestore.collection('companies').doc(userId);
      final now = Timestamp.fromDate(DateTime.now());

      final (newRank, newRate) = _calculateRankAndRate(newTotalAssets);

      await companyDoc.update({
        'rank': newRank.name,
        'totalAssets': newTotalAssets,
        'stepsToYenRate': newRate,
        'updatedAt': now,
      });

      final updatedDoc = await companyDoc.get();
      return Company.fromJson(updatedDoc.data()!);
    } catch (e) {
      throw Exception(CompanyErrorMessages.companyUpdateFailed);
    }
  }

  (CompanyRank, int) _calculateRankAndRate(int totalAssets) {
    for (var entry in CompanyConstants.ranks.entries) {
      final minAssets = entry.value['minAssets'] as int;
      final maxAssets = entry.value['maxAssets'] as int;

      if (totalAssets >= minAssets && totalAssets <= maxAssets) {
        return (
          CompanyRank.values.firstWhere((r) => r.name == entry.key),
          entry.value['rate'] as int
        );
      }
    }
    return (CompanyRank.startup, CompanyConstants.initialStepsToYenRate);
  }
}
