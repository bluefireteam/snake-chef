import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import 'package:flame/flame.dart';
import 'package:flame_splash_screen/flame_splash_screen.dart';
import 'package:snake_chef/screens/settings.dart';
import 'package:snake_chef/settings_manager.dart';

import './screens/credits_screen.dart';
import './screens/title_screen.dart';
import './screens/game_screen.dart';
import './screens/stage_select_screen.dart';
import './screens/gamepad_config.dart';

import './audio_manager.dart';
import './widgets/assets.dart';
import './game/assets.dart';
import './recipe_loader.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Flame.util.fullScreen();
  await Flame.util.setLandscape();

  final futures = Future.wait([
    RecipeLoader.load(),
    Assets.load(),
    WidgetsAssets.load(),
    AudioManager.load(),
    SettingsManager.load(),
  ]);

  if (!kReleaseMode) {
    await futures;
  }

  runApp(MaterialApp(routes: {
    '/splash_screen': (ctx) => FlameSplashScreen(
          theme: FlameSplashTheme.dark,
          showBefore: (BuildContext context) {
            return Image.asset('assets/images/fireslime-banner.png',
                width: 400);
          },
          onFinish: (BuildContext context) {
            Navigator.pushNamed(context, "/title");
          },
        ),
    '/title': (ctx) => TitleScreen(),
    '/game': (ctx) => GameScreen(),
    '/stage_select': (ctx) => StageSelectScreen(),
    '/settings': (ctx) => SettingsScreen(),
    '/gamepad_config': (ctx) => GamePadConfigScreen(),
    '/credits': (ctx) => CreditsScreen(),
  }, initialRoute: kReleaseMode ? '/splash_screen' : '/title'));
}
