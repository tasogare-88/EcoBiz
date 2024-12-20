import 'package:flutter/material.dart';
import 'human_shop_screen.dart';
import 'company_shop_screen.dart';

class ItemScreen extends StatelessWidget {
  const ItemScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('アイテム選択'),
        centerTitle: true,
      ),
      body: Row(
        children: [
          // 左側の「人材」ボックス
          Expanded(
            child: GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const HumanShopScreen(),
                  ),
                );
              },
              child: Container(
                color: Color(0xFFFFE4C4), // 朱色
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: const [
                    Icon(
                      Icons.person, // 人材アイコン
                      size: 50,
                      color: Colors.white,
                    ),
                    SizedBox(height: 10),
                    Text(
                      '人材',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          // 右側の「会社」ボックス
          Expanded(
            child: GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const CompanyShopScreen(),
                  ),
                );
              },
              child: Container(
                color: Color(0xFFB5D4E4), // 朱色
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: const [
                    Icon(
                      Icons.business, // 会社アイコン
                      size: 50,
                      color: Colors.white,
                    ),
                    SizedBox(height: 10),
                    Text(
                      '会社',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
