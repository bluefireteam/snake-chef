import './game/stage.dart';

class StageLoader {
  static const STAGE_COUNT = 12;

  static Future<Stage> loadStage(int id) {
    // TODO mock, load from json after
    final stage = Stage(
        recipes: [Recipe.salad(), Recipe.salad()],
        initialX: 5,
        initialY: 5,
    );

    return Future.value(stage);
  }
}
