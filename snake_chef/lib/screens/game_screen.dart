import 'package:flutter/material.dart';
import '../game/game.dart';
import '../game/stage.dart';
import '../stage_loader.dart';

class GameScreen extends StatelessWidget {
  
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
  }
}

