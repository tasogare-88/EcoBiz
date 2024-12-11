# EcoBiz
HACK U 2024のプロジェクト。

無駄だと思っていること：『歩いている時間』
ユーザーが歩くことでゲーム内通貨を貯めることができ、その通貨を利用して自分の仮想の会社を経営していくアプリケーション。

## Versions
| tool | version |
| -- | -- |
| Flutter | 3.22.3 |
| Dart | 3.4.4 |
| Unity | 2022.3.40 |
| Gradle | 8.1.1 |
| JDK | 17.0.13 |
| CocoaPods | 1.15.2 |
| iOS Minimum version | 13.0 |

## ディレクトリ構造
```
lib/
├── core/              # アプリケーション共通機能
│   ├── auth/          # 認証基盤
│   │   ├── data/      # リポジトリ層
│   │   ├── domain/    # ドメインモデル
│   │   └── presentation/ # UI層
│   └── providers/     # アプリ全体のプロバイダー
│
├── features/          # 機能モジュール
│   ├── home/         # HOME画面機能
│   ├── gacha/        # ガチャ機能
│   ├── company/      # 経営機能
│   ├── communication/# 通信機能
│   └── item/         # アイテム機能
│
└── shared/           # 共有コンポーネント
    ├── constants/    # 定数など
    ├── utils/        # ユーティリティ関数
    ├── widgets/      # 共通Widget
    └── navigation/   # 画面遷移
```

各featureディレクトリは、presentation/domain/dataの3層構造を採用している。

## デザインパターン
MVVMパターンを採用している。

### レイヤー構造
- **Presentation Layer** (`presentation/`)
  - View: UIの表示
  - ViewModel: UIのロジックと状態管理

- **Domain Layer** (`domain/`)
  - ドメインモデル
  - ビジネスロジック

- **Data Layer** (`data/`)
  - リポジトリ
  - データソースとの通信

### 状態管理
- Riverpodを使用
- 各機能モジュールごとにViewModelで状態を管理

### ディレクトリ命名規則
- スネークケース（例：`auth_repository.dart`）
- 機能モジュールは単数形
- レイヤーごとにディレクトリを分割

## 技術スタック
### フレームワーク
- Flutter
- Unity
### BaaS
- Firebase Authentication
- Cloud Firestore

### APIやライブラリ
- ヘルスコネクトAPI（歩数計測）
- Apple Health API（歩数計測）
- flutter_unity_widget（Unity連携）
- freezed（データモデル）
- riverpod（状態管理）

## セットアップ
1. https://pub.dev/packages/flutter_unity_widget の公式docsの手順に従って環境構築する。
2. `android/gradle.properties`を新規作成し、以下の内容を記述。
```gradle.properties
android.useAndroidX=true
android.enableJetifier=true

# 個人のJavaのパスを指定↓
org.gradle.java.home=/opt/homebrew/Cellar/openjdk@17/17.0.13/libexec/openjdk.jdk/Contents/Home
org.gradle.jvmargs=-Xmx4G -XX:MaxMetaspaceSize=2G -XX:+HeapDumpOnOutOfMemoryError
```
3. `ios/UnityLibrary/UnityFramework.podspec`を新規作成し、以下の内容を記述。
```UnityFramework.podspec
Pod::Spec.new do |s|
  s.name = 'UnityFramework'
  s.version = '0.0.1' # any version
  s.summary = 'Unity Framework for iOS'
  s.description = 'Unity Framework for iOS integration'
  s.homepage = 'https://unity.com'
  s.license = { :type => 'Copyright', :text => 'Copyright © 2024' }
  s.author = { 'Unity' => 'unity@unity3d.com' }
  s.source = { :git => '.', :tag => "#{s.version}" }
  s.platform = :ios, '13.0'   # your minimum supported version
  s.vendored_frameworks = 'UnityFramework.framework'
  s.framework = 'UnityFramework'
  s.xcconfig = {
    'FRAMEWORK_SEARCH_PATHS' => '"$(PODS_ROOT)/UnityFramework"',
    'OTHER_LDFLAGS' => '$(inherited) -framework UnityFramework'
  }
end
```
4. `.flutter_plugins`配下にある`flutter_unity_widget/android/build.gradle`を開き、以下の変更を行う。
```build.gradle
compileOptions {
        sourceCompatibility = JavaVersion.VERSION_1_8
        targetCompatibility = JavaVersion.VERSION_1_8
    }

kotlinOptions {
        jvmTarget = JavaVersion.VERSION_1_8
    }
```
5. `lib/firebase_options.dart`を新規作成し、Notionの[#環境変数](https://www.notion.so/14a15180284f802fb3b5c5e16d5eb783?pvs=4)から参照。
6. `ios/Runner/GoogleService-Info.plist`を新規作成し、Notionの[#環境変数](https://www.notion.so/14a15180284f802fb3b5c5e16d5eb783?pvs=4)から参照。
7. `android/app/google-services.json`を新規作成し、Notionの[#環境変数](https://www.notion.so/14a15180284f802fb3b5c5e16d5eb783?pvs=4)から参照。

## デバッグ手順
### iOS
```bash
cd ios
pod install
cd ..
(fvm) flutter clean
(fvm) flutter pub get
(fvm) flutter build ios
(fvm) flutter run
```
### Android
```bash
(fvm) flutter clean
(fvm) flutter pub get
(fvm) flutter build apk
(fvm) flutter run
```

## Tips
- Makefileを使うと便利。

## 参考リンク
- [Figma](https://www.figma.com/design/7bmruFMTucvrdtZbTUK9uk/UI%E8%A8%AD%E8%A8%88?node-id=0-1&t=ip9rzQ75xjwzcnW6-1)
- [Miro](https://miro.com/app/board/uXjVLGGoy8c=/?share_link_id=227586627554)
