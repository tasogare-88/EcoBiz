import 'dart:io';

import 'package:health/health.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../shared/constants/health_error_messages.dart';
import '../../../shared/navigation/navigation_service.dart';
import '../../steps/presentation/steps_screen.dart';
import 'health_connect_preferences.dart';

part 'health_service.g.dart';

@riverpod
class HealthService extends _$HealthService {
  static const List<HealthDataType> _types = [HealthDataType.STEPS];
  HealthFactory health = HealthFactory();

  @override
  FutureOr<void> build() {}

  Future<bool> checkAndRequestAuthorization() async {
    try {
      if (Platform.isAndroid) {
        final hasPermissions = await health.hasPermissions(_types);
        if (hasPermissions == null || !hasPermissions) {
          // Health Connectのインストール確認
          final installed = await _requestInstallHealthConnect();
          if (!installed) {
            throw Exception(HealthErrorMessages.healthConnectNotInstalled);
          }

          // インストール後の再確認
          final recheck = await health.hasPermissions(_types);
          if (recheck == null || !recheck) {
            throw Exception(HealthErrorMessages.healthConnectSetupIncomplete);
          }
        }
      }

      final authorized = await requestAuthorization();
      if (!authorized) {
        throw Exception(HealthErrorMessages.authorizationDenied);
      }
      return true;
    } catch (e) {
      if (e is Exception) {
        rethrow;
      }
      throw Exception(HealthErrorMessages.stepsRetrievalFailed);
    }
  }

  Future<bool> _requestInstallHealthConnect() async {
    const playStoreUrl =
        'market://details?id=com.google.android.apps.healthdata';
    final canLaunch = await canLaunchUrl(Uri.parse(playStoreUrl));

    if (canLaunch) {
      final prefs = ref.read(healthConnectPreferencesProvider.notifier);
      final hasShown = await prefs.hasShownDialog();

      if (!hasShown) {
        // インストール確認ダイアログを表示
        final shouldInstall =
            await showHealthConnectInstallDialog(navigatorKey.currentContext!);

        await prefs.markDialogAsShown();

        if (shouldInstall == true) {
          final launched = await launchUrl(
            Uri.parse(playStoreUrl),
            mode: LaunchMode.externalApplication,
          );

          if (!launched) {
            throw Exception(HealthErrorMessages.healthConnectInstallFailed);
          }
          return true;
        }
        return false;
      }
      return false;
    }

    throw Exception(HealthErrorMessages.healthConnectSetupIncomplete);
  }

  Future<bool> requestAuthorization() async {
    try {
      return await health.requestAuthorization(_types);
    } catch (e) {
      throw Exception(HealthErrorMessages.authorizationDenied);
    }
  }

  Future<int> getTodaySteps() async {
    try {
      final now = DateTime.now();
      final midnight = DateTime(now.year, now.month, now.day);

      final steps = await health.getTotalStepsInInterval(midnight, now);
      return steps?.toInt() ?? 0;
    } catch (e) {
      throw Exception(HealthErrorMessages.stepsRetrievalFailed);
    }
  }
}
