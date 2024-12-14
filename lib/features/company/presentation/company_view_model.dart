import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../shared/constants/company_constants.dart';
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

  Future<void> updateCompanyAssets(String userId, int newTotalAssets) async {
    state = state.copyWith(isLoading: true, error: null);

    try {
      final updatedCompany = await ref
          .read(companyRepositoryProvider.notifier)
          .updateCompanyRankAndRate(userId, newTotalAssets);

      state = state.copyWith(company: updatedCompany, isLoading: false);
    } catch (e) {
      state = state.copyWith(error: e.toString(), isLoading: false);
    }
  }

  // 現在の総資産を取得
  int getCurrentTotalAssets() {
    return state.company?.totalAssets ?? 0;
  }

  // 現在の歩数換算レートを取得
  int getCurrentStepsToYenRate() {
    return state.company?.stepsToYenRate ??
        CompanyConstants.initialStepsToYenRate;
  }

  // 会社のランクを取得
  CompanyRank? getCurrentRank() {
    return state.company?.rank;
  }
}
