import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

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
      // TODO: ヘルスケアAPIから歩数を取得する実装
      final steps = 0; // 仮の実装。後でHealth APIと連携
      state = state.copyWith(steps: steps, isLoading: false);
    } catch (e) {
      state = state.copyWith(error: e.toString(), isLoading: false);
    }
  }

  void updateCarouselIndex(int index) {
    state = state.copyWith(currentCarouselIndex: index);
  }
}
