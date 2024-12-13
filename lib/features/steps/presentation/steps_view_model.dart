import 'package:intl/intl.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../company/presentation/company_view_model.dart';
import '../data/health_service.dart';
import '../data/steps_repository.dart';
import '../domain/steps_state.dart';

part 'steps_view_model.g.dart';

@riverpod
class StepsViewModel extends _$StepsViewModel {
  @override
  StepsState build() {
    return const StepsState();
  }

  Future<void> fetchDailyRecord(String userId) async {
    if (userId.isEmpty) {
      throw Exception('ユーザーIDが無効です');
    }
    state = state.copyWith(isLoading: true, error: null);

    try {
      final today = DateFormat('yyyyMMdd').format(DateTime.now());
      final dailyRecord = await ref
          .read(stepsRepositoryProvider.notifier)
          .getDailyRecord(userId, today);

      state = state.copyWith(
        dailyRecord: dailyRecord,
        isLoading: false,
      );
    } catch (e) {
      state = state.copyWith(error: e.toString(), isLoading: false);
    }
  }

  Future<void> updateSteps(String userId, int steps, int stepsToYenRate) async {
    state = state.copyWith(isLoading: true, error: null);

    try {
      final today = DateFormat('yyyyMMdd').format(DateTime.now());
      final updatedRecord = await ref
          .read(stepsRepositoryProvider.notifier)
          .updateSteps(userId, today, steps, stepsToYenRate);

      state = state.copyWith(
        dailyRecord: updatedRecord,
        isLoading: false,
      );
    } catch (e) {
      state = state.copyWith(error: e.toString(), isLoading: false);
    }
  }

  Future<void> initializeHealthService() async {
    state = state.copyWith(isLoading: true, error: null);

    try {
      final healthService = ref.read(healthServiceProvider.notifier);
      final isAuthorized = await healthService.checkAndRequestAuthorization();

      if (!isAuthorized) {
        throw Exception('ヘルスケアの認証が拒否されました。設定を確認してください。');
      }

      state = state.copyWith(isLoading: false);
    } catch (e) {
      state = state.copyWith(error: e.toString(), isLoading: false);
    }
  }

  Future<void> fetchAndUpdateSteps(String userId) async {
    if (userId.isEmpty) {
      throw Exception('ユーザーIDが無効です');
    }
    state = state.copyWith(isLoading: true, error: null);

    try {
      final healthService = ref.read(healthServiceProvider.notifier);
      final steps = await healthService.getTodaySteps();

      final stepsToYenRate = ref
          .read(companyViewModelProvider.notifier)
          .getCurrentStepsToYenRate();

      await updateSteps(userId, steps, stepsToYenRate);
    } catch (e) {
      state = state.copyWith(error: e.toString(), isLoading: false);
    }
  }
}
