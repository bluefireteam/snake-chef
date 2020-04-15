import 'package:flame/game.dart';
import 'package:flame/keyboard.dart';
import 'package:flutter/services.dart';

import './components/game_board.dart';
import './widgets/game_over.dart';
import './stage.dart';

class SnakeChef extends BaseGame with KeyboardEvents, HasWidgetsOverlay {
  GameBoard gameBoard;
  int boardWidth;
  int boardHeight;
  Stage stage;
  int recipeIndex = 0;

  Recipe get currentRecipe => stage.recipes[recipeIndex];

  List<Ingredient> collectedIngredients = [];

  SnakeChef({this.boardWidth, this.boardHeight, this.stage}) {
    add(gameBoard = GameBoard(boardHeight: boardHeight, boardWidth: boardWidth));
  }

  void collectIngredient(Ingredient ingredient) {
    print(ingredient);
    if (currentRecipe.validIngredient(ingredient)) {
      collectedIngredients.add(ingredient);

      if (currentRecipe.ingredients.length == collectedIngredients.length) {
        if (currentRecipe.checkCompletion(collectedIngredients)) {
          collectedIngredients = [];

          if (recipeIndex + 1 < stage.recipes.length) {
            print("next recipe");
            recipeIndex++;
          } else {
            // TODO show win and go to next level
            print("Ganhouuuuu");
          }
        } else {
          gameBoard.gameOver();
        }
      }
    } else {
      gameBoard.gameOver();
    }
  }

  void onKeyEvent(event) {
    if (event is RawKeyUpEvent) {
      final key = event.data.keyLabel;

      if (key == "ArrowRight") {
        gameBoard.turnRight();
      } else if (key == "ArrowLeft") {
        gameBoard.turnLeft();
      } else if (key == "ArrowUp") {
        gameBoard.turnUp();
      } else if (key == "ArrowDown") {
        gameBoard.turndown();
      }
    }
  }

  void showGameOver() {
    addWidgetOverlay(
      'GameOverMenu',
      GameOver(restartGame: gameBoard.restartGame),
    );
  }

  void hideGameOver() {
    removeWidgetOverlay('GameOverMenu');
  }
}
