import 'package:flutter/material.dart';
import 'package:flame/flame.dart';
import 'package:flame_splash_screen/flame_splash_screen.dart';
import 'package:snake_chef/settings_manager.dart';

import './screens/credits_screen.dart';
import './screens/title_screen.dart';
import './screens/game_screen.dart';
import './screens/stage_select_screen.dart';

import './audio_manager.dart';
import './widgets/assets.dart';
import './game/assets.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Flame.util.fullScreen();
  await Flame.util.setLandscape();

  Future.wait([
    Assets.load(),
    WidgetsAssets.load(),
    AudioManager.load(),
    SettingsManager.load(),
  ]);

  runApp(MaterialApp(
    routes: {
      '/': (ctx) => FlameSplashScreen(
            theme: FlameSplashTheme.dark,
            showBefore: (BuildContext context) {
              return Image.asset('assets/images/fireslime-banner.png', width: 400);
            },
            onFinish: (BuildContext context) {
              Navigator.pushNamed(context, "/title");
            },
          ),
      '/title': (ctx) => TitleScreen(),
      '/game': (ctx) => GameScreen(),
      '/stage_select': (ctx) => StageSelectScreen(),
      '/credits': (ctx) => CreditsScreen(),
    },
  ));
}
