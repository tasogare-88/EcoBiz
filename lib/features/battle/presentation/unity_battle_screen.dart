import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_unity_widget/flutter_unity_widget.dart';

import '../../../core/auth/data/user_repository.dart';
import './battle_view_model.dart';

class UnityBattleScreen extends ConsumerWidget {
  final String userId1;
  final String userId2;
  final int steps1;
  final int steps2;

  const UnityBattleScreen({
    super.key,
    required this.userId1,
    required this.userId2,
    required this.steps1,
    required this.steps2,
  });

  void onUnityCreated(UnityWidgetController controller, WidgetRef ref) async {
    final user1 =
        await ref.read(userRepositoryProvider.notifier).getUser(userId1);
    final user2 =
        await ref.read(userRepositoryProvider.notifier).getUser(userId2);

    // バトル結果を取得
    final battleResult =
        await ref.read(battleViewModelProvider.notifier).startBattle(
              userId1: userId1,
              userId2: userId2,
              steps1: steps1,
              steps2: steps2,
            );

    // Unity側に送信するデータ
    final battleData = {
      'myName': user1?.name ?? 'Unknown',
      'opponentName': user2?.name ?? 'Unknown',
      'mySteps': steps1,
      'opponentSteps': steps2,
      'isWinner': battleResult.winnerId == userId1,
      'isDraw': battleResult.stepsDifference == 0,
      'assetChange': battleResult.amountChanged,
    };

    controller.postMessage(
      'BattleCanvas',
      'SetBattleData',
      jsonEncode(battleData),
    );
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      body: UnityWidget(
        onUnityCreated: (controller) => onUnityCreated(controller, ref),
      ),
    );
  }
}
