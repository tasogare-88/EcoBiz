import 'dart:async';

import 'package:ecobiz/core/providers/firebase_providers.dart';
import 'package:ecobiz/features/company/presentation/company_view_model.dart';
import 'package:ecobiz/features/steps/data/health_service.dart';
import 'package:ecobiz/features/steps/presentation/steps_view_model.dart';
import 'package:fake_cloud_firestore/fake_cloud_firestore.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:health/health.dart';
import 'package:mocktail/mocktail.dart';

class FakeHealthService extends AutoDisposeAsyncNotifier<void>
    implements HealthService {
  bool _shouldAuthorize = true;
  bool _isAvailable = true;
  int _steps = 1000;

  @override
  HealthFactory health = HealthFactory();

  @override
  FutureOr<void> build() async {}

  @override
  Future<bool> checkAndRequestAuthorization() async {
    if (!_isAvailable) {
      throw Exception(
          'Health Connectがインストールされていないか、利用できません。インストール手順を確認してください。');
    }
    return _shouldAuthorize;
  }

  @override
  Future<bool> requestAuthorization() async => _shouldAuthorize;

  @override
  Future<int> getTodaySteps() async => _steps;

  void setShouldAuthorize(bool value) {
    _shouldAuthorize = value;
  }

  void setAvailable(bool value) {
    _isAvailable = value;
  }
}

class MockCompanyViewModel extends Mock implements CompanyViewModel {}

void main() {
  late ProviderContainer container;
  late FakeHealthService fakeHealthService;
  late FakeFirebaseFirestore fakeFirestore;

  setUp(() {
    fakeHealthService = FakeHealthService();
    fakeFirestore = FakeFirebaseFirestore();

    container = ProviderContainer(
      overrides: [
        healthServiceProvider.overrideWith(() => fakeHealthService),
        firestoreProvider.overrideWithValue(fakeFirestore),
      ],
    );
  });

  group('StepsViewModel', () {
    test('歩数の取得と更新が成功する場合', () async {
      final viewModel = container.read(stepsViewModelProvider.notifier);

      await viewModel.initializeHealthService();
      expect(container.read(stepsViewModelProvider).error, isNull);

      await viewModel.fetchAndUpdateSteps('test-user-id');
      final state = container.read(stepsViewModelProvider);

      expect(state.dailyRecord?.steps, 1000);
      expect(state.isLoading, false);
      expect(state.error, isNull);
    });

    test('ヘルスケアの認証が拒否された場合', () async {
      fakeHealthService.setShouldAuthorize(false);

      final viewModel = container.read(stepsViewModelProvider.notifier);
      await viewModel.initializeHealthService();

      final state = container.read(stepsViewModelProvider);
      expect(state.error, 'Exception: ヘルスケアの認証が拒否されました。設定を確認してください。');
      expect(state.isLoading, false);
    });

    test('Health Connectが利用できない場合', () async {
      fakeHealthService.setAvailable(false);

      final viewModel = container.read(stepsViewModelProvider.notifier);
      await viewModel.initializeHealthService();

      final state = container.read(stepsViewModelProvider);
      expect(state.error,
          'Exception: Health Connectがインストールされていないか、利用できません。インストール手順を確認してください。');
      expect(state.isLoading, false);
    });
  });
}
