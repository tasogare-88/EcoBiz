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
      return null;
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

      final existingRecord = await getDailyRecord(userId, date);
      final earnedAmount = steps * stepsToYenRate;
      final now = DateTime.now();

      final dailyRecord = DailyRecord(
        userId: userId,
        date: date,
        steps: steps,
        earnedAmount: earnedAmount,
        totalAssets: existingRecord?.totalAssets ?? earnedAmount,
        createdAt: existingRecord?.createdAt ?? now,
        updatedAt: now,
      );

      await recordRef.set(dailyRecord.toJson());
      return dailyRecord;
    } catch (e) {
      throw Exception('歩数データの更新に失敗しました: $e');
    }
  }
}
