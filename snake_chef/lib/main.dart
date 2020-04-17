import 'package:flutter/material.dart';

import './screens/title_screen.dart';
import './screens/game_screen.dart';
import './screens/stage_select_screen.dart';
import './screens/loading_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  runApp(
      MaterialApp(
          routes: {
            '/loading': (ctx) => LoadingScreen(),
            '/title': (ctx) => TitleScreen(),
            '/game': (ctx) => GameScreen(),
            '/stage_select': (ctx) => StageSelectScreen(),
          },
          initialRoute: '/loading',

      )
  );
}
