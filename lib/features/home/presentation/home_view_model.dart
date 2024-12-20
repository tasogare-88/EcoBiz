import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../core/auth/presentation/auth_view_model.dart';
import '../../company/presentation/company_view_model.dart';
import '../../steps/presentation/steps_view_model.dart';

part 'home_view_model.freezed.dart';
part 'home_view_model.g.dart';

@freezed
class HomeState with _$HomeState {
  const factory HomeState({
    @Default(0) int steps,
    @Default(0) int totalAssets,
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
      final userId = authState.maybeMap(
        authenticated: (state) => state.user.id,
        orElse: () => null,
      );

      if (userId == null) {
        state = state.copyWith(error: 'ユーザー情報の取得に失敗しました');
        return;
      }

      final stepsViewModel = ref.read(stepsViewModelProvider.notifier);
      final companyViewModel = ref.read(companyViewModelProvider.notifier);

      // Health APIの初期化と認証
      await stepsViewModel.initializeHealthService();

      // 歩数の取得と更新
      await stepsViewModel.fetchAndUpdateSteps(userId);

      // 歩数データの取得
      final dailyRecord = stepsViewModel.state.dailyRecord;
      final steps = dailyRecord?.steps ?? 0;

      // 総資産の取得
      final totalAssets = companyViewModel.getCurrentTotalAssets();

      state = state.copyWith(
        steps: steps,
        totalAssets: totalAssets,
        isLoading: false,
      );
    } catch (e) {
      state = state.copyWith(error: e.toString(), isLoading: false);
    }
  }

  void updateCarouselIndex(int index) {
    state = state.copyWith(currentCarouselIndex: index);
  }

  Future<void> initializeApp(String userId) async {
    state = state.copyWith(isLoading: true, error: null);

    try {
      final stepsViewModel = ref.read(stepsViewModelProvider.notifier);
      final companyViewModel = ref.read(companyViewModelProvider.notifier);

      // Health APIの初期化と認証
      await stepsViewModel.initializeHealthService();

      // 歩数の取得と更新
      await stepsViewModel.fetchAndUpdateSteps(userId);

      // 会社データの取得
      await companyViewModel.loadCompany(userId);

      state = state.copyWith(
        isLoading: false,
      );
    } catch (e) {
      state = state.copyWith(error: e.toString(), isLoading: false);
    }
  }
}
