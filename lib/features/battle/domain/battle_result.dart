import 'package:freezed_annotation/freezed_annotation.dart';

part 'battle_result.freezed.dart';
part 'battle_result.g.dart';

@freezed
class BattleResult with _$BattleResult {
  const factory BattleResult({
    required String winnerId,
    required String loserId,
    required int winnerSteps,
    required int loserSteps,
    required int stepsDifference,
    required int amountChanged,
    required int multiplier,
    required DateTime createdAt,
  }) = _BattleResult;

  factory BattleResult.fromJson(Map<String, dynamic> json) =>
      _$BattleResultFromJson(json);
}
