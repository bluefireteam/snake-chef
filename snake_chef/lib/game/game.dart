import 'package:flame/game.dart';
import 'package:flame/position.dart';
import 'package:flame/time.dart';
import 'package:flame/keyboard.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:snake_chef/game/widgets/game_over.dart';

import 'dart:ui';

import './cell.dart';

class SnakeChef extends Game with KeyboardEvents, HasWidgetsOverlay {
  List<List<Cell>> board;
  Timer timer;
  List<Position> snake = [];
  Position direction = Position(-1, 0);
  int boardWidth;
  int boardHeight;

  SnakeChef({this.boardWidth, this.boardHeight}) {
    resetGame();
  }

  void resetGame() {
    board = List.generate(
        boardHeight, (y) => List.generate(boardWidth, (x) => Cell(x: x, y: y)));

    board[5][5].type = CellType.SNAKE_HEAD;
    board[5][6].type = CellType.SNAKE_PART;

    board[2][3].type = CellType.INGREDIENT_TOMATO;
    board[4][8].type = CellType.INGREDIENT_LETTUCE;

    snake = [];
    snake.add(Position(5, 5));
    snake.add(Position(6, 5));

    direction = Position(-1, 0);

    timer = Timer(0.5, repeat: true, callback: tick)..start();
  }

  void onKeyEvent(event) {
    if (event is RawKeyUpEvent) {
      final key = event.data.keyLabel;

      if (key == "ArrowRight" && direction.y != 0) {
        direction.x = 1;
        direction.y = 0;
      } else if (key == "ArrowLeft" && direction.y != 0) {
        direction.x = -1;
        direction.y = 0;
      } else if (key == "ArrowUp" && direction.x != 0) {
        direction.y = -1;
        direction.x = 0;
      } else if (key == "ArrowDown" && direction.x != 0) {
        direction.y = 1;
        direction.x = 0;
      }
    }
  }

  void restartGame() {
    removeWidgetOverlay('GameOverMenu');
    resetGame();
  }

  void gameOver() {
    timer.stop();

    addWidgetOverlay(
      'GameOverMenu',
      GameOver(restartGame: restartGame),
    );
  }

  void tick() {
    final head = snake[0];

    final newX = head.x + direction.x;
    final newY = head.y + direction.y;

    final objectInFrontOfSnake = board[newY.toInt()][newX.toInt()].type;
    
    if ((newX == boardWidth || newX == -1) || (newY == boardHeight || newY == -1) || objectInFrontOfSnake == CellType.SNAKE_PART) {
      gameOver();
      return;
    }


    for (var i = snake.length - 1; i >= 0; i--) {
      final snakePart = snake[i];

      if (i == snake.length - 1) {
        if (objectInFrontOfSnake != null && objectInFrontOfSnake.toString().startsWith("CellType.INGREDIENT")) {
          snake.add(Position(snakePart.x, snakePart.y));
        } else {
          board[(snakePart.y).toInt()][(snakePart.x).toInt()].type = null;
        }
      }

      if (i == 0) {
        snakePart.x += direction.x;
        snakePart.y += direction.y;

        board[(snakePart.y).toInt()][(snakePart.x).toInt()].type = CellType.SNAKE_HEAD;
      } else {
        snakePart.x = snake[i - 1].x;
        snakePart.y = snake[i - 1].y;

        board[(snakePart.y).toInt()][(snakePart.x).toInt()].type = CellType.SNAKE_PART;
      }
    }
  }

  @override
  void update(double delta) {
    timer.update(delta);
  }

  @override
  void render(Canvas canvas) {
    for (var y = 0; y < board.length; y++) {
      for (var x = 0; x < board[y].length; x++) {
        final cell = board[y][x];
        cell.render(canvas);
      }
    }
    canvas.drawRect(
        Rect.fromLTWH(
            0, 0, boardWidth * Cell.cellSize, boardHeight * Cell.cellSize),
        _white);
  }

  final Paint _white = Paint()
    ..color = Color(0xFFFFFFFF)
    ..style = PaintingStyle.stroke
    ..strokeWidth = 2;
}
