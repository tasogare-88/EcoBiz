import 'package:fake_cloud_firestore/fake_cloud_firestore.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../../../lib/core/providers/firebase_providers.dart';
import '../../../../lib/features/company/data/company_repository.dart';
import '../../../../lib/features/company/domain/company.dart';
import '../../../../lib/shared/constants/company_constants.dart';

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
      expect(company.totalAssets, CompanyConstants.initialAssets);
      expect(company.stepsToYenRate, CompanyConstants.initialStepsToYenRate);

      final fetchedCompany = await repository.getCompany(userId);
      expect(fetchedCompany, isNotNull);
      expect(fetchedCompany?.name, 'Test Company');
    });

    test('存在しない会社の場合', () async {
      final repository = container.read(companyRepositoryProvider.notifier);
      final company = await repository.getCompany('non-existent-id');

      expect(company, isNull);
    });

    test('総資産に応じて、ランクと換算レートが更新される', () async {
      final repository = container.read(companyRepositoryProvider.notifier);
      final userId = 'test-user-id';

      await repository.createCompany(
        userId: userId,
        name: 'Test Company',
        genre: CompanyGenre.it,
      );

      // ローカルビジネスへの昇格
      final localCompany = await repository.updateCompanyRankAndRate(
        userId,
        100000,
      );
      expect(localCompany.totalAssets, 100000);
      expect(localCompany.rank, CompanyRank.localCompany);
      expect(localCompany.stepsToYenRate,
          CompanyConstants.ranks['localCompany']?['rate']);

      // 地域企業への昇格
      final regionalCompany = await repository.updateCompanyRankAndRate(
        userId,
        500000,
      );
      expect(regionalCompany.totalAssets, 500000);
      expect(regionalCompany.rank, CompanyRank.regionalCompany);
      expect(regionalCompany.stepsToYenRate,
          CompanyConstants.ranks['regionalCompany']?['rate']);

      // 中小企業への昇格
      final smallMediumCompany = await repository.updateCompanyRankAndRate(
        userId,
        2000000,
      );
      expect(smallMediumCompany.totalAssets, 2000000);
      expect(smallMediumCompany.rank, CompanyRank.smallMediumCompany);
      expect(smallMediumCompany.stepsToYenRate,
          CompanyConstants.ranks['smallMediumCompany']?['rate']);

      // 大企業への昇格
      final largeCompany = await repository.updateCompanyRankAndRate(
        userId,
        10000000,
      );
      expect(largeCompany.totalAssets, 10000000);
      expect(largeCompany.rank, CompanyRank.largeCompany);
      expect(largeCompany.stepsToYenRate,
          CompanyConstants.ranks['largeCompany']?['rate']);

      // グローバル企業への昇格
      final globalCompany = await repository.updateCompanyRankAndRate(
        userId,
        200000000,
      );
      expect(globalCompany.totalAssets, 200000000);
      expect(globalCompany.rank, CompanyRank.globalCompany);
      expect(globalCompany.stepsToYenRate,
          CompanyConstants.ranks['globalCompany']?['rate']);
    });
  });
}
