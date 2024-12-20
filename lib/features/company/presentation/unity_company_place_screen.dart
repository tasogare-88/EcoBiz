import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_unity_widget/flutter_unity_widget.dart';

import '../../../core/auth/data/user_repository.dart';
import '../../../features/company/presentation/company_view_model.dart';

class UnityCompanyPlaceScreen extends ConsumerWidget {
  final String userId;
  final String companyName;
  final String genre;
  final int? locationIndex;

  const UnityCompanyPlaceScreen({
    super.key,
    required this.userId,
    required this.companyName,
    required this.genre,
    this.locationIndex,
  });

  void onUnityCreated(UnityWidgetController controller, WidgetRef ref) async {
    debugPrint('Unity初期化開始');
    try {
      await controller.postMessage('BattleManager', 'LoadScene', 'SelectCompanyPlace');
    }
    catch (e) {
      await controller.postMessage('SelectCompanyCanvas', 'LoadScene', 'SelectCompanyPlace');
    }
    

    await Future.delayed(const Duration(seconds: 1));
    final user =
        await ref.read(userRepositoryProvider.notifier).getUser(userId);

    final companyData = {
      'userId': userId,
      'userName': user?.name ?? 'Unknown',
      'companyName': companyName,
      'genre': genre,
      'locationIndex': locationIndex,
      'isInitialSetup': locationIndex == null,
    };

    controller.postMessage(
      'SelectCompanyCanvas',
      'SetCompanyData',
      json.encode(companyData),
    );
  }

  void onUnityMessage(dynamic handler, WidgetRef ref) {
    final data = json.decode(handler.toString());
    if (data['type'] == 'COMPANY_PLACE_SELECTED') {
      final selectedLocationIndex = data['locationIndex'] as int;

      ref.read(companyViewModelProvider.notifier).updateCompanyLocation(
            userId: userId,
            locationIndex: selectedLocationIndex,
          );
    }
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      body: UnityWidget(
        onUnityCreated: (controller) => onUnityCreated(controller, ref),
        onUnityMessage: (handler) => onUnityMessage(handler, ref),
        fullscreen: true,
      ),
    );
  }
}
