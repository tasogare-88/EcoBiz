import 'package:ecobiz/core/auth/data/auth_repository.dart';
import 'package:ecobiz/core/auth/domain/auth_user.dart';
import 'package:ecobiz/core/auth/presentation/auth_view_model.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:riverpod/riverpod.dart';

import '../../../../lib/shared/constants/auth_error_messages.dart';

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

      expect(
        authState.maybeMap(
          initial: (_) => true,
          orElse: () => false,
        ),
        true,
      );
    });

    test('signIn - success', () async {
      final authViewModel = container.read(authViewModelProvider.notifier);
      await authViewModel.signIn(
        email: 'test@example.com',
        password: 'password123',
      );

      final state = container.read(authViewModelProvider);
      expect(
        state.maybeMap(
          authenticated: (state) => !state.isLoading && state.error == null,
          orElse: () => false,
        ),
        true,
      );
    });

    test('signIn - failure', () async {
      final authViewModel = container.read(authViewModelProvider.notifier);
      await authViewModel.signIn(
        email: 'test@example.com',
        password: 'wrongPassword',
      );

      final state = container.read(authViewModelProvider);
      expect(
        state.maybeMap(
          unauthenticated: (state) => !state.isLoading && state.error != null,
          orElse: () => false,
        ),
        true,
      );
    });
  });
}

class FakeAuthRepository extends AuthRepository {
  @override
  Future<AuthUser> signIn(
      {required String email, required String password}) async {
    if (password == 'wrongPassword') {
      throw Exception(AuthErrorMessages.wrongPassword);
    }
    return AuthUser(
      id: 'test-id',
      email: email,
    );
  }

  @override
  Future<AuthUser> signUp(
      {required String email, required String password}) async {
    return AuthUser(
      id: 'test-id',
      email: email,
    );
  }

  @override
  Future<void> signOut() async {}

  @override
  Future<AuthUser> signInWithGoogle() async {
    return AuthUser(
      id: 'test-id',
      email: 'test@example.com',
    );
  }
}
