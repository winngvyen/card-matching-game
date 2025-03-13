import 'package:flutter/material.dart';
import 'card_model.dart';
import 'dart:math';

class GameProvider extends ChangeNotifier {
  List<CardModel> _cards = [];
  List<int> _flippedIndices = [];

  GameProvider() {
    resetGame();
  }

  List<CardModel> get cards => _cards;

  void resetGame() {
    List<String> emojis = ["🍎", "🍌", "🍒", "🍇", "🥝", "🍓", "🍍", "🥥"];
    emojis = [...emojis, ...emojis]; // Duplicate emojis to create pairs
    emojis.shuffle(Random());

    _cards = emojis.map((e) => CardModel(emoji: e)).toList();
    _flippedIndices.clear(); // Clear flipped cards
    notifyListeners();
  }

  void flipCard(int index) {
    if (_flippedIndices.length < 2 && !_cards[index].isFaceUp && !_cards[index].isMatched) {
      _cards[index].isFaceUp = true;
      _flippedIndices.add(index);

      if (_flippedIndices.length == 2) {
        _checkMatch();
      }

      notifyListeners();
    }
  }

  void _checkMatch() {
    int first = _flippedIndices[0];
    int second = _flippedIndices[1];

    if (_cards[first].emoji == _cards[second].emoji) {
      _cards[first].isMatched = true;
      _cards[second].isMatched = true;
    } else {
      Future.delayed(Duration(milliseconds: 800), () {
        _cards[first].isFaceUp = false;
        _cards[second].isFaceUp = false;
        notifyListeners();
      });
    }

    _flippedIndices.clear();
    notifyListeners();
  }

  bool isGameWon() {
    return _cards.every((card) => card.isMatched);
  }
}
