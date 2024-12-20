import 'package:freezed_annotation/freezed_annotation.dart';

import '../domain/auth_user.dart';

part 'auth_state.freezed.dart';

@freezed
class AuthState with _$AuthState {
  const factory AuthState.initial() = _Initial;
  const factory AuthState.authenticated({
    required AuthUser user,
    @Default(false) bool isLoading,
    String? error,
  }) = _Authenticated;
  const factory AuthState.unauthenticated({
    @Default(false) bool isLoading,
    String? error,
  }) = _Unauthenticated;
}
