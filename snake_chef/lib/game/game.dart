import 'package:flame/game.dart';
import 'package:flame/position.dart';
import 'package:flame/time.dart';
import 'package:flame/components/timer_component.dart';
import 'package:flame/components/particle_component.dart';
import 'package:flame/particles/sprite_particle.dart';
import 'package:flame/particles/rotating_particle.dart';
import 'package:flame/particles/accelerated_particle.dart';
import 'package:flame/particles/translated_particle.dart';
import 'package:flame/particle.dart';
import 'package:flame/gestures.dart';
import 'package:snake_chef/game/assets.dart';
import 'package:snake_chef/game/widgets/game_win.dart';
import 'package:snake_chef/game/widgets/pause_game.dart';
import 'package:snake_chef/settings_manager.dart';

import 'dart:ui';
import 'dart:math';

import './components/game_board.dart';
import './components/top_bar.dart';
import './components/top_left_bar.dart';
import './components/bottom_left_bar.dart';
import './widgets/game_over.dart';
import './stage.dart';
import './cell.dart';
import '../audio_manager.dart';
import '../widgets/direction_pad.dart';

class SnakeChef extends BaseGame
    with
        HasWidgetsOverlay,
        HorizontalDragDetector,
        VerticalDragDetector,
        TapDetector {
  GameBoard gameBoard;
  int boardWidth;
  int boardHeight;

  double _scaleFactor = 1.0;
  Size gameWidgetSize;

  TopLeftBar topLeftBar;
  BottomLeftBar bottomLeftBar;

  Stage stage;
  StageDifficult stageDifficult;
  Timer stageTimerController;
  int stageTimer = 0;

  Recipe get currentRecipe => stage.recipes[recipeIndex];
  int recipeIndex = 0;
  int recipeIndexLabel = 0;

  List<Ingredient> collectedIngredients = [];

  double tickTime;
  Timer tickTimer;
  Timer fastTickTimer;

  // To center the game on the screen
  Position gameOffset;

  bool cantMove;
  bool gameEnded = false;

  SnakeChef(
      {Size screenSize,
      this.boardWidth,
      this.boardHeight,
      this.stage,
      this.stageDifficult}) {
    size = screenSize;
    switch (stageDifficult) {
      case StageDifficult.NORMAL:
        tickTime = 0.5;
        break;
      case StageDifficult.MEDIUM:
        tickTime = 0.4;
        break;
      case StageDifficult.HARD:
        tickTime = 0.22;
        break;
    }

    final gameboardOffset = Position(300, 100);
    add(gameBoard = GameBoard(
      boardHeight: boardHeight,
      boardWidth: boardWidth,
      renderOffset: gameboardOffset,
    ));

    final boardScreenWidth = boardWidth * Cell.cellSize;
    add(TopBar()
      ..x = gameboardOffset.x
      ..height = gameboardOffset.y
      ..width = boardScreenWidth);

    final boardScreenHeight = (boardHeight * Cell.cellSize);
    final middleY = (boardScreenHeight + gameboardOffset.y) / 2;
    add(topLeftBar = TopLeftBar()
      ..x = 0
      ..height = middleY
      ..width = gameboardOffset.x);

    add(bottomLeftBar = BottomLeftBar()
      ..x = 0
      ..y = middleY
      ..height = middleY
      ..width = gameboardOffset.x);

    tickTimer = Timer(tickTime, repeat: true, callback: tick)..start();
    fastTickTimer = Timer(tickTime / 3, repeat: true, callback: tick);

    add(TimerComponent(tickTimer));
    add(TimerComponent(fastTickTimer));

    stageTimer = stage.time;
    stageTimerController = Timer(1, repeat: true, callback: () {
      stageTimer--;
      if (stageTimer == 0) {
        gameOver(label: "Time's Up!");
      }
    })
      ..start();

    add(TimerComponent(stageTimerController));

    final gameHeight = gameboardOffset.y + boardScreenHeight;
    final gameWidth = gameboardOffset.x + boardScreenWidth;

    final scaleRaw = min(size.height / gameHeight, size.width / gameWidth);
    _scaleFactor = scaleRaw - scaleRaw % 0.02;

    gameWidgetSize = Size(
      gameWidth * _scaleFactor,
      gameHeight * _scaleFactor,
    );

    gameOffset = Position(
      size.width / 2 - gameWidgetSize.width / 2,
      0,
    );
  }

  void pause() {
    if (!gameEnded) {
      pauseEngine();

      addWidgetOverlay(
        'PauseGameMenu',
        PauseGame(resumeGame: resume),
      );
    }
  }

  void resume() {
    resumeEngine();

    removeWidgetOverlay('PauseGameMenu');
  }

  void tick() {
    if (!gameEnded) {
      cantMove = false;
      gameBoard.tick();
    }
  }

  @override
  void render(Canvas canvas) {
    canvas.save();
    canvas.translate(gameOffset.x, gameOffset.y);
    canvas.scale(_scaleFactor, _scaleFactor);
    super.render(canvas);
    canvas.restore();
  }

  void restartGame() {
    gameEnded = false;
    AudioManager.gameplayMusic();
    hideGameOver();
    recipeIndex = 0;
    recipeIndexLabel = 0;
    collectedIngredients = [];

    cantMove = false;
    stageTimer = 0;
    stageTimerController.start();

    bottomLeftBar.reset();
    gameBoard.resetBoard();
    stageTimer = stage.time;
    tickTimer.start();
  }

  void stopGame() {
    tickTimer.stop();
    fastTickTimer.stop();
    stageTimerController.stop();
    cantMove = true;
  }

  void gameOver({String label}) {
    gameEnded = true;

    print(
        "recipeIndex: $recipeIndex / tickTimer: ${tickTimer.current} / stageTimerController: ${stageTimerController.current} / collectedItems: $collectedIngredients");
    AudioManager.gameoverMusic();
    stopGame();

    showGameOver(label: label);
  }

  void collectIngredient(Ingredient ingredient) {
    if (currentRecipe.validIngredient(ingredient) &&
        currentRecipe.validRecipe(ingredient, collectedIngredients)) {
      AudioManager.collectSfx();

      collectedIngredients.add(ingredient);
      gameBoard.spawnIngredient(ingredient);

      if (currentRecipe.ingredients.length == collectedIngredients.length) {
        if (currentRecipe.checkCompletion(collectedIngredients)) {
          collectedIngredients = [];

          if (recipeIndex + 1 < stage.recipes.length) {
            AudioManager.recipeDoneSfx();
            recipeIndexLabel++;
            recipeIndex++;
            topLeftBar.justCompletedOrder();
            bottomLeftBar.justCompletedOrder();
          } else {
            gameEnded = true;
            recipeIndexLabel++;

            stopGame();
            AudioManager.winMusic();
            addCelebrationComponent();
            showGameWin();
            SettingsManager.stageProgress
                .updateStageProgress(stageDifficult, stage.stageNumber);
            SettingsManager.save();
          }
        } else {
          gameOver();
        }
      }
    } else {
      gameOver();
    }
  }

  void addCelebrationComponent() {
    final allIngredients = stage.stageIngredients();
    final random = Random();
    add(ParticleComponent(
        particle: Particle.generate(
      count: 10,
      lifespan: 2,
      generator: (i) => TranslatedParticle(
        offset: Offset(gameWidgetSize.width / 2, gameWidgetSize.height / 2),
        child: AcceleratedParticle(
          speed:
              Offset(random.nextDouble() * 1000, -random.nextDouble() * 1000) *
                  .5,
          acceleration: Offset(random.nextBool() ? -100 : 100, 400),
          child: RotatingParticle(
              from: random.nextDouble() * pi,
              child: SpriteParticle(
                  size: Position(Cell.cellSize * 2, Cell.cellSize * 2),
                  sprite: Ingredients.getSprite(
                      allIngredients[random.nextInt(allIngredients.length)]))),
        ),
      ),
    )));
  }

  void onDpadEvent(DpadKey key) {
    if (cantMove) return;

    cantMove = true;
    if (key == DpadKey.RIGHT) {
      gameBoard.snake.turnRight();
    } else if (key == DpadKey.LEFT) {
      gameBoard.snake.turnLeft();
    } else if (key == DpadKey.UP) {
      gameBoard.snake.turnUp();
    } else if (key == DpadKey.DOWN) {
      gameBoard.snake.turnDown();
    }
  }

  @override
  void onHorizontalDragEnd(details) {
    if (cantMove) return;
    cantMove = true;

    if (details.velocity.pixelsPerSecond.dx > 0) {
      gameBoard.snake.turnRight();
    } else {
      gameBoard.snake.turnLeft();
    }
  }

  @override
  void onVerticalDragEnd(details) {
    if (cantMove) return;
    cantMove = true;

    if (details.velocity.pixelsPerSecond.dy > 0) {
      gameBoard.snake.turnDown();
    } else {
      gameBoard.snake.turnUp();
    }
  }

  void enableFastMode() {
    tickTimer.pause();
    fastTickTimer.resume();
  }

  void disableFastMode() {
    tickTimer.resume();
    fastTickTimer.pause();
  }

  @override
  void onTapDown(_) {
    enableFastMode();
  }

  @override
  void onTapUp(_) {
    disableFastMode();
  }

  @override
  void onTapCancel() {
    disableFastMode();
  }

  void showGameOver({String label}) {
    addWidgetOverlay(
      'GameOverMenu',
      GameOver(restartGame: restartGame, label: label ?? "Game Over"),
    );
  }

  void showGameWin() {
    addWidgetOverlay(
      'GameWinMenu',
      GameWin(),
    );
    addCelebrationComponent();
  }

  void hideGameOver() {
    removeWidgetOverlay('GameOverMenu');
  }
}
