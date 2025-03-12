class CardModel {
  final String emoji;
  bool isFaceUp;
  bool isMatched;

  CardModel({required this.emoji, this.isFaceUp = false, this.isMatched = false});
}
