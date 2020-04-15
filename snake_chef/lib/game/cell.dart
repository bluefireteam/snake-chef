import 'dart:ui';

import 'package:flame/sprite.dart';
import 'package:flutter/material.dart';
import 'package:snake_chef/game/assets.dart';
import 'package:snake_chef/game/components/game_board.dart';
import 'package:snake_chef/game/stage.dart';

class Cell {
  Cell({this.x, this.y});
  static const double cellSize = 50;

  int x;
  int y;
  CellType type;

  void render(Canvas canvas, GameBoard gameBoard) {
    final rect = Rect.fromLTWH(x * Cell.cellSize, y * Cell.cellSize, Cell.cellSize, Cell.cellSize);
    Floor.getFloorTile().renderRect(canvas, rect);

    type?.render(canvas, gameBoard, this, rect);

    if (gameBoard.board.length - 1 == y) {
      Floor.getFloorBorder().renderRect(canvas, rect.translate(0, Cell.cellSize));
    }
  }
}

abstract class CellType {
  void render(Canvas canvas, GameBoard gameBoard, Cell cell, Rect rect);
}

class IngredientCell extends CellType {
  Ingredient ingredient;

  IngredientCell(this.ingredient);

  @override
  void render(Canvas canvas, GameBoard gameBoard, Cell cell, Rect rect) {
    if (ingredient == Ingredient.TOMATO) {
      Ingredients.getTomato().renderRect(canvas, rect);
    }
    if (ingredient == Ingredient.LETTUCE) {
      Ingredients.getLettuce().renderRect(canvas, rect);
    }
  }
}

enum SnakeCellType { HEAD, PART }

class SnakeCell extends CellType {
  SnakeCellType type;

  SnakeCell(this.type);

  @override
  void render(Canvas canvas, GameBoard gameBoard, Cell cell, Rect rect) {
    if (type == SnakeCellType.HEAD) {
      Sprite sprite;

      final head = gameBoard.snake[0];
      final next = gameBoard.snake[1];

      if (gameBoard.direction.x == 1) {
        if (head.y == next.y) {
          sprite = Snake.getHeadFacingRight();
        } else if (head.y > next.y) {
          sprite = Snake.getHeadCornerBottomRight();
        } else if (head.y < next.y) {
          sprite = Snake.getHeadCornerTopRight();
        }
      } else if (gameBoard.direction.x == -1) {
        if (head.y == next.y) {
          sprite = Snake.getHeadFacingLeft();
        } else if (head.y > next.y) {
          sprite = Snake.getHeadCornerBottomLeft();
        } else if (head.y < next.y) {
          sprite = Snake.getHeadCornerTopLeft();
        }
      } else if (gameBoard.direction.y == 1) {
        sprite = Snake.getHeadFacingDown();
      } else if (gameBoard.direction.y == -1) {
        sprite = Snake.getHeadFacingUp();
      }

      sprite.renderRect(canvas, rect);
    }
    if (type == SnakeCellType.PART) {
      final partIndex = gameBoard.snake.indexWhere((element) => element.x == cell.x && element.y == cell.y);
      final previous = gameBoard.snake[partIndex - 1];

      Sprite sprite;

      if (partIndex + 1 == gameBoard.snake.length) {
        if (cell.x < previous.x) {
          sprite = Snake.getTailFacingLeft();
        } else if (cell.x > previous.x) {
          sprite = Snake.getTailFacingRight();
        } else if (cell.y < previous.y) {
          sprite = Snake.getTailFacingUp();
        } else if (cell.y > previous.y) {
          sprite = Snake.getTailFacingDown();
        }
      } else {
        final next = gameBoard.snake[partIndex + 1];

        if (cell.x == previous.x && cell.x == next.x) {
          sprite = Snake.getTopViewBodyPart();
        } else if (cell.y == previous.y && cell.y == next.y) {
          sprite = Snake.getSideViewBodyPart();
        } else if ((next.x > cell.x && previous.y < cell.y) || (next.y < cell.y && previous.x > cell.x)) {
          sprite = Snake.getBottomLeftCorner();
        } else if ((next.x > cell.x && previous.y > cell.y) || (next.y > cell.y && previous.x > cell.x)) {
          sprite = Snake.getTopLeftCorner();
        } else if ((next.x < cell.x && previous.y < cell.y) || (next.y < cell.y && previous.x < cell.x)) {
          sprite = Snake.getBottomRightCorner();
        } else if ((next.x < cell.x && previous.y > cell.y) || (next.y > cell.y && previous.x < cell.x)) {
          sprite = Snake.getTopRightCorner();
        }
      }
      sprite?.renderRect(canvas, rect);
    }
  }
}
