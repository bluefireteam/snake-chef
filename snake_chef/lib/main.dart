import 'package:flutter/material.dart';
import 'package:flame/flame.dart';

import './screens/credits_screen.dart';
import './screens/title_screen.dart';
import './screens/game_screen.dart';
import './screens/stage_select_screen.dart';
import './screens/loading_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Flame.util.fullScreen();
  await Flame.util.setLandscape();

  runApp(
      MaterialApp(
          routes: {
            '/loading': (ctx) => LoadingScreen(),
            '/title': (ctx) => TitleScreen(),
            '/game': (ctx) => GameScreen(),
            '/stage_select': (ctx) => StageSelectScreen(),
            '/credits': (ctx) => CreditsScreen(),
          },
          initialRoute: '/loading',

      )
  );
}
