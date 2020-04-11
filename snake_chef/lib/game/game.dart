import 'package:flame/game.dart';
import 'package:flame/position.dart';
import 'package:flame/time.dart';
import 'package:flame/keyboard.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

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
    board = List.generate(
        boardHeight, (y) => List.generate(boardWidth, (x) => Cell(x: x, y: y)));

    board[5][5].type = CellType.SNAKE_HEAD;
    board[5][6].type = CellType.SNAKE_PART;

    snake.add(Position(5, 5));
    snake.add(Position(6, 5));

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
    for (var i = 0; i < snake.length; i++) {
      Position s = snake[i];

      board[(s.y).toInt()][(s.x).toInt()].type = null;
    }

    snake[0].x = 5;
    snake[0].y = 5;

    snake[1].x = 5;
    snake[1].y = 6;

    removeWidgetOverlay('GameOverMenu');
    timer.start();
  }

  void gameOver() {
    timer.stop();

    addWidgetOverlay(
      'GameOverMenu',
      Center(
        child: Container(
            width: 100,
            height: 100,
            color: const Color(0xFFFF0000),
            child: Column(
              children: [
                Text('Paused'),
                RaisedButton(
                    onPressed: restartGame,
                    child: Text('Restart', style: TextStyle(fontSize: 20)))
              ],
            )),
      ),
    );
  }

  void tick() {
    final head = snake[0];

    final over =
        (head.x + direction.x == boardWidth || head.x + direction.x == -1) ||
            (head.y + direction.y == boardHeight || head.y + direction.y == -1);

    if (over) {
      gameOver();
      return;
    }

    for (var i = snake.length - 1; i >= 0; i--) {
      final snakePart = snake[i];

      if (i == snake.length - 1) {
        board[(snakePart.y).toInt()][(snakePart.x).toInt()].type = null;
      }

      if (i == 0) {
        snakePart.x += direction.x;
        snakePart.y += direction.y;

        board[(snakePart.y).toInt()][(snakePart.x).toInt()].type =
            CellType.SNAKE_HEAD;
      } else {
        snakePart.x = snake[i - 1].x;
        snakePart.y = snake[i - 1].y;

        board[(snakePart.y).toInt()][(snakePart.x).toInt()].type =
            CellType.SNAKE_PART;
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
