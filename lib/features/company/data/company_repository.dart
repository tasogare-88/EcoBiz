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

      final company = Company(
        id: userId,
        name: name,
        genre: genre,
        rank: CompanyRank.startup,
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
}
