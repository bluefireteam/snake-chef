import 'package:flame/flame.dart';
import 'dart:convert';

import './game/stage.dart';

class StageLoader {
  static const STAGE_COUNT = 60;

  static Future<Stage> loadStage(int id) async {
    final raw = await Flame.assets.readFile("stages/${id ?? 0}.json");
    final json = jsonDecode(raw);

    return Stage.fromJson(json);
  }
}
