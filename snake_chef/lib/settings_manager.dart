import 'package:shared_preferences/shared_preferences.dart';
import 'package:snake_chef/game/stage.dart';
import 'package:snake_chef/stage_loader.dart';
import './audio_manager.dart';

class SettingsManager {
  static bool _isMusicEnabled;
  static bool isSfxEnabled;
  static GamepadOptions gamePadOptions = GamepadOptions();
  static StageProgress stageProgress = StageProgress();

  static set isMusicEnabled(bool value) {
    _isMusicEnabled = value;
    if (_isMusicEnabled) {
      AudioManager.titleMusic();
    } else {
      AudioManager.stopMusic();
    }
  }

  static get isMusicEnabled => _isMusicEnabled;

  static void save() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString("SettingsManager.stageProgress", stageProgress.progress.join(';'));

    await prefs.setBool("SettingsManager.isMusicEnabled", isMusicEnabled);
    await prefs.setBool("SettingsManager.isSfxEnabled", isSfxEnabled);

    await prefs.setBool("SettingsManager.gamePadOptions.enabled", gamePadOptions.enabled);
    await prefs.setDouble("SettingsManager.gamePadOptions.opacity", gamePadOptions.opacity);
    await prefs.setDouble("SettingsManager.gamePadOptions.dpadSize", gamePadOptions.dpadSize);
    await prefs.setDouble("SettingsManager.gamePadOptions.actionButtonSize", gamePadOptions.actionButtonSize);
  }

  static Future<void> load() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    final stageProgressSaved = prefs.getString("SettingsManager.stageProgress")?.split(';') ?? [];

    for (var i = 0; i < stageProgressSaved.length; i++) {
      var stageDifficult;

      if (stageProgressSaved[i] == 'StageDifficult.NORMAL') {
        stageDifficult = StageDifficult.NORMAL;
      }
      if (stageProgressSaved[i] == 'StageDifficult.MEDIUM') {
        stageDifficult = StageDifficult.MEDIUM;
      }
      if (stageProgressSaved[i] == 'StageDifficult.HARD') {
        stageDifficult = StageDifficult.HARD;
      }

      stageProgress.progress[i] = stageDifficult;
    }

    isMusicEnabled = prefs.getBool("SettingsManager.isMusicEnabled") ?? true;
    isSfxEnabled = prefs.getBool("SettingsManager.isSfxEnabled") ?? true;

    gamePadOptions.enabled = prefs.getBool("SettingsManager.gamePadOptions.enabled") ?? true;
    gamePadOptions.opacity = prefs.getDouble("SettingsManager.gamePadOptions.opacity") ?? 0.5;
    gamePadOptions.dpadSize = prefs.getDouble("SettingsManager.gamePadOptions.dpadSize") ?? 200;
    gamePadOptions.actionButtonSize = prefs.getDouble("SettingsManager.gamePadOptions.actionButtonSize") ?? 65;
  }
}

class GamepadOptions {
  bool enabled;
  double opacity;
  double dpadSize;
  double actionButtonSize;
}

class StageProgress {
  List<StageDifficult> progress = List.generate(StageLoader.STAGE_COUNT, (index) => null);

  void updateStageProgress(StageDifficult difficult, int stage) {
    progress[stage] = difficult;
  }
}
