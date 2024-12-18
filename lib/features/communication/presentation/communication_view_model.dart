import 'dart:async';

import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../data/ble_repository.dart';
import './communication_state.dart';

part 'communication_view_model.g.dart';

@riverpod
class CommunicationViewModel extends _$CommunicationViewModel {
  @override
  CommunicationState build() {
    _initialize();
    return const CommunicationState();
  }

  Future<void> _initialize() async {
    final bleRepo = ref.read(bleRepositoryProvider.notifier);
    final isAvailable = await bleRepo.isBluetoothAvailable();

    state = state.copyWith(isBluetoothAvailable: isAvailable);
    if (isAvailable) {
      _startScanning();
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
