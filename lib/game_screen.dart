import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'game_provider.dart';

class GameScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Card Matching Game")),
      body: Consumer<GameProvider>(
        builder: (context, gameProvider, child) {
          if (gameProvider.isGameWon()) {
            return Center(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    "🎉 You Won! 🎉",
                    style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 20),
                  ElevatedButton(
                    onPressed: () => gameProvider.resetGame(),
                    child: Text("Play Again"),
                  ),
                ],
              ),
            );
          }

          return Padding(
            padding: EdgeInsets.all(16),
            child: GridView.builder(
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 4,
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
                        style: TextStyle(fontSize: 32, color: Colors.black),
                      ),
                    ),
                  ),
                );
              },
            ),
          );
        },
      ),
    );
  }
}
