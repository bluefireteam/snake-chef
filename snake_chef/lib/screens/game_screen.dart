import 'package:flutter/material.dart';
import '../game/game.dart';
import '../game/stage.dart';
import '../stage_loader.dart';
import '../audio_manager.dart';
import '../widgets/direction_pad.dart';
import '../widgets/button.dart';
import '../settings_manager.dart';

class GameScreen extends StatelessWidget {
  @override
  Widget build(ctx) {
    AudioManager.gameplayMusic();

    final stageNumber = ModalRoute.of(ctx).settings.arguments;

    return LayoutBuilder(builder: (ctx, constraints) {
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
                    final snakeChefGame = SnakeChef(screenSize: size, boardWidth: 10, boardHeight: 10, stage: stage);

                    final List<Widget> children = [snakeChefGame.widget];

                    children.add(
                      Positioned(
                        right: 10,
                        top: 10,
                        child: Button.dpadButton(
                          label: '||',
                          width: 50,
                          onPressed: () {
                            snakeChefGame?.pause();
                          },
                        ),
                      ),
                    );

                    if (SettingsManager.gamePadOptions.enabled) {
                      children.add(
                        Positioned(
                          left: 0,
                          bottom: 0,
                          child: DirectionPad(
                              containerSize: SettingsManager.gamePadOptions.dpadSize,
                              opacity: SettingsManager.gamePadOptions.opacity,
                              onPress: (key) {
                                snakeChefGame?.onDpadEvent(key);
                              }),
                        ),
                      );

                      children.add(
                        Positioned(
                          right: 0,
                          bottom: 20,
                          child: Opacity(
                              opacity: SettingsManager.gamePadOptions.opacity,
                              child: Button.dpadButton(
                                width: SettingsManager.gamePadOptions.actionButtonSize,
                                height: SettingsManager.gamePadOptions.actionButtonSize,
                                onPress: () {
                                  snakeChefGame.enableFastMode();
                                },
                                onPressReleased: () {
                                  snakeChefGame.disableFastMode();
                                },
                              )),
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
    });
  }
}
