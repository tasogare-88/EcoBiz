import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../core/providers/firebase_providers.dart';
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
      final companyDoc = firestore.collection('companies').doc(userId);
      final now = DateTime.now();

      final company = Company(
        id: userId,
        name: name,
        genre: genre,
        rank: CompanyRank.startup,
        totalAssets: 0,
        stepsToYenRate: 50,
        createdAt: now,
        updatedAt: now,
      );

      await companyDoc.set(company.toJson());
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
      throw Exception('会社情報の取得に失敗しました: $e');
    }
  }

  Future<Company> updateCompanyRankAndRate(
      String userId, int newTotalAssets) async {
    try {
      final firestore = ref.read(firestoreProvider);
      final companyDoc = firestore.collection('companies').doc(userId);
      final now = Timestamp.fromDate(DateTime.now());

      // 新しいランクと換算レートを計算
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
      throw Exception('会社情報の更新に失敗しました: $e');
    }
  }

  (CompanyRank, int) _calculateRankAndRate(int totalAssets) {
    if (totalAssets <= 50000) {
      return (CompanyRank.startup, 50);
    } else if (totalAssets <= 325000) {
      return (CompanyRank.localBusiness, 75);
    } else if (totalAssets <= 1000000) {
      return (CompanyRank.regionalBusiness, 100);
    } else if (totalAssets <= 5000000) {
      return (CompanyRank.sme, 150);
    } else if (totalAssets <= 100000000) {
      return (CompanyRank.corporation, 300);
    } else {
      return (CompanyRank.globalCompany, 500);
    }
  }
}
