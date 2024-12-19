import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_unity_widget/flutter_unity_widget.dart';

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
    final battleResult =
        await ref.read(battleViewModelProvider.notifier).startBattle(
              userId1: userId1,
              userId2: userId2,
              steps1: steps1,
              steps2: steps2,
            );

    // Unity側にバトル結果を送信
    controller.postMessage(
      'BattleManager',
      'ProcessBattleResult',
      jsonEncode(battleResult.toJson()),
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
