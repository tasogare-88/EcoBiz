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
    debugPrint('Unity初期化開始');
    try {
      debugPrint('LoadScene呼び出し前');
      // シーン読み込み
      await controller.postMessage('BattleManager', 'LoadScene', 'Battle');

      await Future.delayed(const Duration(seconds: 1));

      // バトルデータを準備
      final user1 =
          await ref.read(userRepositoryProvider.notifier).getUser(userId1);
      final user2 =
          await ref.read(userRepositoryProvider.notifier).getUser(userId2);
      final battleResult =
          await ref.read(battleViewModelProvider.notifier).startBattle(
                userId1: userId1,
                userId2: userId2,
                steps1: steps1,
                steps2: steps2,
              );
      
      final battleData = {
        'userName': user1?.name ?? 'Unknown',
        'opponentName': user2?.name ?? 'Unknown',
        'mySteps': steps1,
        'opponentSteps': steps2,
        'isWinner': battleResult.winnerId == userId1,
        'isDraw': battleResult.stepsDifference == 0,
        'assetChange': battleResult.amountChanged,
      };
      await controller.postMessage(
          'BattleManager', 'SetBattleData', jsonEncode(battleData));

      await Future.delayed(const Duration(seconds: 1));
      //await controller.postMessage('BattleManager', 'StartBattleData', '');
    } catch (e) {
      debugPrint('Unity初期化エラー: $e');
    }
  }

  void onUnitySceneLoaded(SceneLoaded? scene) {
    debugPrint('Unityシーン読み込み完了: ${scene?.name}');
  }

  void onUnityMessage(dynamic message) {
    debugPrint('Unityからのメッセージ: $message');
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    debugPrint('UnityBattleScreen の build メソッドが呼び出されました');
    return Scaffold(
      body: UnityWidget(
        onUnityCreated: (controller) {
          debugPrint('onUnityCreatedコールバックが呼び出されました');
          debugPrint("再確認 : userId1: $userId1, userId2: $userId2, steps1: $steps1, steps2: $steps2");
          onUnityCreated(controller, ref);
        },
        onUnitySceneLoaded: onUnitySceneLoaded,
        onUnityMessage: onUnityMessage,
        fullscreen: true,
        useAndroidViewSurface: true,
        borderRadius: BorderRadius.zero,
        // enablePlaceholder: true,
        // placeholder: const Center(
        //   child: CircularProgressIndicator(),
        // ),
      ),
    );
  }
}
