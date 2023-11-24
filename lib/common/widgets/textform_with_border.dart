import 'package:emotion_diary/common/utils/colors.dart';
import 'package:flutter/material.dart';

class TextFormWithBorder extends StatelessWidget {
  const TextFormWithBorder({super.key});

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
            child: TextField(
              // controller: textarea,
              keyboardType: TextInputType.multiline,
              maxLines: 6,
              decoration: InputDecoration(
                contentPadding: EdgeInsets.all(0),
                hintText: "Enter Remarks",
                border: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.transparent)),
                focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.transparent)),
              ),
            ),
          )),
    );
  }
}
