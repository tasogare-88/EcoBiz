import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'gacha_result_screen.dart';
import '../../../shared/widgets/gacha_animation.dart';

class GachaScreen extends ConsumerWidget {
  const GachaScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Center(
            child: GachaAnimation(),
          ),
          const SizedBox(height: 20),
          ElevatedButton(
            onPressed: () {
              // ガチャ結果画面に遷移
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const GachaResultScreen(),
                ),
              );
            },
            style: ElevatedButton.styleFrom(
              padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 32),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(30),
              ),
            ),
            child: const Text(
              'ガチャを引く',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
          ),
        ],
      ),
    );
  }
}
