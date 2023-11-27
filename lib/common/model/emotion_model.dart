enum EmotionCatagory

class EmotionCategoryModel {
  String? category;
  List<EmotionModel>? words;

  init(String category, List<EmotionModel> words) {
    this.category = category;
    this.words = words;
  }
}

class EmotionModel {
  String? word;
  String? definition;

  init(String word, String definition) {
    this.word = word;
    this.definition = definition;
  }
}