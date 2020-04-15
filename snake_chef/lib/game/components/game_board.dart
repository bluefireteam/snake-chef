import 'package:flame/components/component.dart';
import 'package:flame/components/mixins/has_game_ref.dart';
import 'package:flame/position.dart';
import 'package:flame/time.dart';
import 'package:flutter/material.dart';
import 'package:snake_chef/game/game.dart';
import 'package:snake_chef/game/stage.dart';

import 'dart:ui';
import '../cell.dart';

class GameBoard extends Component with HasGameRef<SnakeChef> {
  List<List<Cell>> board;
  Timer timer;
  List<Position> snake = [];
  Position direction = Position(-1, 0);
  int boardWidth;
  int boardHeight;

  GameBoard({this.boardWidth, this.boardHeight});

  @override
  void onMount() {
    resetGame();
  }

  void resetGame() {
    board = List.generate(boardHeight, (y) => List.generate(boardWidth, (x) => Cell(x: x, y: y)));

    board[gameRef.stage.initialY][gameRef.stage.initialX].type = SnakeCell(SnakeCellType.HEAD);
    board[gameRef.stage.initialY][gameRef.stage.initialX + 1].type = SnakeCell(SnakeCellType.PART);

    // TODO Read from stage to spawn all ingredients
    board[2][3].type = IngredientCell(Ingredient.TOMATO);
    board[1][5].type = IngredientCell(Ingredient.LETTUCE);
    board[6][9].type = IngredientCell(Ingredient.TOMATO);
    board[3][1].type = IngredientCell(Ingredient.LETTUCE);
    board[3][7].type = IngredientCell(Ingredient.TOMATO);
    board[7][4].type = IngredientCell(Ingredient.LETTUCE);

    snake = [];
    snake.add(Position(5, 5));
    snake.add(Position(6, 5));

    direction = Position(-1, 0);

    timer = Timer(0.5, repeat: true, callback: tick)..start();
  }

  void turnRight() {
    if (direction.y != 0) {
      direction.x = 1;
      direction.y = 0;
    }
  }

  void turnLeft() {
    if (direction.y != 0) {
      direction.x = -1;
      direction.y = 0;
    }
  }

  void turnUp() {
    if (direction.x != 0) {
      direction.y = -1;
      direction.x = 0;
    }
  }

  void turndown() {
    if (direction.x != 0) {
      direction.y = 1;
      direction.x = 0;
    }
  }

  void restartGame() {
    gameRef.hideGameOver();
    gameRef.recipeIndex = 0;
    gameRef.collectedIngredients = [];
    resetGame();
  }

  void gameOver() {
    timer.stop();
    gameRef.showGameOver();
  }

  void tick() {
    final head = snake[0];

    final newX = head.x + direction.x;
    final newY = head.y + direction.y;

    if ((newX == boardWidth || newX == -1) || (newY == boardHeight || newY == -1)) {
      gameOver();
      return;
    }

    final objectInFrontOfSnake = board[newY.toInt()][newX.toInt()].type;

    if (objectInFrontOfSnake is SnakeCell && objectInFrontOfSnake.type == SnakeCellType.PART) {
      gameOver();
      return;
    }

    for (var i = snake.length - 1; i >= 0; i--) {
      final snakePart = snake[i];

      if (i == snake.length - 1) {
        if (objectInFrontOfSnake != null && objectInFrontOfSnake is IngredientCell) {
          snake.add(Position(snakePart.x, snakePart.y));
          gameRef.collectIngredient(objectInFrontOfSnake.ingredient);
        } else {
          board[(snakePart.y).toInt()][(snakePart.x).toInt()].type = null;
        }
      }

      if (i == 0) {
        snakePart.x += direction.x;
        snakePart.y += direction.y;

        board[(snakePart.y).toInt()][(snakePart.x).toInt()].type = SnakeCell(SnakeCellType.HEAD);
      } else {
        snakePart.x = snake[i - 1].x;
        snakePart.y = snake[i - 1].y;

        board[(snakePart.y).toInt()][(snakePart.x).toInt()].type = SnakeCell(SnakeCellType.PART);
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
        cell.render(canvas, this);
      }
    }
  }
}
