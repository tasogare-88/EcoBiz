import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../shared/constants/company_constants.dart';
import '../domain/select_company_state.dart';

part 'select_company_view_model.g.dart';

@riverpod
class SelectCompanyViewModel extends _$SelectCompanyViewModel {
  @override
  SelectCompanyState build() {
    return const SelectCompanyState();
  }

  void selectGenre(String genre) {
    if (!CompanyConstants.genres.containsKey(genre)) {
      state = state.copyWith(error: '無効なジャンルが選択されました');
      return;
    }
    state = state.copyWith(selectedGenre: genre, error: null);
  }

  void resetSelection() {
    state = const SelectCompanyState();
  }

  String? getSelectedGenreName() {
    return CompanyConstants.genres[state.selectedGenre];
  }
}
