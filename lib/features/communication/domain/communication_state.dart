import 'package:freezed_annotation/freezed_annotation.dart';

import 'battle_device.dart';

part 'communication_state.freezed.dart';

@freezed
class CommunicationState with _$CommunicationState {
  const factory CommunicationState({
    @Default([]) List<BattleDevice> devices,
    @Default(false) bool isScanning,
    @Default(false) bool isBluetoothAvailable,
    String? error,
  }) = _CommunicationState;
}
