import 'package:ecobiz/core/providers/firebase_providers.dart';
import 'package:ecobiz/features/company/data/company_repository.dart';
import 'package:ecobiz/features/company/domain/company.dart';
import 'package:fake_cloud_firestore/fake_cloud_firestore.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  late ProviderContainer container;
  late FakeFirebaseFirestore fakeFirestore;

  setUp(() {
    fakeFirestore = FakeFirebaseFirestore();
    container = ProviderContainer(
      overrides: [
        firestoreProvider.overrideWithValue(fakeFirestore),
      ],
    );
  });

  tearDown(() {
    container.dispose();
  });

  group('CompanyRepository', () {
    test('会社を登録＆取得', () async {
      final repository = container.read(companyRepositoryProvider.notifier);
      final userId = 'test-user-id';
      final company = await repository.createCompany(
        userId: userId,
        name: 'Test Company',
        genre: CompanyGenre.it,
      );

      expect(company.id, userId);
      expect(company.name, 'Test Company');
      expect(company.genre, CompanyGenre.it);
      expect(company.rank, CompanyRank.startup);
      expect(company.totalAssets, 0);
      expect(company.stepsToYenRate, 50);
    });

    test('存在しない会社の場合', () async {
      final repository = container.read(companyRepositoryProvider.notifier);
      final company = await repository.getCompany('non-existent-id');

      expect(company, isNull);
    });

    test('総資産に応じて、ランクと換算レートが更新される', () async {
      final repository = container.read(companyRepositoryProvider.notifier);
      final userId = 'test-user-id';

      final company = await repository.createCompany(
        userId: userId,
        name: 'Test Company',
        genre: CompanyGenre.it,
      );
      expect(company.rank, CompanyRank.startup);
      expect(company.stepsToYenRate, 50);
      expect(company.totalAssets, 0);

      final localBusiness = await repository.updateCompanyRankAndRate(
        userId,
        100000,
      );
      expect(localBusiness.totalAssets, 100000);
      expect(localBusiness.rank, CompanyRank.localBusiness);
      expect(localBusiness.stepsToYenRate, 75);

      final regionalBusiness = await repository.updateCompanyRankAndRate(
        userId,
        500000,
      );
      expect(regionalBusiness.totalAssets, 500000);
      expect(regionalBusiness.rank, CompanyRank.regionalBusiness);
      expect(regionalBusiness.stepsToYenRate, 100);

      final sme = await repository.updateCompanyRankAndRate(
        userId,
        2000000,
      );
      expect(sme.totalAssets, 2000000);
      expect(sme.rank, CompanyRank.sme);
      expect(sme.stepsToYenRate, 150);

      final corporation = await repository.updateCompanyRankAndRate(
        userId,
        10000000,
      );
      expect(corporation.totalAssets, 10000000);
      expect(corporation.rank, CompanyRank.corporation);
      expect(corporation.stepsToYenRate, 300);

      final globalCompany = await repository.updateCompanyRankAndRate(
        userId,
        200000000,
      );
      expect(globalCompany.totalAssets, 200000000);
      expect(globalCompany.rank, CompanyRank.globalCompany);
      expect(globalCompany.stepsToYenRate, 500);
    });
  });
}
