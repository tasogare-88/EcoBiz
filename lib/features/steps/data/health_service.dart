import 'package:health/health.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'health_service.g.dart';

@riverpod
class HealthService extends _$HealthService {
  static const List<HealthDataType> _types = [HealthDataType.STEPS];
  HealthFactory health = HealthFactory();

  @override
  FutureOr<void> build() {}

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
