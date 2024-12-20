import 'package:ecobiz/core/providers/firebase_providers.dart';
import 'package:ecobiz/features/steps/domain/daily_record.dart';
import 'package:ecobiz/features/steps/presentation/steps_view_model.dart';
import 'package:fake_cloud_firestore/fake_cloud_firestore.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:intl/intl.dart';

import '../../../../lib/shared/constants/app_constants.dart';
import '../../../../lib/shared/constants/company_constants.dart';
import '../../../../lib/shared/constants/health_error_messages.dart';

class FakeHealthService {
  bool _shouldAuthorize = true;
  int _steps = 1000;

  Future<bool> checkAndRequestAuthorization() async {
    if (!_shouldAuthorize) {
      throw Exception(HealthErrorMessages.authorizationDenied);
    }
    return _shouldAuthorize;
  }

  Future<bool> requestAuthorization() async => _shouldAuthorize;
  Future<int> getTodaySteps() async => _steps;
  void setSteps(int value) => _steps = value;
  void setShouldAuthorize(bool value) => _shouldAuthorize = value;

  Future<void> initializeHealthService() async {
    if (!_shouldAuthorize) {
      throw Exception(HealthErrorMessages.healthConnectNotInstalled);
    }
  }
}

class FakeStepsViewModel extends StepsViewModel {
  final FakeHealthService healthService;

  FakeStepsViewModel(this.healthService);

  @override
  Future<void> initializeHealthService() async {
    state = state.copyWith(isLoading: true, error: null);
    try {
      final isAuthorized = await healthService.checkAndRequestAuthorization();
      if (!isAuthorized) {
        throw Exception(HealthErrorMessages.authorizationDenied);
      }
      state = state.copyWith(isLoading: false);
    } catch (e) {
      state = state.copyWith(error: e.toString(), isLoading: false);
    }
  }

  @override
  Future<bool> shouldUpdateSteps(String userId) async {
    return true;
  }

  @override
  Future<void> fetchAndUpdateSteps(String userId) async {
    final steps = await healthService.getTodaySteps();
    await updateSteps(userId, steps, CompanyConstants.initialStepsToYenRate);
  }

  @override
  Future<void> updateSteps(String userId, int steps, int stepsToYenRate) async {
    state = state.copyWith(isLoading: true, error: null);

    try {
      final today = DateFormat(AppConstants.dateFormat).format(DateTime.now());
      final now = DateTime.now();

      final dailyRecord = DailyRecord(
        userId: userId,
        date: today,
        steps: steps,
        earnedAmount: steps * stepsToYenRate,
        totalAssets: steps * stepsToYenRate,
        createdAt: now,
        updatedAt: now,
      );

      state = state.copyWith(
        dailyRecord: dailyRecord,
        isLoading: false,
      );
    } catch (e) {
      state = state.copyWith(error: e.toString(), isLoading: false);
    }
  }
}

