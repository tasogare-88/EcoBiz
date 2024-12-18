import 'package:freezed_annotation/freezed_annotation.dart';

part 'input_company_name_state.freezed.dart';

@freezed
class InputCompanyNameState with _$InputCompanyNameState {
  const factory InputCompanyNameState({
    @Default('') String companyName,
    @Default(false) bool isLoading,
    String? error,
  }) = _InputCompanyNameState;
}
