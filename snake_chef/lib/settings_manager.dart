import 'package:shared_preferences/shared_preferences.dart';
import 'package:snake_chef/game/stage.dart';
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
    await prefs.setInt("SettingsManager.stageProgressNormal", stageProgress.normal);
    await prefs.setInt("SettingsManager.stageProgressMedium", stageProgress.medium);
    await prefs.setInt("SettingsManager.stageProgressHard", stageProgress.hard);

    await prefs.setBool("SettingsManager.isMusicEnabled", isMusicEnabled);
    await prefs.setBool("SettingsManager.isSfxEnabled", isSfxEnabled);

    await prefs.setBool("SettingsManager.gamePadOptions.enabled", gamePadOptions.enabled);
    await prefs.setDouble("SettingsManager.gamePadOptions.opacity", gamePadOptions.opacity);
    await prefs.setDouble("SettingsManager.gamePadOptions.dpadSize", gamePadOptions.dpadSize);
    await prefs.setDouble("SettingsManager.gamePadOptions.actionButtonSize", gamePadOptions.actionButtonSize);
  }

  static Future<void> load() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    stageProgress.normal = prefs.getInt("SettingsManager.stageProgressNormal") ?? 0;
    stageProgress.medium = prefs.getInt("SettingsManager.stageProgressMedium") ?? 0;
    stageProgress.hard = prefs.getInt("SettingsManager.stageProgressHard") ?? 0;

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
  int normal;
  int medium;
  int hard;

  void updateStageProgress(StageDifficult difficult, int stage) {
    switch (difficult) {
      case StageDifficult.NORMAL:
        normal = stage;
        break;
      case StageDifficult.MEDIUM:
        medium = stage;
        break;
      case StageDifficult.HARD:
        hard = stage;
        break;
    }
  }
}
