// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'auth_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$AuthState {
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function(AuthUser user, bool isLoading, String? error)
        authenticated,
    required TResult Function(bool isLoading, String? error) unauthenticated,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function(AuthUser user, bool isLoading, String? error)?
        authenticated,
    TResult? Function(bool isLoading, String? error)? unauthenticated,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function(AuthUser user, bool isLoading, String? error)?
        authenticated,
    TResult Function(bool isLoading, String? error)? unauthenticated,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(AuthStateInitial value) initial,
    required TResult Function(AuthStateAuthenticated value) authenticated,
    required TResult Function(AuthStateUnauthenticated value) unauthenticated,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(AuthStateInitial value)? initial,
    TResult? Function(AuthStateAuthenticated value)? authenticated,
    TResult? Function(AuthStateUnauthenticated value)? unauthenticated,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(AuthStateInitial value)? initial,
    TResult Function(AuthStateAuthenticated value)? authenticated,
    TResult Function(AuthStateUnauthenticated value)? unauthenticated,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $AuthStateCopyWith<$Res> {
  factory $AuthStateCopyWith(AuthState value, $Res Function(AuthState) then) =
      _$AuthStateCopyWithImpl<$Res, AuthState>;
}

/// @nodoc
class _$AuthStateCopyWithImpl<$Res, $Val extends AuthState>
    implements $AuthStateCopyWith<$Res> {
  _$AuthStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;
}

/// @nodoc
abstract class _$$AuthStateInitialImplCopyWith<$Res> {
  factory _$$AuthStateInitialImplCopyWith(_$AuthStateInitialImpl value,
          $Res Function(_$AuthStateInitialImpl) then) =
      __$$AuthStateInitialImplCopyWithImpl<$Res>;
}

/// @nodoc
class __$$AuthStateInitialImplCopyWithImpl<$Res>
    extends _$AuthStateCopyWithImpl<$Res, _$AuthStateInitialImpl>
    implements _$$AuthStateInitialImplCopyWith<$Res> {
  __$$AuthStateInitialImplCopyWithImpl(_$AuthStateInitialImpl _value,
      $Res Function(_$AuthStateInitialImpl) _then)
      : super(_value, _then);
}

/// @nodoc

class _$AuthStateInitialImpl implements AuthStateInitial {
  const _$AuthStateInitialImpl();

  @override
  String toString() {
    return 'AuthState.initial()';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is _$AuthStateInitialImpl);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function(AuthUser user, bool isLoading, String? error)
        authenticated,
    required TResult Function(bool isLoading, String? error) unauthenticated,
  }) {
    return initial();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function(AuthUser user, bool isLoading, String? error)?
        authenticated,
    TResult? Function(bool isLoading, String? error)? unauthenticated,
  }) {
    return initial?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function(AuthUser user, bool isLoading, String? error)?
        authenticated,
    TResult Function(bool isLoading, String? error)? unauthenticated,
    required TResult orElse(),
  }) {
    if (initial != null) {
      return initial();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(AuthStateInitial value) initial,
    required TResult Function(AuthStateAuthenticated value) authenticated,
    required TResult Function(AuthStateUnauthenticated value) unauthenticated,
  }) {
    return initial(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(AuthStateInitial value)? initial,
    TResult? Function(AuthStateAuthenticated value)? authenticated,
    TResult? Function(AuthStateUnauthenticated value)? unauthenticated,
  }) {
    return initial?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(AuthStateInitial value)? initial,
    TResult Function(AuthStateAuthenticated value)? authenticated,
    TResult Function(AuthStateUnauthenticated value)? unauthenticated,
    required TResult orElse(),
  }) {
    if (initial != null) {
      return initial(this);
    }
    return orElse();
  }
}

abstract class AuthStateInitial implements AuthState {
  const factory AuthStateInitial() = _$AuthStateInitialImpl;
}

/// @nodoc
abstract class _$$AuthStateAuthenticatedImplCopyWith<$Res> {
  factory _$$AuthStateAuthenticatedImplCopyWith(
          _$AuthStateAuthenticatedImpl value,
          $Res Function(_$AuthStateAuthenticatedImpl) then) =
      __$$AuthStateAuthenticatedImplCopyWithImpl<$Res>;
  @useResult
  $Res call({AuthUser user, bool isLoading, String? error});

