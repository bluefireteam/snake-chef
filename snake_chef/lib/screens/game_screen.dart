import 'package:flutter/material.dart';
import '../game/game.dart';
import '../game/stage.dart';
import '../stage_loader.dart';

import '../audio_manager.dart';

class GameScreen extends StatelessWidget {
  @override
  Widget build(ctx) {
    AudioManager.loopBackgroundMusic('gameplay.ogg');

    final stageNumber = ModalRoute.of(ctx).settings.arguments;

    return Container(
        color: Colors.black,
        child: Scaffold(
          backgroundColor: Colors.black,
          body: FutureBuilder(
              future: StageLoader.loadStage(stageNumber),
              builder: (BuildContext ctx, AsyncSnapshot<Stage> snapshot) {
                if (snapshot.hasData) {
                  final Stage stage = snapshot.data;

                  return Center(child: Container(width: 805, height: 620, child: SnakeChef(boardWidth: 10, boardHeight: 10, stage: stage).widget));
                }
                return Container();
              }),
        ));
  }
}
