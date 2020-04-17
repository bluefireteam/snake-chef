import 'package:flutter/foundation.dart';
import 'package:flame/flame.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:http/http.dart' as http;

class AudioManager {
  static AudioPlayer _currentBackgroundMusic;

  static Future<void> load() async {
    if (kIsWeb) {
      await Future.wait([
        http.get('/assets/audio/gameover.mp3'),
        http.get('/assets/audio/gameplay.wav'),
        http.get('/assets/audio/ingredient_collected.wav'),
        http.get('/assets/audio/recipe_done.wav'),
        http.get('/assets/audio/title.wav'),
        http.get('/assets/audio/win_fanfarre.wav'),
      ]);
    } else {
      await Flame.audio.loadAll([
        'gameover.wav',
        'gameplay.wav',
        'ingredient_collected.wav',
        'recipe_done.wav',
        'title.wav',
        'win_fanfarre.wav',
      ]);
    }
  }

  static loopBackgroundMusic(String music) async {
    _currentBackgroundMusic?.stop();

    _currentBackgroundMusic = await Flame.audio.loopLongAudio(music);
  }

  static playBackgroundMusic(String music) async {
    _currentBackgroundMusic?.stop();

    _currentBackgroundMusic = await Flame.audio.playLongAudio(music);
  }

  static playSfx(String sfx) {
    Flame.audio.play(sfx);
  }
}
