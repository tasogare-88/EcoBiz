// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'select_company_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$SelectCompanyState {
  String get selectedGenre => throw _privateConstructorUsedError;
  bool get isLoading => throw _privateConstructorUsedError;
  String? get error => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $SelectCompanyStateCopyWith<SelectCompanyState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $SelectCompanyStateCopyWith<$Res> {
  factory $SelectCompanyStateCopyWith(
          SelectCompanyState value, $Res Function(SelectCompanyState) then) =
      _$SelectCompanyStateCopyWithImpl<$Res, SelectCompanyState>;
  @useResult
  $Res call({String selectedGenre, bool isLoading, String? error});
}

/// @nodoc
class _$SelectCompanyStateCopyWithImpl<$Res, $Val extends SelectCompanyState>
    implements $SelectCompanyStateCopyWith<$Res> {
  _$SelectCompanyStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? selectedGenre = null,
    Object? isLoading = null,
    Object? error = freezed,
  }) {
    return _then(_value.copyWith(
      selectedGenre: null == selectedGenre
          ? _value.selectedGenre
          : selectedGenre // ignore: cast_nullable_to_non_nullable
              as String,
      isLoading: null == isLoading
          ? _value.isLoading
          : isLoading // ignore: cast_nullable_to_non_nullable
              as bool,
      error: freezed == error
          ? _value.error
          : error // ignore: cast_nullable_to_non_nullable
              as String?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$SelectCompanyStateImplCopyWith<$Res>
    implements $SelectCompanyStateCopyWith<$Res> {
  factory _$$SelectCompanyStateImplCopyWith(_$SelectCompanyStateImpl value,
          $Res Function(_$SelectCompanyStateImpl) then) =
      __$$SelectCompanyStateImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String selectedGenre, bool isLoading, String? error});
}

/// @nodoc
class __$$SelectCompanyStateImplCopyWithImpl<$Res>
    extends _$SelectCompanyStateCopyWithImpl<$Res, _$SelectCompanyStateImpl>
    implements _$$SelectCompanyStateImplCopyWith<$Res> {
  __$$SelectCompanyStateImplCopyWithImpl(_$SelectCompanyStateImpl _value,
      $Res Function(_$SelectCompanyStateImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? selectedGenre = null,
    Object? isLoading = null,
    Object? error = freezed,
  }) {
    return _then(_$SelectCompanyStateImpl(
      selectedGenre: null == selectedGenre
          ? _value.selectedGenre
          : selectedGenre // ignore: cast_nullable_to_non_nullable
              as String,
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

class _$SelectCompanyStateImpl implements _SelectCompanyState {
  const _$SelectCompanyStateImpl(
      {this.selectedGenre = '', this.isLoading = false, this.error});

  @override
  @JsonKey()
  final String selectedGenre;
  @override
  @JsonKey()
  final bool isLoading;
  @override
  final String? error;

  @override
  String toString() {
    return 'SelectCompanyState(selectedGenre: $selectedGenre, isLoading: $isLoading, error: $error)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$SelectCompanyStateImpl &&
            (identical(other.selectedGenre, selectedGenre) ||
                other.selectedGenre == selectedGenre) &&
            (identical(other.isLoading, isLoading) ||
                other.isLoading == isLoading) &&
            (identical(other.error, error) || other.error == error));
  }

  @override
  int get hashCode => Object.hash(runtimeType, selectedGenre, isLoading, error);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$SelectCompanyStateImplCopyWith<_$SelectCompanyStateImpl> get copyWith =>
      __$$SelectCompanyStateImplCopyWithImpl<_$SelectCompanyStateImpl>(
          this, _$identity);
}

abstract class _SelectCompanyState implements SelectCompanyState {
  const factory _SelectCompanyState(
      {final String selectedGenre,
      final bool isLoading,
      final String? error}) = _$SelectCompanyStateImpl;

  @override
  String get selectedGenre;
  @override
  bool get isLoading;
  @override
  String? get error;
  @override
  @JsonKey(ignore: true)
  _$$SelectCompanyStateImplCopyWith<_$SelectCompanyStateImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
