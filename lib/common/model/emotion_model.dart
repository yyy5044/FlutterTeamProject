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
    EmotionCategoryModel(category: EmotionCategory.smile, words: [
      EmotionModel(word: "벅찬", definition:
      """1.형용사 감당하기가 어렵다.\n2.형용사 감격, 기쁨, 희망 따위가 넘칠 듯이 가득하다.\n3.형용사 숨이 견디기 힘들 만큼 가쁘다."""
      ),
      EmotionModel(word: "포근한", definition:
      """1.형용사 도톰한 물건이나 자리 따위가 보드랍고 따뜻하다.\n2.형용사 감정이나 분위기 따위가 보드랍고 따뜻하여 편안한 느낌이 있다.\n3.형용사 겨울 날씨가 바람이 없고 따뜻하다."""
      ),
      EmotionModel(word: "흐뭇한", definition:
      """형용사 마음에 흡족하여 매우 만족스럽다."""
      ),
      EmotionModel(word: "상쾌한", definition:
      """형용사 느낌이 시원하고 산뜻하다."""
      ),
      EmotionModel(word: "짜릿한", definition:
      """1.형용사 조금 자린 듯하다. ‘자릿하다’보다 센 느낌을 준다.\n2.형용사 심리적 자극을 받아 마음이 순간적으로 조금 흥분되고 떨리는 듯하다. ‘자릿하다’보다 센 느낌을 준다."""
      ),
    ]),
    EmotionCategoryModel(category: EmotionCategory.sad, words: [
      EmotionModel(word: "뭉클한", definition:
      """1.형용사 먹은 음식이 잘 삭지 않아 가슴에 뭉치어 있는 듯하다. ‘뭉글하다’보다 거센 느낌을 준다.\n2.형용사 슬픔이나 노여움 따위의 감정이 북받치어 가슴이 갑자기 꽉 차는 듯하다. ‘뭉글하다’보다 거센 느낌을 준다.\n3.형용사 덩이진 물건이 겉으로 무르고 미끄럽다. ‘뭉글하다’보다 거센 느낌을 준다."""
      ),
      EmotionModel(word: "눈물겨운", definition:
      """형용사 눈물이 날 만큼 가엾고 애처롭다."""
      ),
      EmotionModel(word: "처량한", definition:
      """1.형용사 마음이 구슬퍼질 정도로 외롭거나 쓸쓸하다.\n2.형용사 초라하고 가엾다."""
      ),
      EmotionModel(word: "위축되는", definition:
      """1.동사 마르거나 시들어서 우그러지고 쭈그러들게 되다.\n2.동사 어떤 힘에 눌려 졸아들고 기를 펴지 못하게 되다."""
      ),
      EmotionModel(word: "허탈한", definition:
      """1.형용사 몸에 기운이 빠지고 정신이 멍하다.\n2.	의학 온몸의 힘이 쭉 빠져 빈사지경에 이른 상태이다. 얼굴이 창백하여지고 동공이 커지며 의식이 흐려지고 식은땀이 나는 따위의 증상이 나타난다."""
      ),
    ]),
    EmotionCategoryModel(category: EmotionCategory.angry, words: [
      EmotionModel(word: "얄미운", definition:
      """형용사 말이나 행동이 약빠르고 밉다."""
      ),
      EmotionModel(word: "열받는", definition:
      """동사 사람이 감정의 자극을 받거나 격분하다."""
      ),
      EmotionModel(word: "못마땅한", definition:
      """형용사 마음에 들지 않아 좋지 않다."""
      ),
      EmotionModel(word: "불쾌한", definition:
      """1.형용사 못마땅하여 기분이 좋지 아니하다.\n2.형용사 몸이 찌뿌드드하고 좋지 않다."""
      ),
      EmotionModel(word: "심술나는", definition:
      """1.동사 신체 표면이나 땅 위에 솟아나다.\n2.동사 길, 통로, 창문 따위가 생기다.\n3.동사 어떤 사물에 구멍, 자국 따위의 형체 변화가 생기거나 작용에 이상이 일어나다.\n4.보조동사 (동사 뒤에서 ‘-어 나다’ 구성으로 쓰여) 앞말이 뜻하는 행동을 끝내어 이루었음을 나타내는 말.\n5.보조동사 (동사 뒤에서 ‘-고 나다’ 구성으로 쓰여) 앞말이 뜻하는 행동이 끝났음을 나타내는 말."""
      ),
    ]),
    EmotionCategoryModel(category: EmotionCategory.surprised, words: [
      EmotionModel(word: "당황스러운", definition:
      """형용사 놀라거나 다급하여 어찌할 바를 몰라 하는 데가 있다."""
      ),
      EmotionModel(word: "긴장되는", definition:
      """동사 마음을 조이고 정신을 바짝 차리게 되다."""
      ),
      EmotionModel(word: "억울한", definition:
      """형용사 아무 잘못 없이 꾸중을 듣거나 벌을 받거나 하여 분하고 답답하다."""
      ),
      EmotionModel(word: "걱정스러운", definition:
      """형용사 걱정이 되어 마음이 편하지 않은 데가 있다."""
      ),
      EmotionModel(word: "놀라운", definition:
      """1.형용사 감동을 일으킬 만큼 훌륭하거나 굉장하다.\n2.형용사 갑작스러워 두렵거나 흥분 상태에 있다.\m3.형용사 어처구니없을 만큼 괴이하다."""
      ),
    ]),
    EmotionCategoryModel(category: EmotionCategory.bigSmile, words: [
      EmotionModel(word: "재미있다", definition:
      """형용사 아기자기하게 즐겁고 유쾌한 기분이나 느낌이 있다."""
      ),
      EmotionModel(word: "경쾌한", definition:
      """형용사 움직임이나 모습, 기분 따위가 가볍고 상쾌하다."""
      ),
      EmotionModel(word: "명량한", definition:
      """형용사 환하게 밝다."""
      ),
      EmotionModel(word: "신나는", definition:
      """동사 어떤 일에 흥미나 열성이 생겨 기분이 매우 좋아지다."""
      ),
      EmotionModel(word: "흥분된", definition:
      """동사 어떤 자극을 받아 감정이 북받쳐 일어나게 되다."""
      ),
    ]),
  ];
}


class EmotionModel {
  EmotionModel({required this.word, required this.definition});

  String word;
  String definition;
}