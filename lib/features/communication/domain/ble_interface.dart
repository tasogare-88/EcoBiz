import 'battle_device.dart';

abstract class BleInterface {
  Future<bool> isBluetoothAvailable();
  Future<void> startScan();
  Future<void> stopScan();
  void updateDevices(List<BattleDevice> devices);
  void startListening();
}
