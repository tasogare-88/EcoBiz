import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../data/company_repository.dart';
import '../domain/company.dart';
import '../domain/company_state.dart';

part 'company_view_model.g.dart';

@riverpod
class CompanyViewModel extends _$CompanyViewModel {
  @override
  CompanyState build() {
    return const CompanyState();
  }

  Future<void> createCompany({
    required String userId,
    required String name,
    required CompanyGenre genre,
  }) async {
    state = state.copyWith(isLoading: true, error: null);

    try {
      final company =
          await ref.read(companyRepositoryProvider.notifier).createCompany(
                userId: userId,
                name: name,
                genre: genre,
              );

      state = state.copyWith(company: company, isLoading: false);
    } catch (e) {
      state = state.copyWith(error: e.toString(), isLoading: false);
    }
  }

  Future<void> loadCompany(String userId) async {
    state = state.copyWith(isLoading: true, error: null);

    try {
      final company =
          await ref.read(companyRepositoryProvider.notifier).getCompany(userId);
      state = state.copyWith(company: company, isLoading: false);
    } catch (e) {
      state = state.copyWith(error: e.toString(), isLoading: false);
    }
  }
}
