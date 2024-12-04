# EcoBiz
HACK U 2024のプロジェクト。

無駄だと思っていること：『歩いている時間』
ユーザーが歩くことでゲーム内通貨を貯めることができ、その通貨を利用して自分の仮想の会社を経営していくアプリケーション。

## 技術スタック
- Flutter
- Unity

## セットアップ
- https://pub.dev/packages/flutter_unity_widget
- `android/gradle.properties`を新規作成し、以下の内容を記述。

```
android.useAndroidX=true
android.enableJetifier=true

# 各個人のJavaのパスを指定↓
org.gradle.java.home=/opt/homebrew/Cellar/openjdk@17/17.0.13/libexec/openjdk.jdk/Contents/Home
org.gradle.jvmargs=-Xmx4G -XX:MaxMetaspaceSize=2G -XX:+HeapDumpOnOutOfMemoryError
```

## 参考リンク
- [Figma](https://www.figma.com/design/7bmruFMTucvrdtZbTUK9uk/UI%E8%A8%AD%E8%A8%88?node-id=0-1&t=ip9rzQ75xjwzcnW6-1)
