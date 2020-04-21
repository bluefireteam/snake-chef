import 'package:flutter/foundation.dart';
import 'package:flame/flame.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:http/http.dart' as http;

class AudioManager {
  static AudioPlayer _currentBackgroundMusic;
  static bool isAudioEnabled = false;

  static Future<void> load() async {
    if (!isAudioEnabled) return;
    if (kIsWeb) {
      await Future.wait([
        http.get('/assets/audio/gameover.ogg'),
        http.get('/assets/audio/gameplay.ogg'),
        http.get('/assets/audio/win_fanfarre.ogg'),
        http.get('/assets/audio/title.ogg'),

        http.get('/assets/audio/ingredient_collected.wav'),
        http.get('/assets/audio/recipe_done.wav'),
      ]);
    } else {
      await Flame.audio.loadAll([
        'gameover.ogg',
        'gameplay.ogg',
        'title.ogg',
        'win_fanfarre.ogg',
        'ingredient_collected.wav',
        'recipe_done.wav',
      ]);
    }
  }

  static loopBackgroundMusic(String music) async {
    if (!isAudioEnabled) return;
    _currentBackgroundMusic?.stop();

    _currentBackgroundMusic = await Flame.audio.loopLongAudio(music);
  }

  static playBackgroundMusic(String music) async {
    if (!isAudioEnabled) return;
    _currentBackgroundMusic?.stop();

    _currentBackgroundMusic = await Flame.audio.playLongAudio(music);
  }

  static playSfx(String sfx) {
    if (!isAudioEnabled) return;
    Flame.audio.play(sfx);
  }
}
