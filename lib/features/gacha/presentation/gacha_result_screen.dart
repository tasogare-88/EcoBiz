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
      ),
      body: Container(
        width: double.infinity,
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text(
                'ガチャ結果！',
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 20),
              Text(
                '獲得した資金：¥$randomAmount',
                style: const TextStyle(fontSize: 20, color: Colors.green),
              ),
              const SizedBox(height: 40),
              ElevatedButton(
                onPressed: () {
                  _generateRandomAmount(); // 新しい乱数を生成
                },
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 32),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                ),
                child: const Text(
                  'もう一度引く',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}