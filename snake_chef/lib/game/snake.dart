import 'package:flame/position.dart';

class Snake {
  List<Position> body = [];
  Position direction = Position(-1, 0);

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

  void turnDown() {
    if (direction.x != 0) {
      direction.y = 1;
      direction.x = 0;
    }
  }
}
