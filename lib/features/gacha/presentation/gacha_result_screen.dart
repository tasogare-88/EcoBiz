import 'package:flutter/material.dart';
import 'dart:math';

class GachaResultScreen extends StatefulWidget {
  const GachaResultScreen({Key? key}) : super(key: key);

  @override
  _GachaResultScreenState createState() => _GachaResultScreenState();
}

class _GachaResultScreenState extends State<GachaResultScreen> {
  late int randomAmount;

  @override
  void initState() {
    super.initState();
    _generateRandomAmount();
  }

  void _generateRandomAmount() {
    final random = Random();
    setState(() {
      randomAmount = 50 + (1000 * (1.0 - (random.nextDouble() * 0.5))).round();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.teal,
        title: const Text(
          'ガチャ結果',
          style: TextStyle(color: Colors.white),
        ),
      ),
      body: Container(
        width: double.infinity,
        padding: const EdgeInsets.all(16),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            _buildResultHeader(),
            const SizedBox(height: 20),
            Text(
              '獲得した資金：¥$randomAmount',
              style: const TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Colors.green,
              ),
            ),
            const SizedBox(height: 40),
            ElevatedButton(
              onPressed: () {
                _generateRandomAmount(); // 新しい乱数を生成
              },
              style: ElevatedButton.styleFrom(
                padding:
                    const EdgeInsets.symmetric(vertical: 16, horizontal: 32),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30),
                ),
                backgroundColor: Colors.teal,
              ),
              child: const Text(
                'もう一度引く',
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
    );
  }

  Widget _buildResultHeader() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.teal.withOpacity(0.1),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: Colors.teal.withOpacity(0.5),
          width: 1.5,
        ),
      ),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                Icons.stars,
                size: 32,
                color: Colors.amber,
              ),
              const SizedBox(width: 8),
              const Text(
                'ガチャ結果！',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Colors.teal,
                ),
              ),
              const SizedBox(width: 8),
              Icon(
                Icons.stars,
                size: 32,
                color: Colors.amber,
              ),
            ],
          ),
          const SizedBox(height: 10),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                Icons.attach_money,
                size: 28,
                color: Colors.green,
              ),
              const SizedBox(width: 8),
              Text(
                'あなたの運を試しましょう！',
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.teal.withOpacity(0.9),
                ),
              ),
              const SizedBox(width: 8),
              Icon(
                Icons.monetization_on,
                size: 28,
                color: Colors.green,
              ),
            ],
          ),
        ],
      ),
    );
  }
}
