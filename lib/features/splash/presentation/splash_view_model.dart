import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'splash_view_model.freezed.dart';

@freezed
class SplashState with _$SplashState {
  const factory SplashState({
    @Default(true) bool isLoading,
    String? error,
  }) = _SplashState;
}

final splashViewModelProvider =
    StateNotifierProvider<SplashViewModel, SplashState>((ref) {
  return SplashViewModel(ref);
});

class SplashViewModel extends StateNotifier<SplashState> {
  final Ref ref;

  SplashViewModel(this.ref) : super(const SplashState());

  Future<void> initialize() async {
    try {
      await Future.delayed(const Duration(seconds: 5));
      state = state.copyWith(isLoading: false);
    } catch (e) {
      state = state.copyWith(error: e.toString(), isLoading: false);
    }
  }
}
