import 'package:flutter/material.dart';

class CompanyShopScreen extends StatelessWidget {
  const CompanyShopScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('会社ショップ'),
        centerTitle: true,
      ),
      body: ListView(
        children: [
          _buildShopItem(
            title: 'IT企業',
            description: '最先端の技術を提供する企業',
            price: '¥500,000',
            icon: Icons.code,
          ),
          _buildShopItem(
            title: '飲食店',
            description: 'おいしい料理を提供する店舗',
            price: '¥300,000',
            icon: Icons.restaurant,
          ),
          _buildShopItem(
            title: '小売店',
            description: '多様な商品を扱う店舗',
            price: '¥200,000',
            icon: Icons.store,
          ),
          _buildShopItem(
            title: '医療施設',
            description: '健康を支える企業',
            price: '¥400,000',
            icon: Icons.local_hospital,
          ),
          _buildShopItem(
            title: '物流会社',
            description: '配送網を支える企業',
            price: '¥350,000',
            icon: Icons.local_shipping,
          ),
          _buildShopItem(
            title: '建設会社',
            description: '街を作り上げる企業',
            price: '¥450,000',
            icon: Icons.construction,
          ),
          _buildShopItem(
            title: '教育機関',
            description: '次世代を育成する学校',
            price: '¥250,000',
            icon: Icons.school,
          ),
          _buildShopItem(
            title: 'エコ企業',
            description: '環境保全に取り組む企業',
            price: '¥320,000',
            icon: Icons.eco,
          ),
          _buildShopItem(
            title: 'エンターテイメント会社',
            description: '楽しい体験を提供する企業',
            price: '¥280,000',
            icon: Icons.movie,
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
