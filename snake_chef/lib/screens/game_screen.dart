import 'package:flame/position.dart';
import 'package:flutter/material.dart';
import '../game/game.dart';
import '../game/stage.dart';
import '../stage_loader.dart';

class GameScreen extends StatelessWidget {
<<<<<<< HEAD
  final stage = Stage(
    recipes: [Recipe.salad(), Recipe.salad()],
    obstacles: [Position(0, 0), Position(3, 2), Position(4, 6)],
    initialX: 5,
    initialY: 5,
  );

  @override
  Widget build(ctx) {
    return Scaffold(body: SnakeChef(boardWidth: 10, boardHeight: 10, stage: stage).widget);
=======
  
  @override
  Widget build(ctx) {
    final stageNumber = ModalRoute.of(ctx).settings.arguments;

    return Scaffold(
        body: FutureBuilder(
            future: StageLoader.loadStage(stageNumber),
            builder: (BuildContext ctx, AsyncSnapshot<Stage> snapshot) {
              if (snapshot.hasData) {
                final Stage stage = snapshot.data;

                return SnakeChef(boardWidth: 10, boardHeight: 10, stage: stage).widget;
              }
              return Container();
            }
        ),
    );
>>>>>>> 6b483be0a4915a9bea75ee46b576280316400dab
  }
}
