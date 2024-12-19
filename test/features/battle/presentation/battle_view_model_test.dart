import 'package:flutter_test/flutter_test.dart';
import 'package:riverpod/riverpod.dart';

import '../../../../lib/features/battle/presentation/battle_view_model.dart';
import '../../../../lib/shared/constants/company_constants.dart';

void main() {
  late ProviderContainer container;

  setUp(() {
    container = ProviderContainer();
  });

  group('BattleViewModel', () {
    test('バトル結果が正しく処理される', () async {
      final viewModel = container.read(battleViewModelProvider.notifier);

      final result = await viewModel.startBattle(
        userId1: 'user1',
        userId2: 'user2',
        steps1: 1000,
        steps2: 500,
      );

      expect(result.winnerId, 'user1');
      expect(result.loserId, 'user2');
      expect(result.stepsDifference, 500);
      expect(result.amountChanged, 500 * CompanyConstants.battleMultiplier);
    });
  });
}
