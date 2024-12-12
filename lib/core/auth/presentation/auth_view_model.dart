import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../data/auth_repository.dart';
import '../domain/auth_state.dart';

part 'auth_view_model.g.dart';

@riverpod
class AuthViewModel extends _$AuthViewModel {
  @override
  AuthState build() {
    return const AuthState.initial();
  }

  Future<void> signIn({
    required String email,
    required String password,
  }) async {
    state = const AuthState.unauthenticated(isLoading: true);

    try {
      final user = await ref.read(authRepositoryProvider.notifier).signIn(
            email: email,
            password: password,
          );
      state = AuthState.authenticated(user: user, isLoading: false);
    } catch (e) {
      state = AuthState.unauthenticated(
        isLoading: false,
        error: e.toString(),
      );
    }
  }

  Future<void> signUp({
    required String email,
    required String password,
  }) async {
    state = const AuthState.unauthenticated(isLoading: true);

    try {
      final user = await ref.read(authRepositoryProvider.notifier).signUp(
            email: email,
            password: password,
          );
      state = AuthState.authenticated(user: user, isLoading: false);
    } catch (e) {
      state = AuthState.unauthenticated(
        isLoading: false,
        error: e.toString(),
      );
    }
  }

  Future<void> signOut() async {
    state = const AuthState.unauthenticated(isLoading: true);

    try {
      await ref.read(authRepositoryProvider.notifier).signOut();
      state = const AuthState.initial();
    } catch (e) {
      state = AuthState.unauthenticated(
        isLoading: false,
        error: e.toString(),
      );
    }
  }
}
