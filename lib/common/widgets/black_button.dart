import 'package:emotion_diary/common/utils/colors.dart';
import 'package:flutter/material.dart';

class BlackButton extends StatelessWidget {
  const BlackButton({
    super.key,
    required this.onPressed,
    required this.label,
  });

  final Function onPressed;
  final String label;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () => onPressed,
      style: ElevatedButton.styleFrom(
        backgroundColor: EmotionDiaryColors.black0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.0),
        ),
        foregroundColor: Colors.white,
      ),
      child: SizedBox(
        height: 64,
        child: Center(
          child: Text(
            label,
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: EmotionDiaryColors.white0,
            ),
          ),
        ),
      ),
    );
  }
}
