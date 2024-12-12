import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'home_view_model.dart';

class HomeScreen extends ConsumerWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final homeState = ref.watch(homeViewModelProvider);

    // 画面表示時に歩数データを取得
    ref.listen(homeViewModelProvider, (previous, next) {
      if (next.error != null) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(next.error!)),
        );
      }
    });

    useEffect(() {
      ref.read(homeViewModelProvider.notifier).fetchSteps();
      return null;
    }, const []);

    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            _buildHeader(homeState),
            _buildCarousel(),
            _buildMenuGrid(),
          ],
        ),
      ),
    );
  }

  Widget _buildHeader(HomeState state) {
    return Container(
      padding: const EdgeInsets.all(16),
      child: Row(
        children: [
          CircleAvatar(
            radius: 24,
            child: Icon(Icons.person),
          ),
          const SizedBox(width: 12),
          Icon(Icons.directions_walk),
          if (state.isLoading)
            const SizedBox(
              width: 20,
              height: 20,
              child: CircularProgressIndicator(strokeWidth: 2),
            )
          else
            Text('${state.steps}歩'),
          const Spacer(),
          IconButton(
            icon: Icon(Icons.menu),
            onPressed: () {
              // TODO: メニュー表示する
            },
          ),
        ],
      ),
    );
  }

  Widget _buildCarousel() {
    return Container(
      height: 200,
      child: PageView.builder(
        itemCount: 5,
        itemBuilder: (context, index) {
          return Card(
            margin: EdgeInsets.symmetric(horizontal: 8),
            child: Center(
              child: Text('カルーセル ${index + 1}'),
            ),
          );
        },
      ),
    );
  }

  Widget _buildMenuGrid() {
    final menuItems = [
      MenuItemData('記録', Icons.book),
      MenuItemData('ランキング', Icons.leaderboard),
      MenuItemData('ショップ', Icons.store),
      MenuItemData('タスク', Icons.checklist),
    ];

    return GridView.count(
      shrinkWrap: true,
      crossAxisCount: 2,
      padding: EdgeInsets.all(16),
      children: menuItems.map((item) => _buildMenuItem(item)).toList(),
    );
  }

  Widget _buildMenuItem(MenuItemData item) {
    return Card(
      color: Color(0xFFFFE4C4),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(item.icon, size: 32),
          SizedBox(height: 8),
          Text(item.title),
        ],
      ),
    );
  }
}

class MenuItemData {
  final String title;
  final IconData icon;

  MenuItemData(this.title, this.icon);
}