  $AuthUserCopyWith<$Res> get user;
}

/// @nodoc
class __$$AuthStateAuthenticatedImplCopyWithImpl<$Res>
    extends _$AuthStateCopyWithImpl<$Res, _$AuthStateAuthenticatedImpl>
    implements _$$AuthStateAuthenticatedImplCopyWith<$Res> {
  __$$AuthStateAuthenticatedImplCopyWithImpl(
      _$AuthStateAuthenticatedImpl _value,
      $Res Function(_$AuthStateAuthenticatedImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? user = null,
    Object? isLoading = null,
    Object? error = freezed,
  }) {
    return _then(_$AuthStateAuthenticatedImpl(
      user: null == user
          ? _value.user
          : user // ignore: cast_nullable_to_non_nullable
              as AuthUser,
      isLoading: null == isLoading
          ? _value.isLoading
          : isLoading // ignore: cast_nullable_to_non_nullable
              as bool,
      error: freezed == error
          ? _value.error
          : error // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }

  @override
  @pragma('vm:prefer-inline')
  $AuthUserCopyWith<$Res> get user {
    return $AuthUserCopyWith<$Res>(_value.user, (value) {
      return _then(_value.copyWith(user: value));
    });
  }
}

/// @nodoc

class _$AuthStateAuthenticatedImpl implements AuthStateAuthenticated {
  const _$AuthStateAuthenticatedImpl(
      {required this.user, this.isLoading = false, this.error});

  @override
  final AuthUser user;
  @override
  @JsonKey()
  final bool isLoading;
  @override
  final String? error;

  @override
  String toString() {
    return 'AuthState.authenticated(user: $user, isLoading: $isLoading, error: $error)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$AuthStateAuthenticatedImpl &&
            (identical(other.user, user) || other.user == user) &&
            (identical(other.isLoading, isLoading) ||
                other.isLoading == isLoading) &&
            (identical(other.error, error) || other.error == error));
  }

  @override
  int get hashCode => Object.hash(runtimeType, user, isLoading, error);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$AuthStateAuthenticatedImplCopyWith<_$AuthStateAuthenticatedImpl>
      get copyWith => __$$AuthStateAuthenticatedImplCopyWithImpl<
          _$AuthStateAuthenticatedImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function(AuthUser user, bool isLoading, String? error)
        authenticated,
    required TResult Function(bool isLoading, String? error) unauthenticated,
  }) {
    return authenticated(user, isLoading, error);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function(AuthUser user, bool isLoading, String? error)?
        authenticated,
    TResult? Function(bool isLoading, String? error)? unauthenticated,
  }) {
    return authenticated?.call(user, isLoading, error);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function(AuthUser user, bool isLoading, String? error)?
        authenticated,
    TResult Function(bool isLoading, String? error)? unauthenticated,
    required TResult orElse(),
  }) {
    if (authenticated != null) {
      return authenticated(user, isLoading, error);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(AuthStateInitial value) initial,
    required TResult Function(AuthStateAuthenticated value) authenticated,
    required TResult Function(AuthStateUnauthenticated value) unauthenticated,
  }) {
    return authenticated(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(AuthStateInitial value)? initial,
    TResult? Function(AuthStateAuthenticated value)? authenticated,
    TResult? Function(AuthStateUnauthenticated value)? unauthenticated,
  }) {
    return authenticated?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(AuthStateInitial value)? initial,
    TResult Function(AuthStateAuthenticated value)? authenticated,
    TResult Function(AuthStateUnauthenticated value)? unauthenticated,
    required TResult orElse(),
  }) {
    if (authenticated != null) {
      return authenticated(this);
    }
    return orElse();
  }
}

abstract class AuthStateAuthenticated implements AuthState {
  const factory AuthStateAuthenticated(
      {required final AuthUser user,
      final bool isLoading,
      final String? error}) = _$AuthStateAuthenticatedImpl;

