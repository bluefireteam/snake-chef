import 'dart:ui';

enum CellType {
  SNAKE_HEAD,
  SNAKE_PART,
}

class Cell {
  Cell({this.x, this.y});
  static const double cellSize = 50;

  int x;
  int y;
  CellType type;

  void render(Canvas canvas) {
    if (type == CellType.SNAKE_HEAD) {
      canvas.drawRect(
          Rect.fromLTWH(x * cellSize, y * cellSize, cellSize, cellSize), blue);
    }
    if (type == CellType.SNAKE_PART) {
      canvas.drawRect(
          Rect.fromLTWH(x * cellSize, y * cellSize, cellSize, cellSize), white);
    }
  }
}

final Paint white = Paint()..color = Color(0xFFFFFFFF);
final Paint blue = Paint()..color = Color(0xFF0000FF);
