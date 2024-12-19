import 'package:freezed_annotation/freezed_annotation.dart';

part 'select_company_state.freezed.dart';

@freezed
class SelectCompanyState with _$SelectCompanyState {
  const factory SelectCompanyState({
    @Default('') String selectedGenre,
    @Default(false) bool isLoading,
    String? error,
  }) = _SelectCompanyState;
}