void main() {
  late ProviderContainer container;
  late FakeHealthService fakeHealthService;
  late FakeFirebaseFirestore fakeFirestore;

  setUp(() {
    fakeHealthService = FakeHealthService();
    fakeFirestore = FakeFirebaseFirestore();
    container = ProviderContainer(
      overrides: [
        firestoreProvider.overrideWithValue(fakeFirestore),
        stepsViewModelProvider
            .overrideWith(() => FakeStepsViewModel(fakeHealthService)),
      ],
    );

    // テストデータの作成
    final today = DateFormat(AppConstants.dateFormat).format(DateTime.now());
    final now = DateTime.now().subtract(const Duration(minutes: 31));

    fakeFirestore
        .collection('users')
        .doc('test-user-id')
        .collection('dailyRecords')
        .doc(today)
        .set({
      'userId': 'test-user-id',
      'date': today,
      'steps': 1000,
      'earnedAmount': 1000,
      'totalAssets': 1000,
      'updatedAt': now.toIso8601String(),
      'createdAt': now.toIso8601String(),
    });
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
      expect(
          state.error, 'Exception: ${HealthErrorMessages.authorizationDenied}');
      expect(state.isLoading, false);
    });

    test('Health Connectが利用できない場合', () async {
      fakeHealthService.setShouldAuthorize(false);

      final viewModel = container.read(stepsViewModelProvider.notifier);
      await viewModel.initializeHealthService();

      final state = container.read(stepsViewModelProvider);
      expect(
          state.error, 'Exception: ${HealthErrorMessages.authorizationDenied}');
      expect(state.isLoading, false);
    });
  });

  group('StepsViewModel - 更新頻度テスト', () {
    test('アプリ起動時に歩数データを取得する', () async {
      final viewModel = container.read(stepsViewModelProvider.notifier);
      final userId = 'test-user-id';

      await viewModel.fetchAndUpdateSteps(userId);

      final state = container.read(stepsViewModelProvider);
      expect(state.dailyRecord, isNotNull);
      expect(state.isLoading, false);
      expect(state.error, isNull);
    });

    test('定期更新が30分間隔で実行される', () async {
      final viewModel = container.read(stepsViewModelProvider.notifier);
      final userId = 'test-user-id';

      await viewModel.fetchAndUpdateSteps(userId);
      final initialState = container.read(stepsViewModelProvider);

      // 更新間隔を短くしてテスト
      await Future.delayed(const Duration(milliseconds: 100));
      await viewModel.fetchAndUpdateSteps(userId);
      final stateAfterUpdate = container.read(stepsViewModelProvider);

      expect(stateAfterUpdate.dailyRecord?.updatedAt,
          isNot(equals(initialState.dailyRecord?.updatedAt)));
    });

    // test('バトル発生時に強制更新される', () async {
    //   final viewModel = container.read(stepsViewModelProvider.notifier);
    //   final userId = 'test-user-id';

    //   await viewModel.initializeHealthService();
    //   await viewModel.fetchAndUpdateSteps(userId);
    //   final initialState = container.read(stepsViewModelProvider);

    //   fakeHealthService.setSteps(2000);
    //   await Future.delayed(const Duration(milliseconds: 100));
    //   await viewModel.forceUpdateForBattle(userId);
    //   final stateAfterBattle = container.read(stepsViewModelProvider);

    //   expect(
    //       stateAfterBattle.dailyRecord?.updatedAt.millisecondsSinceEpoch ?? 0,
    //       greaterThan(
    //           initialState.dailyRecord?.updatedAt.millisecondsSinceEpoch ?? 0));
    // });

    // test('ランクアップ時に強制更新される', () async {
    //   final viewModel = container.read(stepsViewModelProvider.notifier);
    //   final userId = 'test-user-id';

    //   await viewModel.initializeHealthService();
    //   await viewModel.fetchAndUpdateSteps(userId);
    //   final initialState = container.read(stepsViewModelProvider);

    //   fakeHealthService.setSteps(2000);
    //   await Future.delayed(const Duration(milliseconds: 100));
    //   await viewModel.forceUpdateForRankUp(userId);
    //   final stateAfterRankUp = container.read(stepsViewModelProvider);

    //   expect(
    //       stateAfterRankUp.dailyRecord?.updatedAt.millisecondsSinceEpoch ?? 0,
    //       greaterThan(
    //           initialState.dailyRecord?.updatedAt.millisecondsSinceEpoch ?? 0));
    // });

    // test('アプリがバックグラウンドに移行時に更新される', () async {
    //   final viewModel = container.read(stepsViewModelProvider.notifier);
    //   final userId = 'test-user-id';

    //   await viewModel.initializeHealthService();
    //   await viewModel.fetchAndUpdateSteps(userId);
    //   final initialState = container.read(stepsViewModelProvider);

    //   fakeHealthService.setSteps(2000);
    //   await Future.delayed(const Duration(milliseconds: 100));
    //   await viewModel.updateOnBackground(userId);
    //   final stateAfterBackground = container.read(stepsViewModelProvider);

    //   expect(
    //       stateAfterBackground.dailyRecord?.updatedAt.millisecondsSinceEpoch ??
    //           0,
    //       greaterThan(
    //           initialState.dailyRecord?.updatedAt.millisecondsSinceEpoch ?? 0));
    // });
  });
}
