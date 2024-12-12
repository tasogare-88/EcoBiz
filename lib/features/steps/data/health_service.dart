import 'dart:io';

import 'package:health/health.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:url_launcher/url_launcher.dart';

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
          // Health Connectがインストールされていない場合
          final installed = await _requestInstallHealthConnect();
          if (!installed) return false;
        }
      }

      return await requestAuthorization();
    } catch (e) {
      throw Exception('ヘルスケアの認証に失敗しました: $e');
    }
  }

  Future<bool> _requestInstallHealthConnect() async {
    const playStoreUrl =
        'market://details?id=com.google.android.apps.healthdata';
    final canLaunch = await canLaunchUrl(Uri.parse(playStoreUrl));

    if (canLaunch) {
      await launchUrl(
        Uri.parse(playStoreUrl),
        mode: LaunchMode.externalApplication,
      );
      // NOTE: ユーザーがインストールを完了するまで待機する必要があるため、
      // 実際のアプリではダイアログなどでユーザーに確認を求めることを推奨
      return true;
    }

    throw Exception('Health Connectのインストールページを開けませんでした');
  }

  Future<bool> requestAuthorization() async {
    try {
      return await health.requestAuthorization(_types);
    } catch (e) {
      throw Exception('ヘルスケアの認証に失敗しました: $e');
    }
  }

  Future<int> getTodaySteps() async {
    try {
      final now = DateTime.now();
      final midnight = DateTime(now.year, now.month, now.day);

      final steps = await health.getTotalStepsInInterval(midnight, now);
      return steps?.toInt() ?? 0;
    } catch (e) {
      throw Exception('歩数の取得に失敗しました: $e');
    }
  }
}
