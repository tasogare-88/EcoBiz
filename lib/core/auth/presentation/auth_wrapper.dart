import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../features/splash/presentation/splash_screen.dart';
import '../../../features/splash/presentation/splash_view_model.dart';
import '../../router/presentation/main_navigation.dart';
import 'auth_view_model.dart';
import 'sign_in_screen.dart';

class AuthWrapper extends ConsumerStatefulWidget {
  const AuthWrapper({super.key});

  @override
  ConsumerState<AuthWrapper> createState() => _AuthWrapperState();
}

class _AuthWrapperState extends ConsumerState<AuthWrapper> {
  @override
  void initState() {
    super.initState();
    _initializeApp();
  }

  Future<void> _initializeApp() async {
    await ref.read(splashViewModelProvider.notifier).initialize();
  }

  @override
  Widget build(BuildContext context) {
    final splashState = ref.watch(splashViewModelProvider);
    final authState = ref.watch(authViewModelProvider);

    // スプラッシュ画面の表示
    if (splashState.isLoading) {
      return const SplashScreen();
    }

    // 認証状態に基づく画面遷移
    return authState.maybeMap(
      authenticated: (state) => const MainNavigation(),
      orElse: () => const SignInScreen(),
    );
  }
}
