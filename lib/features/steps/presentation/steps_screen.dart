// ヘルスコネクトアプリのインストール確認ダイアログ
// 該当箇所のUIを作成次第呼び出す予定。

// import 'package:flutter/material.dart';
// import 'package:flutter_riverpod/flutter_riverpod.dart';

// import '../presentation/steps_view_model.dart';

// Future<void> _initializeHealthService(
//     BuildContext context, WidgetRef ref) async {
//   try {
//     await ref.read(stepsViewModelProvider.notifier).initializeHealthService();
//   } catch (e) {
//     if (e.toString().contains('Health Connectのセットアップを完了してください')) {
//       final completed = await showDialog<bool>(
//         context: context,
//         barrierDismissible: false,
//         builder: (context) => AlertDialog(
//           title: const Text('Health Connectのセットアップ'),
//           content: const Text('Health Connectのインストールとセットアップを完了したら「完了」を押してください'),
//           actions: [
//             TextButton(
//               onPressed: () => Navigator.pop(context, true),
//               child: const Text('完了'),
//             ),
//             TextButton(
//               onPressed: () => Navigator.pop(context, false),
//               child: const Text('キャンセル'),
//             ),
//           ],
//         ),
//       );

//       if (completed == true) {
//         // 再度初期化を試みる
//         await _initializeHealthService(context, ref);
//       }
//     }
//   }
// }
