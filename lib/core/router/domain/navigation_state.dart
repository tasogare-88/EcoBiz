import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../shared/constants/app_constants.dart';

part 'navigation_state.g.dart';

@riverpod
class NavigationState extends _$NavigationState {
  @override
  int build() {
    return AppConstants.navigationIndices['home']!;
  }

  void changeIndex(int index) {
    state = index;
  }
}