  AuthUser get user;
  bool get isLoading;
  String? get error;
  @JsonKey(ignore: true)
  _$$AuthStateAuthenticatedImplCopyWith<_$AuthStateAuthenticatedImpl>
      get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$AuthStateUnauthenticatedImplCopyWith<$Res> {
  factory _$$AuthStateUnauthenticatedImplCopyWith(
          _$AuthStateUnauthenticatedImpl value,
          $Res Function(_$AuthStateUnauthenticatedImpl) then) =
      __$$AuthStateUnauthenticatedImplCopyWithImpl<$Res>;
  @useResult
  $Res call({bool isLoading, String? error});
}

/// @nodoc
class __$$AuthStateUnauthenticatedImplCopyWithImpl<$Res>
    extends _$AuthStateCopyWithImpl<$Res, _$AuthStateUnauthenticatedImpl>
    implements _$$AuthStateUnauthenticatedImplCopyWith<$Res> {
  __$$AuthStateUnauthenticatedImplCopyWithImpl(
      _$AuthStateUnauthenticatedImpl _value,
      $Res Function(_$AuthStateUnauthenticatedImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? isLoading = null,
    Object? error = freezed,
  }) {
    return _then(_$AuthStateUnauthenticatedImpl(
      isLoading: null == isLoading
          ? _value.isLoading
          : isLoading // ignore: cast_nullable_to_non_nullable
              as bool,
      error: freezed == error
          ? _value.error
          : error // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc

class _$AuthStateUnauthenticatedImpl implements AuthStateUnauthenticated {
  const _$AuthStateUnauthenticatedImpl({this.isLoading = false, this.error});

  @override
  @JsonKey()
  final bool isLoading;
  @override
  final String? error;

  @override
  String toString() {
    return 'AuthState.unauthenticated(isLoading: $isLoading, error: $error)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$AuthStateUnauthenticatedImpl &&
            (identical(other.isLoading, isLoading) ||
                other.isLoading == isLoading) &&
            (identical(other.error, error) || other.error == error));
  }

  @override
  int get hashCode => Object.hash(runtimeType, isLoading, error);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$AuthStateUnauthenticatedImplCopyWith<_$AuthStateUnauthenticatedImpl>
      get copyWith => __$$AuthStateUnauthenticatedImplCopyWithImpl<
          _$AuthStateUnauthenticatedImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function(AuthUser user, bool isLoading, String? error)
        authenticated,
    required TResult Function(bool isLoading, String? error) unauthenticated,
  }) {
    return unauthenticated(isLoading, error);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function(AuthUser user, bool isLoading, String? error)?
        authenticated,
    TResult? Function(bool isLoading, String? error)? unauthenticated,
  }) {
    return unauthenticated?.call(isLoading, error);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function(AuthUser user, bool isLoading, String? error)?
        authenticated,
    TResult Function(bool isLoading, String? error)? unauthenticated,
    required TResult orElse(),
  }) {
    if (unauthenticated != null) {
      return unauthenticated(isLoading, error);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(AuthStateInitial value) initial,
    required TResult Function(AuthStateAuthenticated value) authenticated,
    required TResult Function(AuthStateUnauthenticated value) unauthenticated,
  }) {
    return unauthenticated(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(AuthStateInitial value)? initial,
    TResult? Function(AuthStateAuthenticated value)? authenticated,
    TResult? Function(AuthStateUnauthenticated value)? unauthenticated,
  }) {
    return unauthenticated?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(AuthStateInitial value)? initial,
    TResult Function(AuthStateAuthenticated value)? authenticated,
    TResult Function(AuthStateUnauthenticated value)? unauthenticated,
    required TResult orElse(),
  }) {
    if (unauthenticated != null) {
      return unauthenticated(this);
    }
    return orElse();
  }
}

abstract class AuthStateUnauthenticated implements AuthState {
  const factory AuthStateUnauthenticated(
      {final bool isLoading,
      final String? error}) = _$AuthStateUnauthenticatedImpl;

  bool get isLoading;
  String? get error;
  @JsonKey(ignore: true)
  _$$AuthStateUnauthenticatedImplCopyWith<_$AuthStateUnauthenticatedImpl>
      get copyWith => throw _privateConstructorUsedError;
}
