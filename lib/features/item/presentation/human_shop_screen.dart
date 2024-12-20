import 'package:flutter/material.dart';

class HumanShopScreen extends StatelessWidget {
  const HumanShopScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('人材ショップ'),
        centerTitle: true,
      ),
      body: ListView(
        children: [
          _buildShopItem(
            title: 'エンジニア',
            description: '優秀なエンジニアを雇用',
            price: '¥100,000',
            icon: Icons.computer,
          ),
          _buildShopItem(
            title: 'デザイナー',
            description: 'クリエイティブなデザイナー',
            price: '¥80,000',
            icon: Icons.brush,
          ),
          _buildShopItem(
            title: 'マネージャー',
            description: '優れた管理能力を持つ人材',
            price: '¥120,000',
            icon: Icons.manage_accounts,
          ),
          _buildShopItem(
            title: '営業担当',
            description: '売上を拡大するプロフェッショナル',
            price: '¥90,000',
            icon: Icons.handshake,
          ),
          _buildShopItem(
            title: 'マーケター',
            description: '市場分析で戦略を立案',
            price: '¥110,000',
            icon: Icons.campaign,
          ),
          _buildShopItem(
            title: 'データサイエンティスト',
            description: 'データを活用し業績を向上',
            price: '¥150,000',
            icon: Icons.analytics,
          ),
          _buildShopItem(
            title: 'カスタマーサポート',
            description: '顧客対応に特化した人材',
            price: '¥70,000',
            icon: Icons.support_agent,
          ),
           _buildShopItem(
            title: 'HRスペシャリスト',
            description: '採用と組織管理に優れた人材',
            price: '¥95,000',
            icon: Icons.people,
          ),
          _buildShopItem(
            title: 'AIエキスパート',
            description: 'AI技術を駆使して業績を革新',
            price: '¥180,000',
            icon: Icons.analytics,
          ),
        ],
      ),
    );
  }

  Widget _buildShopItem({
    required String title,
    required String description,
    required String price,
    required IconData icon,
  }) {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: ListTile(
        leading: Icon(icon, size: 40, color: Colors.blue),
        title: Text(title, style: const TextStyle(fontWeight: FontWeight.bold)),
        subtitle: Text(description),
        trailing: Text(price, style: const TextStyle(color: Colors.green)),
      ),
    );
  }
}
