import 'package:flame/flame.dart';
import 'package:audioplayers/audioplayers.dart';

import './settings_manager.dart';

class AudioManager {
  static AudioPlayer _currentBackgroundMusic;

  static Future<void> load() async {
    await Flame.audio.loadAll([
      'gameover.aac',
      'gameplay.aac',
      'title.aac',
      'win_fanfarre.aac',
      'ingredient_collected.wav',
      'recipe_done.wav',
    ]);
  }

  static loopBackgroundMusic(String music) async {
    if (!SettingsManager.isMusicEnabled) return;
    _currentBackgroundMusic?.stop();

    _currentBackgroundMusic = await Flame.audio.loopLongAudio("$music.aac");
  }

  static playBackgroundMusic(String music) async {
    if (!SettingsManager.isMusicEnabled) return;
    _currentBackgroundMusic?.stop();

    _currentBackgroundMusic = await Flame.audio.playLongAudio("$music.aac");
  }

  static playSfx(String sfx) {
    if (!SettingsManager.isSfxEnabled) return;
    Flame.audio.play("$sfx.wav");
  }
}
