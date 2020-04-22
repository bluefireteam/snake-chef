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
import 'package:snake_chef/game/widgets/game_win.dart';

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
import './ingredient_renderer.dart';
import '../widgets/direction_pad.dart';

class SnakeChef extends BaseGame with HasWidgetsOverlay, HorizontalDragDetector, VerticalDragDetector {
  GameBoard gameBoard;
  int boardWidth;
  int boardHeight;

  double _scaleFactor = 1.0;
  Size gameWidgetSize;

  TopLeftBar topLeftBar;
  BottomLeftBar bottomLeftBar;

  Stage stage;
  Timer stageTimerController;
  int stageTimer = 0;

  Recipe get currentRecipe => stage.recipes[recipeIndex];
  int recipeIndex = 0;
  int recipeLabelCounter = 1;

  List<Ingredient> collectedIngredients = [];
  Timer timer;

  SnakeChef({Size screenSize, this.boardWidth, this.boardHeight, this.stage}) {
    size = screenSize;

    final renderOffset = Position(300, 100);
    add(gameBoard = GameBoard(
      boardHeight: boardHeight,
      boardWidth: boardWidth,
      renderOffset: renderOffset,
    ));

    final boardScreenWidth = boardWidth * Cell.cellSize;
    add(TopBar()
      ..x = renderOffset.x
      ..height = renderOffset.y
      ..width = boardScreenWidth);

    final boardScreenHeight = (boardHeight * Cell.cellSize);
    final middleY = (boardScreenHeight + renderOffset.y) / 2;
    add(topLeftBar = TopLeftBar()
      ..x = 0
      ..height = middleY
      ..width = renderOffset.x);

    add(bottomLeftBar = BottomLeftBar()
      ..x = 0
      ..y = middleY
      ..height = middleY
      ..width = renderOffset.x);

    timer = Timer(0.5, repeat: true, callback: gameBoard.tick)..start();
    add(TimerComponent(timer));

    stageTimer = stage.time;
    stageTimerController = Timer(1, repeat: true, callback: () {
      stageTimer--;
      if (stageTimer == 0) {
        gameOver(label: "Time's Up!");
      }
    })
      ..start();

    add(TimerComponent(stageTimerController));

    final gameHeight = renderOffset.y + boardScreenHeight;
    final gameWidth = renderOffset.x + boardScreenWidth;

    _scaleFactor = min(size.height / gameHeight, size.width / gameWidth);

    gameWidgetSize = Size(
      gameWidth * _scaleFactor,
      gameHeight * _scaleFactor,
    );
  }

  @override
  void render(Canvas canvas) {
    canvas.save();
    canvas.scale(_scaleFactor, _scaleFactor);
    super.render(canvas);
    canvas.restore();
  }

  void restartGame() {
    AudioManager.loopBackgroundMusic('gameplay.ogg');
    hideGameOver();
    recipeIndex = 0;
    recipeLabelCounter = 0;
    collectedIngredients = [];

    stageTimer = 0;
    stageTimerController.start();

    bottomLeftBar.reset();
    gameBoard.resetBoard();
    stageTimer = stage.time;
    timer.start();
  }

  void gameOver({String label}) {
    AudioManager.playBackgroundMusic('gameover.ogg');
    timer.stop();
    showGameOver(label: label);

    stageTimerController.stop();
  }

  void collectIngredient(Ingredient ingredient) {
    if (currentRecipe.validIngredient(ingredient)) {
      AudioManager.playSfx('ingredient_collected.wav');

      collectedIngredients.add(ingredient);
      gameBoard.spawnIngredient(ingredient);

      if (currentRecipe.ingredients.length == collectedIngredients.length) {
        if (currentRecipe.checkCompletion(collectedIngredients)) {
          collectedIngredients = [];

          recipeLabelCounter++;
          if (recipeIndex + 1 < stage.recipes.length) {
            AudioManager.playSfx('recipe_done.wav');
            recipeIndex++;
            topLeftBar.justCompletedOrder();
            bottomLeftBar.justCompletedOrder();
          } else {
            AudioManager.playBackgroundMusic('win_fanfarre.ogg');
            addCelebrationComponent();
            timer.stop();
            showGameWin();
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
          speed: Offset(random.nextDouble() * 1000, -random.nextDouble() * 1000) * .5,
          acceleration: Offset(random.nextBool() ? -100 : 100, 400),
          child: RotatingParticle(
              from: random.nextDouble() * pi,
              child: SpriteParticle(
                  size: Position(Cell.cellSize * 2, Cell.cellSize * 2),
                  sprite: mapIngredientSprite(allIngredients[random.nextInt(allIngredients.length)]))),
        ),
      ),
    )));
  }

  void onDpadEvent(DpadKey key) {
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
    if (details.velocity.pixelsPerSecond.dx > 0) {
      gameBoard.snake.turnRight();
    } else {
      gameBoard.snake.turnLeft();
    }
  }

  @override
  void onVerticalDragEnd(details) {
    if (details.velocity.pixelsPerSecond.dy > 0) {
      gameBoard.snake.turnDown();
    } else {
      gameBoard.snake.turnUp();
    }
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
