import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../features/steps/presentation/steps_screen.dart';
import 'home_view_model.dart';

class HomeScreen extends ConsumerStatefulWidget {
  const HomeScreen({super.key});

  @override
  ConsumerState<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends ConsumerState<HomeScreen> {
  @override
  void initState() {
    super.initState();
    // initStateで歩数データを取得
    Future.microtask(
        () => ref.read(homeViewModelProvider.notifier).fetchSteps());
  }

  @override
  Widget build(BuildContext context) {
    final homeState = ref.watch(homeViewModelProvider);

    // 画面表示時に歩数データを取得
    ref.listen(homeViewModelProvider, (previous, next) {
      if (next.error != null) {
        if (next.error!.contains('Health Connect')) {
          showHealthConnectSetupDialog(context, ref);
        } else {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(next.error!),
              action: SnackBarAction(
                label: '再試行',
                onPressed: () {
                  ref.read(homeViewModelProvider.notifier).fetchSteps();
                },
              ),
            ),
          );
        }
      }
    });

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
            backgroundColor: const Color.fromARGB(255, 234, 221, 255),
            child: Icon(Icons.person, size: 30),
          ),
          const SizedBox(width: 16),
          Icon(Icons.directions_walk, size: 30),
          const SizedBox(width: 4),
          if (state.isLoading)
            const SizedBox(
              width: 20,
              height: 20,
              child: CircularProgressIndicator(strokeWidth: 2),
            )
          else
            Text(
              '${state.steps} 歩',
              style: TextStyle(
                fontSize: 20,
                // fontWeight: FontWeight.bold,
              ),
            ),
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
          Icon(item.icon, size: 100),
          SizedBox(height: 12),
          Text(
            item.title,
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
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
