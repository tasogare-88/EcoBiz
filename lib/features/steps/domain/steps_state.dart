import 'package:freezed_annotation/freezed_annotation.dart';

import 'daily_record.dart';

part 'steps_state.freezed.dart';

@freezed
class StepsState with _$StepsState {
  const factory StepsState({
    DailyRecord? dailyRecord,
    @Default(false) bool isLoading,
    String? error,
  }) = _StepsState;
}
