import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../features/steps/presentation/steps_screen.dart';
import '../../../shared/widgets/menu_item.dart';
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
        child: LayoutBuilder(
          builder: (context, constraints) {
            final availableHeight = constraints.maxHeight;
            final headerHeight = availableHeight * 0.10;
            final carouselHeight = availableHeight * 0.35;

            return Column(
              children: [
                SizedBox(
                  height: headerHeight,
                  child: buildHeader(homeState),
                ),
                SizedBox(
                  height: carouselHeight,
                  child: buildCarousel(),
                ),
                Expanded(
                  child: buildResponsiveMenuGrid(constraints),
                ),
              ],
            );
          },
        ),
      ),
    );
  }

  Widget buildResponsiveMenuGrid(BoxConstraints constraints) {
    final menuItems = [
      MenuItemData('記録', Icons.book),
      MenuItemData('ランキング', Icons.leaderboard),
      MenuItemData('ショップ', Icons.store),
      MenuItemData('タスク', Icons.checklist),
    ];

    final itemWidth = (constraints.maxWidth - 48) / 2;
    final itemHeight = itemWidth * 0.9;
    final aspectRatio = itemWidth / itemHeight;

    return Container(
      color: const Color(0xFFFEF0E5),
      child: Center(
        child: GridView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            childAspectRatio: aspectRatio,
            mainAxisSpacing: 16,
            crossAxisSpacing: 16,
          ),
          padding: const EdgeInsets.all(16),
          itemCount: menuItems.length,
          itemBuilder: (context, index) => ResponsiveMenuItem(
            title: menuItems[index].title,
            icon: menuItems[index].icon,
            onTap: () {
              // TODO: メニュー項目タップ時の処理
            },
          ),
        ),
      ),
    );
  }

  Widget buildHeader(HomeState state) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Color(0xFFB5D4E4),
      ),
      child: Row(
        children: [
          CircleAvatar(
            radius: 24,
            backgroundColor: const Color(0xFFEADDFF),
            child: Icon(Icons.person, size: 30),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Row(
                    children: [
                      Icon(Icons.business, size: 30, color: Colors.black),
                      const SizedBox(width: 8),
                      Text(
                        '${state.totalAssets} 円',
                        style: TextStyle(
                          fontSize: 20,
                          color: Colors.black,
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Row(
                    children: [
                      Icon(Icons.directions_walk,
                          size: 30, color: Colors.black),
                      const SizedBox(width: 4),
                      if (state.isLoading)
                        const SizedBox(
                          width: 20,
                          height: 20,
                          child: CircularProgressIndicator(
                            strokeWidth: 2,
                            valueColor:
                                AlwaysStoppedAnimation<Color>(Colors.black),
                          ),
                        )
                      else
                        Text(
                          '${state.steps} 歩',
                          style: TextStyle(
                            fontSize: 20,
                            color: Colors.black,
                          ),
                        ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          IconButton(
            icon: Icon(Icons.menu, color: Colors.black, size: 30),
            onPressed: () {
              // TODO: 設定メニューを表示する
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

        return Container(
          color: Color(0xFFFFEBD5),
          child: Row(
            children: [
              // 左矢印
              Container(
                height: 180,
                child: Align(
                  alignment: Alignment(0, -0.1),
                  child: IconButton(
                    icon: Icon(
                      Icons.arrow_back_ios_new_outlined,
                      color: currentPage.value > 0
                          ? Colors.black
                          : Colors.grey.withOpacity(0.3),
                    ),
                    onPressed: currentPage.value > 0
                        ? () {
                            pageController.previousPage(
                              duration: Duration(milliseconds: 300),
                              curve: Curves.easeInOut,
                            );
                          }
                        : null,
                  ),
                ),
              ),
              // カルーセル
              Expanded(
                child: Stack(
                  alignment: Alignment.center,
                  children: [
                    Positioned(
                      top: 0,
                      left: 0,
                      right: 0,
                      bottom: 24,
                      child: PageView.builder(
                        controller: pageController,
                        itemCount: 5,
                        onPageChanged: (index) {
                          currentPage.value = index;
                        },
                        itemBuilder: (context, index) {
                          return Card(
                            elevation: 4,
                            margin: EdgeInsets.symmetric(
                              horizontal: 8,
                              vertical: 16,
                            ),
                            child: Center(
                              child: Text('カルーセル ${index + 1}'),
                            ),
                          );
                        },
                      ),
                    ),
                    // インジケータ
                    Positioned(
                      bottom: 8,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: List.generate(
                          5,
                          (index) => Container(
                            margin: EdgeInsets.symmetric(horizontal: 4),
                            width: 8,
                            height: 8,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: currentPage.value == index
                                  ? Colors.blue
                                  : Colors.grey.shade300,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              // 右矢印
              Container(
                height: 180,
                child: Align(
                  alignment: Alignment(0, -0.1),
                  child: IconButton(
                    icon: Icon(
                      Icons.arrow_forward_ios_outlined,
                      color: currentPage.value < 4
                          ? Colors.black
                          : Colors.grey.withOpacity(0.3),
                    ),
                    onPressed: currentPage.value < 4
                        ? () {
                            pageController.nextPage(
                              duration: Duration(milliseconds: 300),
                              curve: Curves.easeInOut,
                            );
                          }
                        : null,
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}

class MenuItemData {
  final String title;
  final IconData icon;

  MenuItemData(this.title, this.icon);
}
