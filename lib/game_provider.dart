import 'package:flutter/material.dart';
import 'card_model.dart';
import 'dart:math';

class GameProvider extends ChangeNotifier {
  List<CardModel> _cards = [];
  List<int> _flippedIndices = [];

  GameProvider() {
    _initializeGame();
  }

  List<CardModel> get cards => _cards;

  void _initializeGame() {
    List<String> emojis = ["🍎", "🍌", "🍒", "🍇", "🥝", "🍓", "🍍", "🥥"];
    emojis = [...emojis, ...emojis]; // Duplicate emojis to make pairs
    emojis.shuffle(Random());

    _cards = emojis.map((e) => CardModel(emoji: e)).toList();
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
      Future.delayed(Duration(seconds: 1), () {
        _cards[first].isFaceUp = false;
        _cards[second].isFaceUp = false;
        notifyListeners();
      });
    }

    _flippedIndices.clear();
    notifyListeners();
  }
}
