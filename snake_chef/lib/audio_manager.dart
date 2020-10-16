import 'package:ocarina/ocarina.dart';

import './settings_manager.dart';

class AudioManager {
  static OcarinaPlayer _lastPlayer;

  static final OcarinaPlayer _title =
      OcarinaPlayer(asset: 'assets/audio/title.wav', loop: true);

  static final OcarinaPlayer _gameover =
      OcarinaPlayer(asset: 'assets/audio/gameover.aac', loop: false);

  static final OcarinaPlayer _gameplay =
      OcarinaPlayer(asset: 'assets/audio/gameplay.wav', loop: true);

  static final OcarinaPlayer _win =
      OcarinaPlayer(asset: 'assets/audio/win_fanfarre.aac', loop: false);

  static final OcarinaPlayer _collected = OcarinaPlayer(
      asset: 'assets/audio/ingredient_collected.wav', loop: false);

  static final OcarinaPlayer _recipeDone =
      OcarinaPlayer(asset: 'assets/audio/recipe_done.wav', loop: false);

  static Future<void> load() async {
    await Future.wait([
      _title.load(),
      _gameover.load(),
      _gameplay.load(),
      _win.load(),
      _collected.load(),
      _recipeDone.load(),
    ]);
  }

  static Future<void> titleMusic() => _music(_title);
  static Future<void> gameplayMusic() => _music(_gameplay);
  static Future<void> gameoverMusic() => _music(_gameover);
  static Future<void> winMusic() => _music(_win);

  static Future<void> collectSfx() => _sfx(_collected);
  static Future<void> recipeDoneSfx() => _sfx(_recipeDone);

  static Future<void> _sfx(OcarinaPlayer player) async {
    if (!SettingsManager.isSfxEnabled) return;
    player.play();
  }

  static Future<void> _music(OcarinaPlayer player) async {
    if (!SettingsManager.isMusicEnabled) return;

    if (_lastPlayer != player) {
      await stopMusic();
      player.play();
      _lastPlayer = player;
    }
  }

  static Future<void> stopMusic() async {
    await _lastPlayer?.stop();
    _lastPlayer = null;
  }

  static Future<void> pauseMusic() async {
    await _lastPlayer?.pause();
  }

  static Future<void> resumeMusic() async {
    await _lastPlayer?.resume();
  }
}
