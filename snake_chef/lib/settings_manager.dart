import 'package:shared_preferences/shared_preferences.dart';

class SettingsManager {
  static bool isMusicEnabled;
  static bool isSfxEnabled;
  static GamepadOptions gamePadOptions = GamepadOptions();
  static int stageProgress;

  static void save() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setInt("SettingsManager.stageProgress", stageProgress);
    await prefs.setBool("SettingsManager.isMusicEnabled", isMusicEnabled);
    await prefs.setBool("SettingsManager.isSfxEnabled", isSfxEnabled);

    await prefs.setBool("SettingsManager.gamePadOptions.enabled", gamePadOptions.enabled);
    await prefs.setDouble("SettingsManager.gamePadOptions.opacity", gamePadOptions.opacity);
    await prefs.setDouble("SettingsManager.gamePadOptions.dpadSize", gamePadOptions.dpadSize);
    await prefs.setDouble("SettingsManager.gamePadOptions.actionButtonSize", gamePadOptions.actionButtonSize);
  }

  static Future<void> load() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    stageProgress = prefs.getInt("SettingsManager.stageProgress") ?? 0;
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
