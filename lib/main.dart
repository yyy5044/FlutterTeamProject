import 'package:emotion_diary/common/utils/theme_manager.dart';
import 'package:emotion_diary/feature/main_page/main_page.dart';
import 'package:emotion_diary/feature/writing_diary_view/writing_diary_view.dart';
import 'package:flutter/material.dart';
import 'package:intl/date_symbol_data_local.dart';

void main() async {
  await initializeDateFormatting();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeManager.themeData,

      home: MainPage(),
    );
  }
}
