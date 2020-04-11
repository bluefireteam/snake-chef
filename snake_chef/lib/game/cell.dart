import 'dart:ui';

import 'package:snake_chef/game/assets.dart';

enum CellType { SNAKE_HEAD, SNAKE_PART, INGREDIENT_TOMATO, INGREDIENT_LETTUCE }

class Cell {
  Cell({this.x, this.y});
  static const double cellSize = 50;

  int x;
  int y;
  CellType type;

  void render(Canvas canvas, List<List<Cell>> board) {
    final rect = Rect.fromLTWH(x * cellSize, y * cellSize, cellSize, cellSize);

    Floor.getFloorTile().renderRect(canvas, rect);

    if (board.length - 1 == y) {
      Floor.getFloorBorder().renderRect(canvas, rect.translate(0, cellSize));
    }

    if (type == CellType.SNAKE_HEAD) {
      canvas.drawRect(rect, blue);
    }
    if (type == CellType.SNAKE_PART) {
      canvas.drawRect(rect, white);
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
