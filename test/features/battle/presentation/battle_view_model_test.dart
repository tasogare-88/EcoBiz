import 'package:fake_cloud_firestore/fake_cloud_firestore.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:riverpod/riverpod.dart';

import '../../../../lib/core/providers/firebase_providers.dart';
import '../../../../lib/features/battle/data/battle_repository.dart';
import '../../../../lib/features/battle/domain/battle_result.dart';
import '../../../../lib/features/battle/presentation/battle_view_model.dart';
import '../../../../lib/features/company/presentation/company_view_model.dart';
import '../../../../lib/shared/constants/company_constants.dart';

class MockCompanyViewModel extends CompanyViewModel {
  int _currentAssets = 1000;

  @override
  int getCurrentTotalAssets() => _currentAssets;

  @override
  Future<void> updateCompanyAssets(String userId, int newAmount) async {
    _currentAssets = newAmount;
  }
}

class MockBattleRepository extends AutoDisposeAsyncNotifier<void>
    implements BattleRepository {
  @override
  Future<void> build() async {}

  @override
  Future<BattleResult> processBattleResult({
    required String userId1,
    required String userId2,
    required int steps1,
    required int steps2,
  }) async {
    return BattleResult(
      winnerId: userId1,
      loserId: userId2,
      winnerSteps: steps1,
      loserSteps: steps2,
      stepsDifference: steps1 - steps2,
      amountChanged: (steps1 - steps2) * CompanyConstants.battleMultiplier,
      createdAt: DateTime.now(),
      multiplier: CompanyConstants.battleMultiplier,
    );
  }
}

void main() {
  late ProviderContainer container;
  late FakeFirebaseFirestore fakeFirestore;

  setUp(() {
    fakeFirestore = FakeFirebaseFirestore();
    container = ProviderContainer(
      overrides: [
        firestoreProvider.overrideWithValue(fakeFirestore),
        companyViewModelProvider.overrideWith(() => MockCompanyViewModel()),
        battleRepositoryProvider.overrideWith(() => MockBattleRepository()),
      ],
    );
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
