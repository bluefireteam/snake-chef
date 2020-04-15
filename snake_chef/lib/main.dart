import 'package:flutter/material.dart';
import 'package:snake_chef/game/assets.dart';

import './game/game.dart';
import './game/stage.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Assets.load();

  final stage = Stage(
      recipes: [Recipe.salad(), Recipe.salad()],
      initialX: 5,
      initialY: 5,
  );
  runApp(SnakeChef(boardWidth: 10, boardHeight: 10, stage: stage).widget);
}
