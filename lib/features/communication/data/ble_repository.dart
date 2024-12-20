import 'package:flutter_blue_plus/flutter_blue_plus.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../domain/battle_device.dart';
import 'base_ble_repository.dart';

part 'ble_repository.g.dart';

@Riverpod(keepAlive: true)
class BleRepository extends _$BleRepository implements BaseBleRepository {
  final List<BattleDevice> _devices = [];

  @override
  List<BattleDevice> build() => _devices;

  @override
  List<BattleDevice> get devices => _devices;

  @override
  void updateDevices(List<BattleDevice> devices) {
    _devices.clear();
    _devices.addAll(devices);
    state = List.from(_devices);
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
    try {
      await FlutterBluePlus.startScan(
        timeout: const Duration(seconds: 4),
        androidUsesFineLocation: true,
      );
    } catch (e) {
      rethrow;
    }
  }

  Future<void> stopScan() async {
    try {
      await FlutterBluePlus.stopScan();
    } catch (e) {
      rethrow;
    }
  }

  void startListening() {
    FlutterBluePlus.scanResults.listen((results) {
      final devices = results
          .map((result) => BattleDevice(
                id: result.device.id.id,
                userId: result.device.id.id,
                name:
                    result.device.name.isEmpty ? 'unknown' : result.device.name,
                steps: 0,
              ))
          .toList();
      updateDevices(devices);
    });
  }
}
