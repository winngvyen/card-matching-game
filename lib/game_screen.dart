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
                  child: AnimatedSwitcher(
                    duration: Duration(milliseconds: 500),
                    transitionBuilder: (widget, animation) {
                      return RotationYTransition(turns: animation, child: widget);
                    },
                    child: gameProvider.cards[index].isFaceUp || gameProvider.cards[index].isMatched
                        ? Card(
                            key: ValueKey(gameProvider.cards[index].emoji),
                            color: Colors.white,
                            child: Center(
                              child: Text(
                                gameProvider.cards[index].emoji,
                                style: TextStyle(fontSize: 32),
                              ),
                            ),
                          )
                        : Card(
                            key: ValueKey("back_$index"),
                            color: Colors.blue,
                            child: Center(
                              child: Text(
                                "❓",
                                style: TextStyle(fontSize: 32, color: Colors.white),
                              ),
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

// Custom RotationYTransition to simulate a flip effect
class RotationYTransition extends StatelessWidget {
  final Widget child;
  final Animation<double> turns;

  RotationYTransition({required this.child, required this.turns});

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: turns,
      child: child,
      builder: (context, child) {
        return Transform(
          transform: Matrix4.rotationY(turns.value * 3.1415927), // Rotate on Y-axis
          alignment: Alignment.center,
          child: child,
        );
      },
    );
  }
}
