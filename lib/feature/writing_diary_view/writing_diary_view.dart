import 'package:emotion_diary/common/utils/colors.dart';
import 'package:emotion_diary/common/widgets/black_button.dart';
import 'package:flutter/material.dart';

class WritingDiaryView extends StatelessWidget {
  const WritingDiaryView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('일기 작성'),
        backgroundColor: Colors.white,
        elevation: 1,
        shadowColor: Colors.black,
      ),
      body: SafeArea(
        minimum: const EdgeInsets.all(24),
        child: Container(
          child: BlackButton(
            onPressed: () {},
            label: 'test',
          ),
        ),
      ),
    );
  }
}
