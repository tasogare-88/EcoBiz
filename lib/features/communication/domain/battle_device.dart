import 'package:freezed_annotation/freezed_annotation.dart';

part 'battle_device.freezed.dart';
part 'battle_device.g.dart';

@freezed
class BattleDevice with _$BattleDevice {
  const factory BattleDevice({
    required String id,
    required String userId,
    required String name,
    required int steps,
  }) = _BattleDevice;

  factory BattleDevice.fromJson(Map<String, dynamic> json) =>
      _$BattleDeviceFromJson(json);
}
