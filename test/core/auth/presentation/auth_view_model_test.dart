import 'dart:async';

import 'package:ecobiz/core/auth/data/auth_repository.dart';
import 'package:ecobiz/core/auth/domain/auth_user.dart';
import 'package:ecobiz/core/auth/presentation/auth_view_model.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:riverpod/riverpod.dart';

void main() {
  late ProviderContainer container;

  setUp(() {
    container = ProviderContainer(
      overrides: [
        authRepositoryProvider.overrideWith(
          () => FakeAuthRepository(),
        ),
      ],
    );
  });

  tearDown(() {
    container.dispose();
  });

  group('AuthViewModel', () {
    test('initial state', () {
      final authState = container.read(authViewModelProvider);

      expect(authState.isLoading, false);
      expect(authState.error, null);
      expect(authState.user, null);
    });

    test('signIn - success', () async {
      final authViewModel = container.read(authViewModelProvider.notifier);
      await authViewModel.signIn(
        email: 'test@example.com',
        password: 'password123',
      );

      final state = container.read(authViewModelProvider);
      expect(state.isLoading, false);
      expect(state.error, null);
    });

    test('signIn - failure', () async {
      final authViewModel = container.read(authViewModelProvider.notifier);
      await authViewModel.signIn(
        email: 'test@example.com',
        password: 'wrongPassword',
      );

      final state = container.read(authViewModelProvider);
      expect(state.isLoading, false);
      expect(state.error, isNotNull);
    });
  });
}

class FakeAuthRepository extends AutoDisposeAsyncNotifier<void>
    implements AuthRepository {
  @override
  FutureOr<void> build() async {}

  @override
  Future<AuthUser> signIn(
      {required String email, required String password}) async {
    if (password == 'wrongPassword') {
      throw FirebaseAuthException(code: 'wrong-password');
    }
    return const AuthUser(id: 'test-id', email: 'test@example.com');
  }

  @override
  Future<AuthUser> signUp(
      {required String email, required String password}) async {
    return const AuthUser(id: 'test-id', email: 'test@example.com');
  }

  @override
  Future<void> signOut() async {}
}
