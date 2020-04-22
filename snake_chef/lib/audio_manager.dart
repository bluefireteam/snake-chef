import 'package:flame/flame.dart';
import 'package:audioplayers/audioplayers.dart';

import './settings_manager.dart';

class AudioManager {
  static AudioPlayer _currentBackgroundMusic;

  static Future<void> load() async {
    await Flame.audio.loadAll([
      'gameover.ogg',
      'gameplay.ogg',
      'title.ogg',
      'win_fanfarre.ogg',
      'ingredient_collected.wav',
      'recipe_done.wav',
    ]);
  }

  static loopBackgroundMusic(String music) async {
    if (!SettingsManager.isMusicEnabled) return;
    _currentBackgroundMusic?.stop();

    _currentBackgroundMusic = await Flame.audio.loopLongAudio(music);
  }

  static playBackgroundMusic(String music) async {
    if (!SettingsManager.isMusicEnabled) return;
    _currentBackgroundMusic?.stop();

    _currentBackgroundMusic = await Flame.audio.playLongAudio(music);
  }

  static playSfx(String sfx) {
    if (!SettingsManager.isSfxEnabled) return;
    Flame.audio.play(sfx);
  }
}
