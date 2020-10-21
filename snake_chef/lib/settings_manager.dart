import 'package:shared_preferences/shared_preferences.dart';
import 'package:snake_chef/game/stage.dart';
import 'package:snake_chef/stage_loader.dart';
import './audio_manager.dart';

class SettingsManager {
  static bool isFirstAccess;
  static bool _isMusicEnabled;
  static bool isSfxEnabled;
  static bool isVibrateEnabled;
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

  static void setControlsInFirstAccess(bool useGamepad) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    isFirstAccess = false;
    await prefs.setBool("SettingsManager.isFirstAccess", false);

    gamePadOptions.enabled = useGamepad;
    await prefs.setBool("SettingsManager.gamePadOptions.enabled", useGamepad);
  }

  static void save() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString(
        "SettingsManager.stageProgress", stageProgress.progress.join(';'));

    await prefs.setBool("SettingsManager.isFirstAccess", isFirstAccess);
    await prefs.setBool("SettingsManager.isMusicEnabled", isMusicEnabled);
    await prefs.setBool("SettingsManager.isSfxEnabled", isSfxEnabled);
    await prefs.setBool("SettingsManager.isVibrateEnabled", isVibrateEnabled);

    await prefs.setBool(
        "SettingsManager.gamePadOptions.enabled", gamePadOptions.enabled);
    await prefs.setDouble(
        "SettingsManager.gamePadOptions.opacity", gamePadOptions.opacity);
    await prefs.setDouble(
        "SettingsManager.gamePadOptions.buttonSize", gamePadOptions.buttonSize);
    await prefs.setDouble("SettingsManager.gamePadOptions.borderPercentage",
        gamePadOptions.borderPercentage);
  }

  static Future<void> load() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    final stageProgressSaved =
        prefs.getString("SettingsManager.stageProgress")?.split(';') ?? [];

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

    isFirstAccess = prefs.getBool("SettingsManager.isFirstAccess") ?? true;
    isMusicEnabled = prefs.getBool("SettingsManager.isMusicEnabled") ?? true;
    isSfxEnabled = prefs.getBool("SettingsManager.isSfxEnabled") ?? true;
    isVibrateEnabled =
        prefs.getBool("SettingsManager.isVibrateEnabled") ?? true;

    gamePadOptions.enabled =
        prefs.getBool("SettingsManager.gamePadOptions.enabled") ?? false;
    gamePadOptions.opacity =
        prefs.getDouble("SettingsManager.gamePadOptions.opacity") ?? 0.5;
    gamePadOptions.buttonSize =
        prefs.getDouble("SettingsManager.gamePadOptions.buttonSize") ?? 0.3;
    gamePadOptions.borderPercentage =
        prefs.getDouble("SettingsManager.gamePadOptions.borderPercentage") ??
            0.1;
  }
}

class GamepadOptions {
  bool enabled;
  double opacity;
  double buttonSize;
  double borderPercentage;
}

class StageProgress {
  List<StageDifficult> progress =
      List.generate(StageLoader.STAGE_COUNT, (index) => null);

  void updateStageProgress(StageDifficult difficult, int stage) {
    if (Stage.stageToNumber(progress[stage]) < Stage.stageToNumber(difficult)) {
      progress[stage] = difficult;
    }
  }
}
