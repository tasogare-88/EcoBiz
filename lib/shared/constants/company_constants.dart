class CompanyConstants {
  // 会社のジャンル
  static const Map<String, String> genres = {
    'it': 'IT',
    'manufacturing': '製造',
    'foodService': '飲食',
    'transportation': '運輸',
    'advertising': '広告',
    'construction': '建築',
  };

  // 会社のランクと換算レート
  static const Map<String, Map<String, dynamic>> ranks = {
    'startup': {
      'name': 'スタートアップ',
      'minAssets': 0,
      'maxAssets': 50000,
      'rate': 50,
    },
    'localCompany': {
      'name': 'ローカルビジネス',
      'minAssets': 50001,
      'maxAssets': 325000,
      'rate': 75,
    },
    'regionalCompany': {
      'name': '地域企業',
      'minAssets': 325001,
      'maxAssets': 1000000,
      'rate': 100,
    },
    'smallMediumCompany': {
      'name': '中小企業',
      'minAssets': 1000001,
      'maxAssets': 5000000,
      'rate': 150,
    },
    'largeCompany': {
      'name': '大企業',
      'minAssets': 5000001,
      'maxAssets': 100000000,
      'rate': 300,
    },
    'globalCompany': {
      'name': 'グローバル企業',
      'minAssets': 100000001,
      'maxAssets': 1000000000,
      'rate': 500,
    },
  };

  // バトル関連
  static const int battleMultiplier = 4; // 歩数差の倍率

  // 初期値
  static const int initialAssets = 0;
  static const String initialRank = 'startup';
  static const int initialStepsToYenRate = 50;
}
