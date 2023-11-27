import 'package:emotion_diary/common/utils/emojis.dart';

enum EmotionCategory {
  bigSmile("웃김"),
  smile("기쁨"),
  angry("화남"),
  surprised("놀람"),
  sad("슬픔");

  final String korean;
  const EmotionCategory(this.korean);
}

extension EmotionCategoryImagePath on EmotionCategory {
  String imagePath() {
    switch (this) {
      case EmotionCategory.bigSmile: return Emojis.bigSmile;
      case EmotionCategory.smile: return Emojis.smile;
      case EmotionCategory.angry: return Emojis.angry;
      case EmotionCategory.surprised: return Emojis.surprised;
      case EmotionCategory.sad: return Emojis.sad;
    }
  }
}


class EmotionCategoryModel {
  EmotionCategoryModel({required this.category, required this.words});

  EmotionCategory? category;
  List<EmotionModel>? words;
}

extension EmotionCategoryList on EmotionCategoryModel {
  static List<EmotionCategoryModel> categories = [
    EmotionCategoryModel(category: EmotionCategory.bigSmile, words: []),
    EmotionCategoryModel(category: EmotionCategory.smile, words: []),
    EmotionCategoryModel(category: EmotionCategory.angry, words: []),
    EmotionCategoryModel(category: EmotionCategory.surprised, words: []),
    EmotionCategoryModel(category: EmotionCategory.sad, words: []),
  ];
}


class EmotionModel {
  EmotionModel({required this.word, required this.definition});

  String word;
  String definition;
}