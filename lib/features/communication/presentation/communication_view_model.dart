import 'dart:async';

import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../mock/data/mock_ble_repository.dart';
import '../data/ble_repository.dart';
import '../domain/ble_interface.dart';
import '../domain/communication_state.dart';

part 'communication_view_model.g.dart';

@riverpod
class CommunicationViewModel extends _$CommunicationViewModel {
  @override
  CommunicationState build() {
    if (const bool.fromEnvironment('DEBUG_MODE', defaultValue: true)) {
      final mockRepo = MockBleRepository();
      return CommunicationState(
        devices: mockRepo.mockDevices,
        isBluetoothAvailable: true,
        isScanning: false,
      );
    }
    _initialize();
    return const CommunicationState();
  }

  Future<void> _initialize() async {
    if (!const bool.fromEnvironment('DEBUG_MODE', defaultValue: true)) {
      try {
        final bleRepo = ref.read(bleRepositoryProvider) as BleInterface;
        final isAvailable = await bleRepo.isBluetoothAvailable();

        if (!isAvailable) {
          state = state.copyWith(
            error: 'Bluetoothが無効です。設定から有効にしてください。',
            isBluetoothAvailable: false,
          );
          return;
        }

        state = state.copyWith(isBluetoothAvailable: true);
        await _startScanning();
      } catch (e) {
        state = state.copyWith(
          error: e.toString(),
          isBluetoothAvailable: false,
        );
      }
    }
  }

  Future<void> _startScanning() async {
    if (state.isScanning) return;

    state = state.copyWith(isScanning: true);
    final bleRepo = const bool.fromEnvironment('DEBUG_MODE', defaultValue: true)
        ? MockBleRepository()
        : (ref.read(bleRepositoryProvider) as BleInterface);

    try {
      if (const bool.fromEnvironment('DEBUG_MODE', defaultValue: true)) {
        state = state.copyWith(
          devices: (bleRepo as MockBleRepository).mockDevices,
          isScanning: false,
        );
      } else {
        await bleRepo.startScan();
        bleRepo.startListening();
      }
    } catch (e) {
      state = state.copyWith(
        error: 'Bluetoothのスキャンに失敗しました: ${e.toString()}',
        isScanning: false,
      );
    }
  }

  Future<void> refreshDevices() async {
    if (const bool.fromEnvironment('DEBUG_MODE', defaultValue: true)) {
      final mockRepo = MockBleRepository();
      state = state.copyWith(
        devices: mockRepo.mockDevices,
        error: null,
      );
      return;
    }
    state = state.copyWith(error: null);
    await _startScanning();
  }
}
