import 'dart:math';

import 'package:flame/components/component.dart';
import 'package:flame/components/mixins/has_game_ref.dart';
import 'package:flame/position.dart';
import 'package:flutter/material.dart';
import 'package:snake_chef/game/game.dart';
import 'package:snake_chef/game/snake.dart';
import 'package:snake_chef/game/stage.dart';
import 'package:snake_chef/game/assets.dart' hide Snake;

import 'dart:ui';
import '../cell.dart';
import '../layer.dart';

class BackgroundLayer extends DynamicLayer {
  GameBoard board;

  BackgroundLayer(this.board);

  @override
  void drawLayer() {
    for (var y = 0; y < board.board.length; y++) {
      for (var x = 0; x < board.board[y].length; x++) {
        final cell = board.board[y][x];
        final rect = Rect.fromLTWH(x * Cell.cellSize, y * Cell.cellSize, Cell.cellSize, Cell.cellSize);

        if (cell.type is ObstacleCell) {
          cell.render(canvas, board);
        } else {
          Floor.getFloorTile().renderRect(canvas, rect);
        }

        if (board.board.length - 1 == y) {
          Floor.getFloorBorder().renderRect(canvas, rect.translate(0, Cell.cellSize));
        }
      }
    }
  }
}

class GameBoardLayer extends DynamicLayer {
  GameBoard board;

  GameBoardLayer(this.board) {
    preProcessors.add(
        ShadowProcessor(
            offset: Offset(8, 8),
            color: Color(0xFF1a1c2c),
        )
    );
  }

  @override
  void drawLayer() {
    for (var y = 0; y < board.board.length; y++) {
      for (var x = 0; x < board.board[y].length; x++) {
        final cell = board.board[y][x];
        if (!(cell.type is ObstacleCell)) {
          cell.render(canvas, board);
        }
      }
    }
  }
}

class GameBoard extends Component with HasGameRef<SnakeChef> {
  List<List<Cell>> board;
  Position renderOffset;
  int boardWidth;
  int boardHeight;
  BackgroundLayer backgroundLayer;
  GameBoardLayer gameLayer;

  Snake snake;

  GameBoard({this.boardWidth, this.boardHeight, this.renderOffset}) {
    backgroundLayer = BackgroundLayer(this);
    gameLayer = GameBoardLayer(this);
  }

  @override
  void onMount() {
    resetBoard();
  }

  void resetBoard() {
    board = List.generate(boardHeight, (y) => List.generate(boardWidth, (x) => Cell(x: x, y: y)));

    board[gameRef.stage.initialY][gameRef.stage.initialX].type = SnakeCell(SnakeCellType.HEAD);
    board[gameRef.stage.initialY][gameRef.stage.initialX + 1].type = SnakeCell(SnakeCellType.PART);

    snake = Snake()
      ..body.add(Position(gameRef.stage.initialX.toDouble(), gameRef.stage.initialY.toDouble()))
      ..body.add(Position((gameRef.stage.initialX.toDouble() + 1), gameRef.stage.initialY.toDouble()))
      ..direction = Position(-1, 0);

    gameRef.stage.obstacles.forEach((obstacle) {
      board[obstacle.y.toInt()][obstacle.x.toInt()].type = ObstacleCell(obstacle);
    });

    gameRef.stage.stageIngredients().forEach((ingredient) {
      final emptyPosition = getRandomEmptySpace();
      board[emptyPosition.y.toInt()][emptyPosition.x.toInt()].type = IngredientCell(ingredient);
    });
  }

  Position getRandomEmptySpace() {
    List<Position> emptySpaces = [];

    Position nextSnakeSpace = snake.nextPosition();

    for (var y = 0; y < board.length; y++) {
      for (var x = 0; x < board[y].length; x++) {
        if (board[y][x].type == null && (nextSnakeSpace.x != x && nextSnakeSpace.y != y)) {
          emptySpaces.add(Position(x.toDouble(), y.toDouble()));
        }
      }
    }

    return emptySpaces[Random().nextInt(emptySpaces.length - 1)];
  }

  void spawnIngredient(Ingredient ingredient) {
    final emptyPosition = getRandomEmptySpace();
    board[emptyPosition.y.toInt()][emptyPosition.x.toInt()].type = IngredientCell(ingredient);
  }

  void tick() {
    final head = snake.body[0];

    final newX = head.x + snake.direction.x;
    final newY = head.y + snake.direction.y;

    if ((newX == boardWidth || newX == -1) || (newY == boardHeight || newY == -1)) {
      gameRef.gameOver();
      return;
    }

    final objectInFrontOfSnake = board[newY.toInt()][newX.toInt()].type;

    if (objectInFrontOfSnake is ObstacleCell || objectInFrontOfSnake is SnakeCell) {
      gameRef.gameOver();
      return;
    }

    for (var i = snake.body.length - 1; i >= 0; i--) {
      final snakePart = snake.body[i];

      if (i == snake.body.length - 1) {
        if (objectInFrontOfSnake != null && objectInFrontOfSnake is IngredientCell) {
          snake.body.add(Position(snakePart.x, snakePart.y));
          gameRef.collectIngredient(objectInFrontOfSnake.ingredient);
        } else {
          board[(snakePart.y).toInt()][(snakePart.x).toInt()].type = null;
        }
      }

      if (i == 0) {
        snakePart.x += snake.direction.x;
        snakePart.y += snake.direction.y;

        board[(snakePart.y).toInt()][(snakePart.x).toInt()].type = SnakeCell(SnakeCellType.HEAD);
      } else {
        snakePart.x = snake.body[i - 1].x;
        snakePart.y = snake.body[i - 1].y;

        board[(snakePart.y).toInt()][(snakePart.x).toInt()].type = SnakeCell(SnakeCellType.PART);
      }
    }
  }

  @override
  void update(double delta) {}

  @override
  void render(Canvas canvas) {
    backgroundLayer.render(canvas, x: renderOffset.x, y: renderOffset.y);
    gameLayer.render(canvas, x: renderOffset.x, y: renderOffset.y);
  }
}
