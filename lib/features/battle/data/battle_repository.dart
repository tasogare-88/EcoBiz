import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../shared/constants/company_constants.dart';
import '../domain/battle_result.dart';

part 'battle_repository.g.dart';

@riverpod
class BattleRepository extends _$BattleRepository {
  @override
  FutureOr<void> build() {}

  Future<BattleResult> processBattleResult({
    required String userId1,
    required String userId2,
    required int steps1,
    required int steps2,
  }) async {
    final now = DateTime.now();
    final date = now.toString().substring(0, 10).replaceAll('-', '');

    String winnerId;
    String loserId;
    int winnerSteps;
    int loserSteps;

    if (steps1 > steps2) {
      winnerId = userId1;
      loserId = userId2;
      winnerSteps = steps1;
      loserSteps = steps2;
    } else {
      winnerId = userId2;
      loserId = userId1;
      winnerSteps = steps2;
      loserSteps = steps1;
    }

    final stepsDifference = winnerSteps - loserSteps;
    final amountChanged = stepsDifference * CompanyConstants.battleMultiplier;

    final battleResult = BattleResult(
      winnerId: winnerId,
      loserId: loserId,
      winnerSteps: winnerSteps,
      loserSteps: loserSteps,
      stepsDifference: stepsDifference,
      amountChanged: amountChanged,
      multiplier: CompanyConstants.battleMultiplier,
      createdAt: now,
    );

    // Firestoreに保存
    await FirebaseFirestore.instance
        .collection('battles')
        .doc(date)
        .collection('records')
        .add(battleResult.toJson());

    return battleResult;
  }
}
