import 'package:flutter/material.dart';

import './game/assets.dart';
import './widgets/assets.dart';

import './screens/credits_screen.dart';
import './screens/title_screen.dart';
import './screens/game_screen.dart';
import './screens/stage_select_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Assets.load();
  await WidgetsAssets.load();

  runApp(MaterialApp(
    routes: {
      '/title': (ctx) => TitleScreen(),
      '/game': (ctx) => GameScreen(),
      '/credits': (ctx) => CreditsScreen(),
      '/stage_select': (ctx) => StageSelectScreen(),
    },
    initialRoute: '/title',
  ));
}
