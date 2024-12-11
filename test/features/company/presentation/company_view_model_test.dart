import 'package:ecobiz/core/providers/firebase_providers.dart';
import 'package:ecobiz/features/company/domain/company.dart';
import 'package:ecobiz/features/company/presentation/company_view_model.dart';
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

  group('CompanyViewModel', () {
    test('会社を登録＆取得', () async {
      final viewModel = container.read(companyViewModelProvider.notifier);

      await viewModel.createCompany(
        userId: 'test-user-id',
        name: 'Test Company',
        genre: CompanyGenre.it,
      );

      final state = container.read(companyViewModelProvider);
      expect(state.company, isNotNull);
      expect(state.company?.name, 'Test Company');
      expect(state.isLoading, false);
      expect(state.error, isNull);
    });

    test('総資産を更新', () async {
      final viewModel = container.read(companyViewModelProvider.notifier);

      await viewModel.createCompany(
        userId: 'test-user-id',
        name: 'Test Company',
        genre: CompanyGenre.it,
      );

      var state = container.read(companyViewModelProvider);
      expect(state.company?.totalAssets, 0);
      expect(state.company?.rank, CompanyRank.startup);
      expect(state.company?.stepsToYenRate, 50);

      await viewModel.updateCompanyAssets('test-user-id', 100000);

      state = container.read(companyViewModelProvider);
      expect(state.company?.totalAssets, 100000);
      expect(state.company?.rank, CompanyRank.localBusiness);
      expect(state.company?.stepsToYenRate, 75);
    });
  });
}
