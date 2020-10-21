import 'package:flutter/material.dart';
import '../game/game.dart';
import '../game/stage.dart';
import '../stage_loader.dart';
import '../audio_manager.dart';
import '../widgets/direction_pad.dart';
import '../widgets/action_button.dart';
import '../widgets/button.dart';
import '../settings_manager.dart';

class GameScreen extends StatefulWidget {
  @override
  State createState() {
    return _GameScreenState();
  }
}

class _GameScreenState extends State<GameScreen> {
  @override
  Widget build(ctx) {
    AudioManager.gameplayMusic();

    final GameScreenArgs gameScreenArgs = ModalRoute.of(ctx).settings.arguments;

    return LayoutBuilder(
      builder: (ctx, constraints) {
        return Container(
          color: Colors.black,
          child: Scaffold(
            backgroundColor: Colors.black,
            body: FutureBuilder(
              future: StageLoader.loadStage(gameScreenArgs.stageNumber),
              builder: (BuildContext ctx, AsyncSnapshot<Stage> snapshot) {
                if (snapshot.hasData) {
                  final Stage stage = snapshot.data;

                  return GameWrapper(
                    difficult: gameScreenArgs.difficult,
                    stage: stage,
                    size: Size(constraints.maxWidth, constraints.maxHeight),
                  );
                } else if (snapshot.hasError) {
                  print(snapshot.error);
                }

                return Container();
              },
            ),
          ),
        );
      },
    );
  }
}

class GameScreenArgs {
  int stageNumber;
  StageDifficult difficult;

  GameScreenArgs({this.stageNumber, this.difficult});
}

class GameWrapper extends StatefulWidget {
  final Stage stage;
  final Size size;
  final StageDifficult difficult;

  GameWrapper({this.stage, this.size, this.difficult});

  @override
  State<StatefulWidget> createState() {
    return _GameWrapperState();
  }
}

class _GameWrapperState extends State<GameWrapper> with WidgetsBindingObserver {
  SnakeChef snakeChefGame;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    snakeChefGame = SnakeChef(
        screenSize: widget.size,
        boardWidth: 10,
        boardHeight: 10,
        stage: widget.stage,
        stageDifficult: widget.difficult);
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.paused ||
        state == AppLifecycleState.inactive) {
      snakeChefGame?.pause();
    }
  }

  @override
  Widget build(_) {
    final gamepadButtonSize =
        SettingsManager.gamePadOptions.buttonSize * widget.size.height;

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
            borderPercent: SettingsManager.gamePadOptions.borderPercentage,
            opacity: SettingsManager.gamePadOptions.opacity,
            onPress: (key) {
              snakeChefGame?.onDpadEvent(key);
            },
          ),
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
            borderPercent: SettingsManager.gamePadOptions.borderPercentage,
            opacity: SettingsManager.gamePadOptions.opacity,
          ),
        ),
      );
    }

    return Stack(children: children);
  }
}
