import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'health_connect_preferences.g.dart';

@riverpod
class HealthConnectPreferences extends _$HealthConnectPreferences {
  static const String _hasShownDialogKey = 'has_shown_health_connect_dialog';

  @override
  FutureOr<void> build() {}

  Future<bool> hasShownDialog() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getBool(_hasShownDialogKey) ?? false;
  }

  Future<void> markDialogAsShown() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool(_hasShownDialogKey, true);
  }
}
