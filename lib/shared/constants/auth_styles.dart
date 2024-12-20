import 'package:flutter/material.dart';

class AuthStyles {
  static const double horizontalPadding = 32.0;
  static const double verticalSpacing = 16.0;
  static const double buttonHeight = 48.0;
  static const double maxWidth = 400.0;

  static const double logoSize = 200.0;
  static const double welcomeTextSize = 24.0;

  static const String welcomeText = 'EcoBizへようこそ';
  static const String orText = 'または';
  static const String continueWithGoogle = 'Googleで続ける';

  static const double googleButtonHeight = 52.0;

  static const Color primaryButtonColor = Color(0xFF4CAF50);
  static const Color primaryButtonTextColor = Colors.white;

  static const double buttonTextSize = 16.0;

  static const InputDecorationTheme textFieldStyle = InputDecorationTheme(
    contentPadding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 16.0),
    border: OutlineInputBorder(),
  );
}
