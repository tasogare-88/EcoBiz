import 'dart:async';

import 'package:intl/intl.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../shared/constants/app_constants.dart';
import '../../../shared/constants/health_error_messages.dart';
import '../../../shared/constants/validation_messages.dart';
import '../../company/presentation/company_view_model.dart';
import '../data/health_service.dart';
import '../data/steps_repository.dart';
import '../domain/steps_state.dart';

part 'steps_view_model.g.dart';

@riverpod
class StepsViewModel extends _$StepsViewModel {
  static const Duration updateInterval = Duration(minutes: 30);
  Timer? _updateTimer;

  @override
  StepsState build() {
    ref.onDispose(() {
      _updateTimer?.cancel();
    });
    return const StepsState();
  }

  Future<void> initializeHealthService() async {
    state = state.copyWith(isLoading: true, error: null);

    try {
      final healthService = ref.read(healthServiceProvider.notifier);
      final isAuthorized = await healthService.checkAndRequestAuthorization();

      if (!isAuthorized) {
        throw Exception(HealthErrorMessages.authorizationDenied);
      }
      state = state.copyWith(isLoading: false);
    } catch (e) {
      state = state.copyWith(error: e.toString(), isLoading: false);
    }
  }

  Future<void> fetchAndUpdateSteps(String userId) async {
    if (userId.isEmpty) {
      throw Exception(ValidationMessages.invalidUserId);
    }

    if (!await shouldUpdateSteps(userId)) {
      return; // 更新不要な場合はスキップ
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

  Future<bool> shouldUpdateSteps(String userId) async {
    final today = DateFormat(AppConstants.dateFormat).format(DateTime.now());
    final dailyRecord = await ref
        .read(stepsRepositoryProvider.notifier)
        .getDailyRecord(userId, today);

    if (dailyRecord == null) return true;

    final lastUpdate = dailyRecord.updatedAt;
    final now = DateTime.now();
    return now.difference(lastUpdate) >= updateInterval;
  }

  // バトル発生時の強制更新
  Future<void> forceUpdateForBattle(String userId) async {
    state = state.copyWith(isLoading: true, error: null);
    await fetchAndUpdateSteps(userId);
  }

  // ランクアップ時の強制更新
  Future<void> forceUpdateForRankUp(String userId) async {
    state = state.copyWith(isLoading: true, error: null);
    await fetchAndUpdateSteps(userId);
  }

  // アプリがバックグラウンドに移行時の更新
  Future<void> updateOnBackground(String userId) async {
    await fetchAndUpdateSteps(userId);
  }

  Future<void> fetchDailyRecord(String userId) async {
    if (userId.isEmpty) {
      throw Exception(ValidationMessages.invalidUserId);
    }
    state = state.copyWith(isLoading: true, error: null);

    try {
      final today = DateFormat(AppConstants.dateFormat).format(DateTime.now());
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
      final today = DateFormat(AppConstants.dateFormat).format(DateTime.now());
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

  Future<void> validateSteps(int steps) async {
    if (steps < AppConstants.minimumStepsRequired) {
      throw Exception('最低${AppConstants.minimumStepsRequired}歩以上必要です');
    }
  }

  Future<void> startPeriodicUpdate(String userId) async {
    await fetchAndUpdateSteps(userId);

    _updateTimer?.cancel();
    _updateTimer = Timer.periodic(updateInterval, (_) async {
      await fetchAndUpdateSteps(userId);
    });
  }

  Future<void> stopPeriodicUpdate() async {
    _updateTimer?.cancel();
    _updateTimer = null;
  }
}
