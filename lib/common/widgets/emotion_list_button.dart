import 'package:emotion_diary/common/utils/colors.dart';
import 'package:flutter/material.dart';

class EmotionListButton extends StatelessWidget {
  const EmotionListButton({
    super.key,
    required this.onPressed,
    required this.label,
  });

  final Function onPressed;
  final String label;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () => onPressed(),
      style: ElevatedButton.styleFrom(
        side: BorderSide(
          width: 1,
          color: EmotionDiaryColors.black0,
        ),
        backgroundColor: EmotionDiaryColors.white0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.0),
        ),
        elevation: 0,
        foregroundColor: EmotionDiaryColors.black0,
      ),
      child: SizedBox(
        height: 64,
        child: Center(
          child: Text(
            label,
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: EmotionDiaryColors.black0,
            ),
          ),
        ),
      ),
    );
  }
}
