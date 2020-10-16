import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import 'package:flame/flame.dart';

import './main_widget.dart';
import './settings_manager.dart';
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

  runApp(MainWidget());
}
