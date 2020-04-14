import 'dart:ui';

import 'package:flame/position.dart';
import 'package:flame/sprite.dart';
import 'package:snake_chef/game/assets.dart';

enum CellType { SNAKE_HEAD, SNAKE_PART, INGREDIENT_TOMATO, INGREDIENT_LETTUCE }

class Cell {
  Cell({this.x, this.y});
  static const double cellSize = 50;

  int x;
  int y;
  CellType type;

  void render(Canvas canvas, List<List<Cell>> board, Position direction, List<Position> snake) {
    final rect = Rect.fromLTWH(x * cellSize, y * cellSize, cellSize, cellSize);

    Floor.getFloorTile().renderRect(canvas, rect);

    if (board.length - 1 == y) {
      Floor.getFloorBorder().renderRect(canvas, rect.translate(0, cellSize));
    }

    if (type == CellType.SNAKE_HEAD) {
      Sprite sprite;

      final head = snake[0];
      final next = snake[1];

      if (direction.x == 1) {
        if (head.y == next.y) {
          sprite = Snake.getHeadFacingRight();
        } else if (head.y > next.y) {
          sprite = Snake.getHeadCornerBottomRight();
        } else if (head.y < next.y) {
          sprite = Snake.getHeadCornerTopRight();
        }
      } else if (direction.x == -1) {
        if (head.y == next.y) {
          sprite = Snake.getHeadFacingLeft();
        } else if (head.y > next.y) {
          sprite = Snake.getHeadCornerBottomLeft();
        } else if (head.y < next.y) {
          sprite = Snake.getHeadCornerTopLeft();
        }
      } else if (direction.y == 1) {
        sprite = Snake.getHeadFacingDown();
      } else if (direction.y == -1) {
        sprite = Snake.getHeadFacingUp();
      }

      sprite.renderRect(canvas, rect);
    }
    if (type == CellType.SNAKE_PART) {
      final partIndex = snake.indexWhere((element) => element.x == x && element.y == y);
      final previous = snake[partIndex - 1];

      Sprite sprite;

      if (partIndex + 1 == snake.length) {
        if (x < previous.x) {
          sprite = Snake.getTailFacingLeft();
        } else if (x > previous.x) {
          sprite = Snake.getTailFacingRight();
        } else if (y < previous.y) {
          sprite = Snake.getTailFacingUp();
        } else if (y > previous.y) {
          sprite = Snake.getTailFacingDown();
        }
      } else {
        final next = snake[partIndex + 1];

        if (x == previous.x && x == next.x) {
          sprite = Snake.getTopViewBodyPart();
        } else if (y == previous.y && y == next.y) {
          sprite = Snake.getSideViewBodyPart();
        } else if ((next.x > x && previous.y < y) || (next.y < y && previous.x > x)) {
          sprite = Snake.getBottomLeftCorner();
        } else if ((next.x > x && previous.y > y) || (next.y > y && previous.x > x)) {
          sprite = Snake.getTopLeftCorner();
        } else if ((next.x < x && previous.y < y) || (next.y < y && previous.x < x)) {
          sprite = Snake.getBottomRightCorner();
        } else if ((next.x < x && previous.y > y) || (next.y > y && previous.x < x)) {
          sprite = Snake.getTopRightCorner();
        }
      }
      sprite?.renderRect(canvas, rect);
    }
    if (type == CellType.INGREDIENT_TOMATO) {
      Ingredients.getTomato().renderRect(canvas, rect);
    }
    if (type == CellType.INGREDIENT_LETTUCE) {
      Ingredients.getLettuce().renderRect(canvas, rect);
    }
  }

  final Paint white = Paint()..color = Color(0xFFFFFFFF);
  final Paint blue = Paint()..color = Color(0xFF0000FF);
}
