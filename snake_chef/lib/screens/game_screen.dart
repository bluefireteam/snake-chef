import 'package:flutter/material.dart';
import '../game/game.dart';
import '../game/stage.dart';
import '../stage_loader.dart';
import '../audio_manager.dart';
import '../widgets/direction_pad.dart';
import '../widgets/action_button.dart';
import '../widgets/button.dart';
import '../settings_manager.dart';

class GameScreen extends StatelessWidget {
  @override
  Widget build(ctx) {
    AudioManager.gameplayMusic();

    final GameScreenArgs gameScreenArgs = ModalRoute.of(ctx).settings.arguments;

    return LayoutBuilder(builder: (ctx, constraints) {
      final gamepadButtonSize = SettingsManager.gamePadOptions.buttonSize * constraints.maxHeight;
      return Container(
          color: Colors.black,
          child: Scaffold(
            backgroundColor: Colors.black,
            body: FutureBuilder(
                future: StageLoader.loadStage(gameScreenArgs.stageNumber),
                builder: (BuildContext ctx, AsyncSnapshot<Stage> snapshot) {
                  if (snapshot.hasData) {
                    final Stage stage = snapshot.data;
                    final size = Size(constraints.maxWidth, constraints.maxHeight);
                    final snakeChefGame =
                        SnakeChef(screenSize: size, boardWidth: 10, boardHeight: 10, stage: stage, stageDifficult: gameScreenArgs.difficult);

                    final List<Widget> children = [snakeChefGame.widget];

                    children.add(
                      Positioned(
                        right: 10,
                        top: 10,
                        child: Button(
                          buttonType: ButtonType.SILVER,
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
                              containerSize: gamepadButtonSize,
                              opacity: SettingsManager.gamePadOptions.opacity,
                              onPress: (key) {
                                snakeChefGame?.onDpadEvent(key);
                              }),
                        ),
                      );

                      children.add(
                        Positioned(
                          right: 0,
                          bottom: 0,
                          child: ActionButton(
                              onAction: () {
                                snakeChefGame?.enableFastMode();
                              },
                              onActionRelease: () {
                                snakeChefGame?.disableFastMode();
                              },
                              dpadSize: gamepadButtonSize,
                              opacity: SettingsManager.gamePadOptions.opacity,
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
    });
  }
}

class GameScreenArgs {
  int stageNumber;
  StageDifficult difficult;

  GameScreenArgs({this.stageNumber, this.difficult});
}
