import 'package:emotion_diary/common/utils/colors.dart';
import 'package:flutter/material.dart';

class TextboxWithBorder extends StatelessWidget {
  const TextboxWithBorder({super.key, required this.content});

  final String content;

  @override
  Widget build(BuildContext context) {
    return Container(
        // height: 160,
        width: double.infinity,
        decoration: BoxDecoration(
            borderRadius: const BorderRadius.all(Radius.circular(10)),
            border: Border.all(
              width: 1.5,
              color: EmotionDiaryColors.grey0,
            )),
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 12.0, horizontal: 18.0),
          child: SingleChildScrollView(
            child: Text(
              content,
              textAlign: TextAlign.justify,
            ),
          ),
        ));
  }
}
