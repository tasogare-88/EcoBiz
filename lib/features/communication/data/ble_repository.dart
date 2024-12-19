import 'package:flutter_blue_plus/flutter_blue_plus.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import './models/battle_device.dart';

part 'ble_repository.g.dart';

@riverpod
class BleRepository extends _$BleRepository {
  @override
  List<BattleDevice> build() {
    return [];
  }

  Future<bool> isBluetoothAvailable() async {
    try {
      final adapterState = await FlutterBluePlus.adapterState.first;
      return adapterState == BluetoothAdapterState.on;
    } catch (e) {
      return false;
    }
  }

  Future<void> startScan() async {
    await FlutterBluePlus.startScan(
      timeout: const Duration(seconds: 4),
      androidUsesFineLocation: true,
    );
  }

  Future<void> stopScan() async {
    await FlutterBluePlus.stopScan();
  }

  void updateDevices(List<BattleDevice> devices) {
    state = devices;
  }

  void startListening() {
    FlutterBluePlus.scanResults.listen((results) {
      final devices = results
          .map((result) => BattleDevice(
                id: result.device.id.id,
                name:
                    result.device.name.isEmpty ? 'unknown' : result.device.name,
                rssi: result.rssi,
              ))
          .toList();
      updateDevices(devices);
    });
  }
}
