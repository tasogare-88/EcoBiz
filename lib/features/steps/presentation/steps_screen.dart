// ヘルスコネクトアプリのインストール確認ダイアログ
// 該当箇所のUIを作成次第呼び出す予定。

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../presentation/steps_view_model.dart';

Future<void> showHealthConnectSetupDialog(
    BuildContext context, WidgetRef ref) async {
  final completed = await showDialog<bool>(
    context: context,
    barrierDismissible: false,
    builder: (context) => AlertDialog(
      title: const Text('Health Connectのセットアップ'),
      content: const Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('以下の手順でセットアップを完了してください：'),
          SizedBox(height: 8),
          Text('1. Health Connectをインストール'),
          Text('2. アプリを開いて初期設定を完了'),
          Text('3. 歩数データへのアクセスを許可'),
          SizedBox(height: 16),
          Text('すべての設定が完了したら「完了」を押してください'),
        ],
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context, false),
          child: const Text('キャンセル'),
        ),
        ElevatedButton(
          onPressed: () => Navigator.pop(context, true),
          child: const Text('完了'),
        ),
      ],
    ),
  );

  if (completed == true) {
    // 再度初期化を試みる
    await ref.read(stepsViewModelProvider.notifier).initializeHealthService();
  }
}
