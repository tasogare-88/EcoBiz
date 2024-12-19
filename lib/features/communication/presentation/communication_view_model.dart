import 'dart:async';

import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../data/ble_repository.dart';
import '../domain/communication_state.dart';

part 'communication_view_model.g.dart';

@riverpod
class CommunicationViewModel extends _$CommunicationViewModel {
  @override
  CommunicationState build() {
    _initialize();
    return const CommunicationState();
  }

  Future<void> _initialize() async {
    try {
      final bleRepo = ref.read(bleRepositoryProvider.notifier);
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
        error: 'Bluetoothの初期化に失敗しました: ${e.toString()}',
        isBluetoothAvailable: false,
      );
    }
  }

  Future<void> _startScanning() async {
    if (state.isScanning) return;

    state = state.copyWith(isScanning: true);
    final bleRepo = ref.read(bleRepositoryProvider.notifier);

    try {
      await bleRepo.startScan();
      bleRepo.startListening();
    } catch (e) {
      state = state.copyWith(
        error: 'Bluetoothのスキャンに失敗しました: ${e.toString()}',
        isScanning: false,
      );
    }
  }

  Future<void> refreshDevices() async {
    await _startScanning();
  }
}
