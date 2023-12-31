import 'package:emotion_diary/common/utils/observes.dart';
import 'package:emotion_diary/common/utils/theme_manager.dart';
import 'package:emotion_diary/feature/authentication/LoginPage.dart';
import 'package:emotion_diary/feature/main_page/main_page.dart';
import 'package:emotion_diary/feature/writing_diary_view/writing_diary_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/date_symbol_data_local.dart';

import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';

void main() async {
  // Flutter 엔진과 위젯 트리가 바인딩되도록 보장
  WidgetsFlutterBinding.ensureInitialized();

  // Firebase 앱 인스턴스를 초기화
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  await initializeDateFormatting();
  runApp(
    ProviderScope(
      observers: [Observers()],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeManager.themeData,
        // home: MainPage(),
        initialRoute: '/login',
        routes: {
          //route별 명칭 지정후 사용하는 방법
          '/login': (BuildContext context) => const LoginPage(),
          '/mainpage': (BuildContext context) => MainPage(),
          '/writing': (BuildContext context) => WritingDiaryView(),
        });
  }
}
