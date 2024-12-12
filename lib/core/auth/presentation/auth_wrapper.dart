import 'package:ecobiz/shared/navigation/presentation/main_navigation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'auth_view_model.dart';
import 'sign_in_screen.dart';

class AuthWrapper extends ConsumerWidget {
  const AuthWrapper({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final authState = ref.watch(authViewModelProvider);

    return authState.maybeMap(
      authenticated: (state) => const MainNavigation(),
      orElse: () => const SignInScreen(),
    );
  }
}
