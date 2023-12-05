import 'package:dotted_border/dotted_border.dart';
import 'package:emotion_diary/common/utils/colors.dart';
import 'package:flutter/material.dart';

class IconTextboxWithDottedBorder extends StatelessWidget {
  const IconTextboxWithDottedBorder(
      {super.key, required this.icon, required this.label});

  final IconData icon;
  final String label;

  @override
  Widget build(BuildContext context) {
    return DottedBorder(
      color: EmotionDiaryColors.grey0,
      radius: Radius.circular(10.0),
      strokeWidth: 2,
      borderType: BorderType.RRect,
      child: Container(
        constraints: BoxConstraints(maxHeight: 120),
        alignment: Alignment.center,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Icon(
                icon,
                color: EmotionDiaryColors.grey0,
              ),
            ),
            Text(
              label,
              style: Theme.of(context)
                  .textTheme
                  .headlineSmall!
                  .copyWith(color: EmotionDiaryColors.grey0),
            ),
          ],
        ),
      ),
    );
  }
}
