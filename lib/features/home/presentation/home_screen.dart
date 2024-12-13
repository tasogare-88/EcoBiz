import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../features/steps/presentation/steps_screen.dart';
import 'home_view_model.dart';

class HomeScreen extends StatefulHookConsumerWidget {
  const HomeScreen({super.key});

  @override
  HomeScreenState createState() => HomeScreenState();
}

class HomeScreenState extends ConsumerState<HomeScreen> {
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
            buildHeader(homeState),
            buildCarousel(),
            buildMenuGrid(),
          ],
        ),
      ),
    );
  }

  Widget buildHeader(HomeState state) {
    return Container(
      padding: const EdgeInsets.all(16),
      child: Row(
        children: [
          CircleAvatar(
            radius: 24,
            backgroundColor: const Color(0xFFEADDFF),
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

  Widget buildCarousel() {
    return HookBuilder(
      builder: (context) {
        final pageController = usePageController();
        final currentPage = useState(0);

        useEffect(() {
          final timer = Timer.periodic(Duration(seconds: 5), (timer) {
            if (pageController.hasClients) {
              final nextPage = (currentPage.value + 1) % 5;
              pageController.animateToPage(
                nextPage,
                duration: Duration(milliseconds: 500), // 5秒で次のカルーセルに移動
                curve: Curves.easeInOut,
              );
            }
          });

          return timer.cancel;
        }, []);

        return Stack(
          children: [
            Container(
              height: 200,
              child: PageView.builder(
                controller: pageController,
                itemCount: 5,
                onPageChanged: (index) {
                  currentPage.value = index;
                },
                itemBuilder: (context, index) {
                  return Card(
                    margin: EdgeInsets.symmetric(horizontal: 8),
                    child: Center(
                      child: Text('カルーセル ${index + 1}'),
                    ),
                  );
                },
              ),
            ),
            // 左矢印
            Positioned(
              left: 8,
              top: 0,
              bottom: 0,
              child: Center(
                child: IconButton(
                  icon: Icon(Icons.arrow_back_ios),
                  onPressed: () {
                    pageController.previousPage(
                      duration: Duration(milliseconds: 300),
                      curve: Curves.easeInOut,
                    );
                  },
                ),
              ),
            ),
            // 右矢印
            Positioned(
              right: 8,
              top: 0,
              bottom: 0,
              child: Center(
                child: IconButton(
                  icon: Icon(Icons.arrow_forward_ios),
                  onPressed: () {
                    pageController.nextPage(
                      duration: Duration(milliseconds: 300),
                      curve: Curves.easeInOut,
                    );
                  },
                ),
              ),
            ),
            // ページインジケーター
            Positioned(
              bottom: 16,
              left: 0,
              right: 0,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: List.generate(5, (index) {
                  return Container(
                    margin: EdgeInsets.symmetric(horizontal: 4),
                    width: 8,
                    height: 8,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: currentPage.value == index
                          ? Colors.blue
                          : Colors.grey.withOpacity(0.5),
                    ),
                  );
                }),
              ),
            ),
          ],
        );
      },
    );
  }

  Widget buildMenuItem(MenuItemData item) {
    return Card(
      color: Color(0xFFFFDEAA),
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

  Widget buildMenuGrid() {
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
      mainAxisSpacing: 16,
      crossAxisSpacing: 16,
      children: menuItems.map((item) => buildMenuItem(item)).toList(),
    );
  }
}

class MenuItemData {
  final String title;
  final IconData icon;

  MenuItemData(this.title, this.icon);
}
