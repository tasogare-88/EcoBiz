import '../../communication/data/base_ble_repository.dart';
import '../../communication/domain/battle_device.dart';

class MockBleRepository implements BaseBleRepository {
  final List<BattleDevice> mockDevices = [
    BattleDevice(
      id: 'mock-device-1',
      userId: 'mock-user-1',
      name: '山田太郎',
      steps: 8000,
    ),
    BattleDevice(
      id: 'mock-device-2',
      userId: 'mock-user-2',
      name: '佐藤花子',
      steps: 5000,
    ),
    BattleDevice(
      id: 'mock-device-3',
      userId: 'mock-user-3',
      name: '鈴木一郎',
      steps: 12000,
    ),
  ];

  @override
  List<BattleDevice> get devices => mockDevices;

  @override
  void updateDevices(List<BattleDevice> devices) {
    mockDevices.clear();
    mockDevices.addAll(devices);
  }

  @override
  Future<bool> isBluetoothAvailable() async {
    return true;
  }

  @override
  Future<void> startScan() async {
    updateDevices(mockDevices);
  }

  @override
  Future<void> stopScan() async {}

  @override
  void startListening() {}
}
