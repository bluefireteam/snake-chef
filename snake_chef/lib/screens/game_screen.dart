import 'package:flutter/material.dart';
import '../game/game.dart';
import '../game/stage.dart';
import '../stage_loader.dart';
import '../audio_manager.dart';
import '../widgets/direction_pad.dart';
import '../settings_manager.dart';

class GameScreen extends StatelessWidget {
  @override
  Widget build(ctx) {
    AudioManager.loopBackgroundMusic('gameplay');

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

                          final List<Widget> children = [
                            Center(
                                child: Container(
                                    width: snakeChefGame.gameWidgetSize.width,
                                    height: snakeChefGame.gameWidgetSize.height,
                                    child: snakeChefGame.widget
                                )
                            ),
                          ];

                          if (SettingsManager.gamePadOptions.enabled) {
                            children.add(
                                Positioned(
                                    left: 0,
                                    bottom: 0,
                                    child: DirectionPad(
                                        containerSize: SettingsManager.gamePadOptions.size,
                                        opacity: SettingsManager.gamePadOptions.opacity,
                                        onPress: (key) {
                                          snakeChefGame?.onDpadEvent(key);
                                        }
                                    ),
                                ),
                            );
                          }

                          return Stack(children: children);
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
