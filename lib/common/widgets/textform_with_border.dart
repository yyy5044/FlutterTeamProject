import 'package:emotion_diary/common/utils/colors.dart';
import 'package:flutter/material.dart';

class TextFormWithBorder extends StatelessWidget {
  const TextFormWithBorder({super.key, required this.controller});
  final TextEditingController controller;
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
          padding: EdgeInsets.symmetric(vertical: 12.0, horizontal: 18.0),
          child: SingleChildScrollView(
            child: TextField(
              controller: controller,
              keyboardType: TextInputType.multiline,
              maxLines: 6,
              style: Theme.of(context).textTheme.bodyMedium,
              decoration: const InputDecoration(
                  contentPadding: EdgeInsets.all(0),
                  border: InputBorder.none,
                  hintText: "무슨 일이 있었나요?"),
            ),
          )),
    );
  }
}
