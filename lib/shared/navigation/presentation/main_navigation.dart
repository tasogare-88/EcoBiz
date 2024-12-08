import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../features/communication/presentation/communication_screen.dart';
import '../../../features/company/presentation/company_screen.dart';
import '../../../features/gacha/presentation/gacha_screen.dart';
import '../../../features/home/presentation/home_screen.dart';
import '../../../features/item/presentation/item_screen.dart';
import '../state/navigation_state.dart';

class MainNavigation extends ConsumerWidget {
  const MainNavigation({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final currentIndex = ref.watch(navigationStateProvider);

    final screenOptions = [
      const HomeScreen(),
      const GachaScreen(),
      const CompanyScreen(),
      const CommunicationScreen(),
      const ItemScreen(),
    ];

    return Scaffold(
      body: screenOptions[currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        currentIndex: currentIndex,
        onTap: (index) {
          ref.read(navigationStateProvider.notifier).changeIndex(index);
        },
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'HOME',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.casino),
            label: 'ガチャ',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.business),
            label: '経営',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.wifi),
            label: '通信',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.inventory),
            label: 'アイテム',
          ),
        ],
      ),
    );
  }
}
