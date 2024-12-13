import 'package:flutter_test/flutter_test.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../../lib/features/steps/data/health_connect_preferences.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  group('HealthConnectPreferences', () {
    test('初回アクセス時はfalseを返す', () async {
      SharedPreferences.setMockInitialValues({});
      final prefs = HealthConnectPreferences();
      expect(await prefs.hasShownDialog(), false);
    });

    test('ダイアログ表示後はtrueを返す', () async {
      SharedPreferences.setMockInitialValues({});
      final prefs = HealthConnectPreferences();
      await prefs.markDialogAsShown();
      expect(await prefs.hasShownDialog(), true);
    });
  });
}
