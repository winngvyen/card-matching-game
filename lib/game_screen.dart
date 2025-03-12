import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'game_provider.dart';
import 'card_model.dart';

class GameScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Card Matching Game")),
      body: Padding(
        padding: EdgeInsets.all(16),
        child: Consumer<GameProvider>(
          builder: (context, gameProvider, child) {
            return GridView.builder(
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 4, // 4x4 grid
                mainAxisSpacing: 8,
                crossAxisSpacing: 8,
              ),
              itemCount: gameProvider.cards.length,
              itemBuilder: (context, index) {
                return GestureDetector(
                  onTap: () => gameProvider.flipCard(index),
                  child: Card(
                    color: gameProvider.cards[index].isFaceUp || gameProvider.cards[index].isMatched
                        ? Colors.white
                        : Colors.blue,
                    child: Center(
                      child: Text(
                        gameProvider.cards[index].isFaceUp || gameProvider.cards[index].isMatched
                            ? gameProvider.cards[index].emoji
                            : "❓",
                        style: TextStyle(fontSize: 32),
                      ),
                    ),
                  ),
                );
              },
            );
          },
        ),
      ),
    );
  }
}
