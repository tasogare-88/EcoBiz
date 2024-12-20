import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../company/presentation/company_view_model.dart';
import '../data/battle_repository.dart';
import '../domain/battle_result.dart';

part 'battle_view_model.g.dart';

@riverpod
class BattleViewModel extends _$BattleViewModel {
  @override
  FutureOr<void> build() {}

  Future<BattleResult> startBattle({
    required String userId1,
    required String userId2,
    required int steps1,
    required int steps2,
  }) async {
    final battleResult =
        await ref.read(battleRepositoryProvider.notifier).processBattleResult(
              userId1: userId1,
              userId2: userId2,
              steps1: steps1,
              steps2: steps2,
            );

    // 勝者の総資産を増やし、敗者の総資産を減らす
    final companyViewModel = ref.read(companyViewModelProvider.notifier);

    // 勝者の資産を更新
    final winnerCurrentAssets = await companyViewModel.getCurrentTotalAssets();
    await companyViewModel.updateCompanyAssets(
      battleResult.winnerId,
      winnerCurrentAssets + battleResult.amountChanged,
    );

    // 敗者の資産を更新
    final loserCurrentAssets = await companyViewModel.getCurrentTotalAssets();
    await companyViewModel.updateCompanyAssets(
      battleResult.loserId,
      loserCurrentAssets - battleResult.amountChanged,
    );

    return battleResult;
  }
}
