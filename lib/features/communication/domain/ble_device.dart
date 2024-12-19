import 'package:freezed_annotation/freezed_annotation.dart';

part 'ble_device.freezed.dart';
part 'ble_device.g.dart';

@freezed
class BLEDevice with _$BLEDevice {
  const factory BLEDevice({
    required String id,
    required String userId,
    required String name,
    required int steps,
  }) = _BLEDevice;

  factory BLEDevice.fromJson(Map<String, dynamic> json) =>
      _$BLEDeviceFromJson(json);
}
