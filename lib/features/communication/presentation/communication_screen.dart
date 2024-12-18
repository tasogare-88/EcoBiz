import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import './communication_view_model.dart';

class CommunicationScreen extends ConsumerWidget {
  const CommunicationScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(communicationViewModelProvider);

    // if (!state.isBluetoothAvailable) {
    //   return const Scaffold(
    //     body: Center(
    //       child: Text('Bluetoothを有効にしてください'),
    //     ),
    //   );
    // }

    return Scaffold(
      appBar: AppBar(
        title: const Text('対戦相手'),
        backgroundColor: const Color(0xFFB5D4E4),
      ),
      body: RefreshIndicator(
        onRefresh: () =>
            ref.read(communicationViewModelProvider.notifier).refreshDevices(),
        child: state.devices.isEmpty
            ? const Center(
                child: Text('近くに対戦相手が見つかりません'),
              )
            : ListView.builder(
                itemCount: state.devices.length,
                itemBuilder: (context, index) {
                  final device = state.devices[index];
                  return Card(
                    margin: const EdgeInsets.symmetric(
                      horizontal: 16,
                      vertical: 8,
                    ),
                    color: const Color(0xFFFFE4C4),
                    child: ListTile(
                      leading: const CircleAvatar(
                        backgroundColor: Color(0xFFEADDFF),
                        child: Icon(Icons.person),
                      ),
                      title: Text(device.name),
                      onTap: () {
                        // TODO: 対戦処理の実装
                      },
                    ),
                  );
                },
              ),
      ),
    );
  }
}
