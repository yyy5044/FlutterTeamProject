// Event 클래스에 이미지 경로를 추가
class Event {
  final String diaryText;
  final String? imagePath;
  final int emoji;
  final int emotion;
  final int weather;

  Event({
    required this.diaryText,
    this.imagePath,
    required this.emoji,
    required this.emotion,
    required this.weather,
  });

  @override
  String toString() {
    return 'Event(title: $diaryText, imagePath: $imagePath, emoji: $emoji, emotion: $emotion, weather: $weather)';
  }
}