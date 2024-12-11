import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../core/providers/firebase_providers.dart';
import '../domain/daily_record.dart';

part 'steps_repository.g.dart';

@riverpod
class StepsRepository extends _$StepsRepository {
  @override
  FutureOr<void> build() {}

  Future<DailyRecord?> getDailyRecord(String userId, String date) async {
    try {
      final firestore = ref.read(firestoreProvider);
      final doc = await firestore
          .collection('users')
          .doc(userId)
          .collection('dailyRecords')
          .doc(date)
          .get();

      if (!doc.exists) return null;
      return DailyRecord.fromJson(doc.data()!);
    } catch (e) {
      throw Exception('歩数データの取得に失敗しました: $e');
    }
  }

  Future<DailyRecord> updateSteps(
      String userId, String date, int steps, int stepsToYenRate) async {
    try {
      final firestore = ref.read(firestoreProvider);
      final recordRef = firestore
          .collection('users')
          .doc(userId)
          .collection('dailyRecords')
          .doc(date);

      final earnedAmount = steps * stepsToYenRate;
      final now = DateTime.now();

      final dailyRecord = DailyRecord(
        userId: userId,
        date: date,
        steps: steps,
        earnedAmount: earnedAmount,
        totalAssets: earnedAmount, // MVPでは収益=総資産
        createdAt: now,
        updatedAt: now,
      );

      await recordRef.set(dailyRecord.toJson());
      return dailyRecord;
    } catch (e) {
      throw Exception('歩数データの更新に失敗しました: $e');
    }
  }
}
