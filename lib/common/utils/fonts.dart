import 'package:flutter/material.dart';

class FontManager {
  static const String primaryFontFamily = 'YourPrimaryFont'; // 폰트 패밀리 이름 설정

  static final ThemeData themeData = ThemeData(
    textTheme: TextTheme(
      // 여기에 사용할 스타일에 따라 폰트를 설정
      titleLarge: TextStyle(
        fontFamily: primaryFontFamily,
        fontSize: 28.0,
      ),
      headlineMedium: TextStyle(
        fontFamily: primaryFontFamily,
        fontSize: 24.0,
        fontWeight: FontWeight.bold,
      ),
      headlineSmall: TextStyle(
        fontFamily: primaryFontFamily,
        fontSize: 20.0,
        fontWeight: FontWeight.bold,
      ),
      titleMedium: TextStyle(
        fontFamily: primaryFontFamily,
        fontSize: 24.0,
        fontWeight: FontWeight.bold,
      ),
      titleSmall: TextStyle(
        fontFamily: primaryFontFamily,
        fontSize: 20.0,
        fontWeight: FontWeight.bold,
      ),
      bodyMedium: TextStyle(
        fontFamily: primaryFontFamily,
        fontSize: 24.0,
        fontWeight: FontWeight.bold,
      ),
    ),
    // 다른 테마 설정들...
  );
}
