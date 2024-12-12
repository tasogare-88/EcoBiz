import 'dart:convert';
import 'package:flutter_unity_widget/flutter_unity_widget.dart';

// Unityからのメッセージクラス
class UnityMessage {
  final String type;
  final dynamic data;

  UnityMessage({required this.type, required this.data});

  factory UnityMessage.fromJson(String jsonString) {
    final Map<String, dynamic> json = jsonDecode(jsonString);
    return UnityMessage(
      type: json['type'] ?? 'unknown',
      data: json['data'],
    );
  }

  @override
  String toString() {
    return 'UnityMessage(type: $type, data: $data)';
  }
}

// Unityとの通信クラス
class FlutterUnityCommunication {
  final UnityWidgetController? unityController;

  FlutterUnityCommunication(this.unityController);

  Future<void> sendCompanyId(String companyId) async {
    if (unityController == null) {
      throw Exception('UnityControllerが初期化されていません');
    }
    try {
      await unityController!.postMessage('GameManager', 'ReceiveCompanyId', companyId);
    } catch (e) {
      throw Exception('Unityへの会社ID送信に失敗しました: $e');
    }
  }

  void onUnityMessageReceived(UnityMessage message) {
    final data = message.data;
    if (data == null) {
      print('Unityからのメッセージデータが空です');
      return;
    }

    try {
      final winnerId = data['winnerId'];
      final loserId = data['loserId'];
      final stepsDifference = data['stepsDifference'];
      final amountChanged = data['amountChanged'];

      print('Unityから受信した勝敗データ:');
      print('勝者ID: $winnerId');
      print('敗者ID: $loserId');
      print('ステップ差: $stepsDifference');
      print('変動額: $amountChanged');

    } catch (e) {
      print('Unityからの勝敗データの解析に失敗しました: $e');
    }
  }
}
