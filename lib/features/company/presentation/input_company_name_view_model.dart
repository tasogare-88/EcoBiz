import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../shared/constants/company_error_messages.dart';
import '../domain/input_company_name_state.dart';

part 'input_company_name_view_model.g.dart';

@riverpod
class InputCompanyNameViewModel extends _$InputCompanyNameViewModel {
  @override
  InputCompanyNameState build() {
    return const InputCompanyNameState();
  }

  void updateCompanyName(String name) {
    if (name.isEmpty) {
      state = state.copyWith(
        error: CompanyErrorMessages.invalidCompanyName,
        companyName: '',
      );
      return;
    }
    state = state.copyWith(companyName: name, error: null);
  }

  bool isValid() {
    return state.companyName.isNotEmpty && state.error == null;
  }
}
