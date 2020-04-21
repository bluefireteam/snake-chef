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

    return LayoutBuilder(
        builder: (ctx, constraints) {
          return Container(
              color: Colors.black,
              child: Scaffold(
                  backgroundColor: Colors.black,
                  body: FutureBuilder(
                      future: StageLoader.loadStage(stageNumber),
                      builder: (BuildContext ctx, AsyncSnapshot<Stage> snapshot) {
                        if (snapshot.hasData) {
                          final Stage stage = snapshot.data;
                          final size = Size(constraints.maxWidth, constraints.maxHeight);
                          final snakeChefGame = SnakeChef(
                              screenSize: size,
                              boardWidth: 10,
                              boardHeight: 10,
                              stage: stage
                          );

                          return Center(
                              child: Container(
                                  width: snakeChefGame.gameWidgetSize.width,
                                  height: snakeChefGame.gameWidgetSize.height,
                                  child: snakeChefGame.widget
                              )
                          );
                        } else if (snapshot.hasError) {
                          print(snapshot.error);
                        }

                        return Container();
                      }),
              ));
        }
    );
  }
}
