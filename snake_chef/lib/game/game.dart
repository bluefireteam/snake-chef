import 'package:flame/game.dart';
import 'package:flame/keyboard.dart';
import 'package:flutter/services.dart';

import './components/game_board.dart';
import './widgets/game_over.dart';

class SnakeChef extends BaseGame with KeyboardEvents, HasWidgetsOverlay {
  GameBoard gameBoard;
  int boardWidth;
  int boardHeight;

  SnakeChef({this.boardWidth, this.boardHeight}) {
    add(gameBoard = GameBoard(boardHeight: boardHeight, boardWidth: boardWidth));
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
