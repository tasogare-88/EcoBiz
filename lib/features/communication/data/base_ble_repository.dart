import '../domain/battle_device.dart';
import '../domain/ble_interface.dart';

abstract class BaseBleRepository implements BleInterface {
  List<BattleDevice> get devices;
  void updateDevices(List<BattleDevice> devices);
}
