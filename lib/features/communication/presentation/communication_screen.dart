import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/auth/data/user_repository.dart';
import '../../../core/auth/presentation/auth_view_model.dart';
import '../../../shared/widgets/confirmation_dialog.dart';
import '../../battle/presentation/unity_battle_screen.dart';
import '../../mock/data/mock_ble_repository.dart';
import '../../steps/presentation/steps_view_model.dart';
import './communication_view_model.dart';

class CommunicationScreen extends ConsumerWidget {
  const CommunicationScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(communicationViewModelProvider);
    final authState = ref.watch(authViewModelProvider);
    final user = authState.maybeMap(
      authenticated: (state) => state.user,
      orElse: () => throw Exception('Unauthorized'),
    );

    // デバッグモード時はモックデータを直接使用
    final devices = const bool.fromEnvironment('DEBUG_MODE', defaultValue: true)
        ? MockBleRepository().mockDevices
        : state.devices;

    return Scaffold(
      appBar: AppBar(
        title: const Text('対戦相手'),
        backgroundColor: const Color(0xFFB5D4E4),
      ),
      body: RefreshIndicator(
        onRefresh: () =>
            ref.read(communicationViewModelProvider.notifier).refreshDevices(),
        child: state.error != null
            ? Center(child: Text(state.error!))
            : devices.isEmpty
                ? const Center(child: Text('近くに対戦相手が見つかりません'))
                : ListView.builder(
                    itemCount: devices.length,
                    itemBuilder: (context, index) {
                      final device = devices[index];
                      // デバッグモード時はデバイスの情報を直接表示
                      if (const bool.fromEnvironment('DEBUG_MODE',
                          defaultValue: true)) {
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
                            onTap: () async {
                              final result = await showDialog<bool>(
                                context: context,
                                builder: (context) => ConfirmationDialog(
                                  title: '対戦確認',
                                  content: '${device.name}と対戦しますか？',
                                ),
                              );

                              if (result == true && context.mounted) {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => UnityBattleScreen(
                                      userId1: user.uid,
                                      userId2: device.userId,
                                      steps1: ref
                                              .read(stepsViewModelProvider)
                                              .dailyRecord
                                              ?.steps ??
                                          0,
                                      steps2: device.steps,
                                    ),
                                  ),
                                );
                              }
                            },
                          ),
                        );
                      }
                      return FutureBuilder(
                        future: ref
                            .read(userRepositoryProvider.notifier)
                            .getUser(device.userId),
                        builder: (context, snapshot) {
                          if (snapshot.connectionState ==
                              ConnectionState.waiting) {
                            return const Card(
                              child: ListTile(
                                leading: CircularProgressIndicator(),
                                title: Text('読み込み中...'),
                              ),
                            );
                          }

                          final opponent = snapshot.data;
                          if (opponent == null) {
                            return const SizedBox.shrink();
                          }

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
                              title: Text(opponent.name),
                              onTap: () async {
                                final result = await showDialog<bool>(
                                  context: context,
                                  builder: (context) => ConfirmationDialog(
                                    title: '対戦確認',
                                    content: '${opponent.name}と対戦しますか？',
                                  ),
                                );

                                if (result == true && context.mounted) {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => UnityBattleScreen(
                                        userId1: user.uid,
                                        userId2: opponent.id,
                                        steps1: ref
                                                .read(stepsViewModelProvider)
                                                .dailyRecord
                                                ?.steps ??
                                            0,
                                        steps2: device.steps,
                                      ),
                                    ),
                                  );
                                }
                              },
                            ),
                          );
                        },
                      );
                    },
                  ),
      ),
    );
  }
}
