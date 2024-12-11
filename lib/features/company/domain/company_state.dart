import 'package:freezed_annotation/freezed_annotation.dart';

import 'company.dart';

part 'company_state.freezed.dart';

@freezed
class CompanyState with _$CompanyState {
  const factory CompanyState({
    Company? company,
    @Default(false) bool isLoading,
    String? error,
  }) = _CompanyState;
}
