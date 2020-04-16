import 'package:flame/position.dart';

import './game/stage.dart';

class StageLoader {
  static const STAGE_COUNT = 12;

  static Future<Stage> loadStage(int id) {
    // TODO mock, load from json after
    final stage = Stage(
      recipes: [Recipe.salad(), Recipe.salad()],
      obstacles: [Position(0, 0), Position(3, 2), Position(4, 6)],
      initialX: 5,
      initialY: 5,
    );

    return Future.value(stage);
  }
}
