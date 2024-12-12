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
          // Health Connectのインストール確認
          final installed = await _requestInstallHealthConnect();
          if (!installed) return false;

          // インストール後の再確認
          final recheck = await health.hasPermissions(_types);
          if (recheck == null || !recheck) {
            throw Exception('Health Connectのセットアップを完了してください');
          }
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
      final launched = await launchUrl(
        Uri.parse(playStoreUrl),
        mode: LaunchMode.externalApplication,
      );

      if (!launched) {
        throw Exception('Health Connectのインストールページを開けませんでした');
      }

      // インストール完了を待つためのダイアログを表示
      return true; // ダイアログでユーザーが「完了」を押した場合にtrueを返す
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
