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
        backgroundColor: Colors.teal,
        elevation: 0,
        centerTitle: true,
      ),
      body: Column(
        children: [
          _buildCustomHeader(),
          Expanded(
            child: Column(
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
                    padding: const EdgeInsets.symmetric(
                        vertical: 16, horizontal: 32),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                    backgroundColor: Colors.teal,
                  ),
                  child: const Text(
                    'ガチャを引く',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCustomHeader() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      decoration: const BoxDecoration(
        color: Colors.teal,
        borderRadius: BorderRadius.vertical(
          bottom: Radius.circular(20),
        ),
      ),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                Icons.attach_money,
                color: Colors.yellowAccent,
                size: 32,
              ),
              const SizedBox(width: 8),
              Text(
                '資金獲得チャレンジ',
                style: const TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
              const SizedBox(width: 8),
              Icon(
                Icons.monetization_on,
                color: Colors.yellowAccent,
                size: 32,
              ),
            ],
          ),
          const SizedBox(height: 10),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                Icons.savings,
                color: Colors.white.withOpacity(0.9),
                size: 24,
              ),
              const SizedBox(width: 8),
              Text(
                'お金を貯めて勝利を目指せ！',
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.white.withOpacity(0.9),
                ),
              ),
              const SizedBox(width: 8),
              Icon(
                Icons.account_balance_wallet,
                color: Colors.white.withOpacity(0.9),
                size: 24,
              ),
            ],
          ),
        ],
      ),
    );
  }
}
