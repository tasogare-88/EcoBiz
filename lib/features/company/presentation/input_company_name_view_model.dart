import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../data/company_repository.dart';
import '../domain/company.dart';
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
        error: '会社名を入力してください',
        companyName: '',
      );
      return;
    }
    state = state.copyWith(companyName: name, error: null);
  }

  Future<void> createCompany({
    required String userId,
    required String genre,
  }) async {
    if (state.companyName.isEmpty) {
      state = state.copyWith(error: '会社名を入力してください');
      return;
    }

    state = state.copyWith(isLoading: true, error: null);

    try {
      await ref.read(companyRepositoryProvider.notifier).createCompany(
            userId: userId,
            name: state.companyName,
            genre: CompanyGenre.values.firstWhere(
              (e) => e.name == genre,
              orElse: () => CompanyGenre.it,
            ),
          );
      state = state.copyWith(isLoading: false);
    } catch (e) {
      state = state.copyWith(
        isLoading: false,
        error: '会社の作成に失敗しました',
      );
    }
  }
}
