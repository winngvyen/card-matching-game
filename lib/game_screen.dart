import 'package:flutter/material.dart';

class GameScreen extends StatefulWidget {
  @override
  _GameScreenState createState() => _GameScreenState();
}

class _GameScreenState extends State<GameScreen> {
  final int gridSize = 4;
  final List<bool> cardFlipped = List.filled(16, false);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Card Matching Game")),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: GridView.builder(
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: gridSize,
            crossAxisSpacing: 8,
            mainAxisSpacing: 8,
          ),
          itemCount: gridSize * gridSize,
          itemBuilder: (context, index) {
            return GestureDetector(
              onTap: () {
                setState(() {
                  cardFlipped[index] = !cardFlipped[index];
                });
              },
              child: Container(
                decoration: BoxDecoration(
                  color: cardFlipped[index] ? Colors.blue : Colors.grey,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Center(
                  child: cardFlipped[index] ? Text("🐱") : SizedBox.shrink(),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
