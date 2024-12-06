# EcoBiz
HACK U 2024のプロジェクト。

無駄だと思っていること：『歩いている時間』
ユーザーが歩くことでゲーム内通貨を貯めることができ、その通貨を利用して自分の仮想の会社を経営していくアプリケーション。

## versions
- Flutter: 3.22.3
- Dart: 3.4.4
- Unity: 2022.3.40
- Gradle: 8.1.1
- JDK: 17.0.13
- CocoaPods: 1.15.2
- iOS Minimum version: 13.0

## 技術スタック
- Flutter
- Unity
- Firebase Authentication
- Cloud Firestore

## セットアップ
- https://pub.dev/packages/flutter_unity_widget
- `android/gradle.properties`を新規作成し、以下の内容を記述。
```gradle.properties
android.useAndroidX=true
android.enableJetifier=true

# 個人のJavaのパスを指定↓
org.gradle.java.home=/opt/homebrew/Cellar/openjdk@17/17.0.13/libexec/openjdk.jdk/Contents/Home
org.gradle.jvmargs=-Xmx4G -XX:MaxMetaspaceSize=2G -XX:+HeapDumpOnOutOfMemoryError
```
- `ios/UnityLibrary/UnityFramework.podspec`を新規作成し、以下の内容を記述。
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

- その後, pod installを実行
```bash
cd ios
pod install
```

- `lib/firebase_options.dart`を新規作成し、Notionの[#環境変数](https://www.notion.so/14a15180284f802fb3b5c5e16d5eb783?pvs=4)から参照。
- `ios/Runner/GoogleService-Info.plist`を新規作成し、Notionの[#環境変数](https://www.notion.so/14a15180284f802fb3b5c5e16d5eb783?pvs=4)から参照。
- `android/app/google-services.json`を新規作成し、Notionの[#環境変数](https://www.notion.so/14a15180284f802fb3b5c5e16d5eb783?pvs=4)から参照。

## 注意: Androidでbuildする前に変更が必要です。
- `.flutter_plugins`の中にある`flutter_unity_widget/android/build.gradle`を開き,必要に応じて以下の変更を行う。
  
```build.gradle
compileOptions {
        sourceCompatibility = JavaVersion.VERSION_1_8
        targetCompatibility = JavaVersion.VERSION_1_8
    }

kotlinOptions {
        jvmTarget = JavaVersion.VERSION_1_8
    }
```

## 参考リンク
- [Figma](https://www.figma.com/design/7bmruFMTucvrdtZbTUK9uk/UI%E8%A8%AD%E8%A8%88?node-id=0-1&t=ip9rzQ75xjwzcnW6-1)
- [Miro](https://miro.com/app/board/uXjVLGGoy8c=/?share_link_id=227586627554)
