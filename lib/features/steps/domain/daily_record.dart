import 'package:freezed_annotation/freezed_annotation.dart';

part 'daily_record.freezed.dart';
part 'daily_record.g.dart';

@freezed
class DailyRecord with _$DailyRecord {
  const factory DailyRecord({
    required String userId,
    required String date,
    required int steps,
    required int earnedAmount,
    required int totalAssets,
    required DateTime createdAt,
    required DateTime updatedAt,
  }) = _DailyRecord;

  factory DailyRecord.fromJson(Map<String, dynamic> json) =>
      _$DailyRecordFromJson(json);
}
