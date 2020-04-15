import 'package:flutter/material.dart';

import 'package:snake_chef/game/assets.dart';
import './widgets/assets.dart';

import './screens/title_screen.dart';
import './screens/game_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Assets.load();
  await WidgetsAssets.load();

  runApp(
      MaterialApp(
          routes: {
            '/title': (ctx) => TitleScreen(),
            '/game': (ctx) => GameScreen(),
          },
          initialRoute: '/title',

      )
  );
}
