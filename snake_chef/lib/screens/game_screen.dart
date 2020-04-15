import 'package:flutter/material.dart';
import '../game/game.dart';
import '../game/stage.dart';

class GameScreen extends StatelessWidget {
  final stage = Stage(
      recipes: [Recipe.salad(), Recipe.salad()],
      initialX: 5,
      initialY: 5,
  );
  
  @override
  Widget build(ctx) {
    return Scaffold(
        body: SnakeChef(boardWidth: 10, boardHeight: 10, stage: stage).widget
    );
  }
}

