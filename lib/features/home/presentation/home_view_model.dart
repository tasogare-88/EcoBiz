import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../core/auth/domain/auth_state.dart';
import '../../../core/auth/presentation/auth_view_model.dart';
import '../../steps/presentation/steps_view_model.dart';

part 'home_view_model.freezed.dart';
part 'home_view_model.g.dart';

@freezed
class HomeState with _$HomeState {
  const factory HomeState({
    @Default(0) int steps,
    @Default(0) int currentCarouselIndex,
    @Default(false) bool isLoading,
    String? error,
  }) = _HomeState;
}

@riverpod
class HomeViewModel extends _$HomeViewModel {
  @override
  HomeState build() {
    return HomeState();
  }

  Future<void> fetchSteps() async {
    state = state.copyWith(isLoading: true);
    try {
      final authState = ref.read(authViewModelProvider);
      if (authState is! AuthStateAuthenticated) {
        throw Exception('ユーザーが認証されていません');
      }

      final stepsViewModel = ref.read(stepsViewModelProvider.notifier);

      // Health APIの初期化と認証
      await stepsViewModel.initializeHealthService();

      // 歩数の取得と更新
      await stepsViewModel.fetchAndUpdateSteps(authState.user.uid);

      // 歩数データの取得
      final dailyRecord = stepsViewModel.state.dailyRecord;
      final steps = dailyRecord?.steps ?? 0;

      state = state.copyWith(steps: steps, isLoading: false);
    } catch (e) {
      state = state.copyWith(error: e.toString(), isLoading: false);
    }
  }

  void updateCarouselIndex(int index) {
    state = state.copyWith(currentCarouselIndex: index);
  }
}
