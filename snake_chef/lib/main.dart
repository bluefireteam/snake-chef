import 'package:flutter/material.dart';
import 'package:snake_chef/game/assets.dart';

import './game/game.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Assets.load();
  runApp(SnakeChef(boardWidth: 10, boardHeight: 10).widget);
}
