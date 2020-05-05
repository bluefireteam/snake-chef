class SettingsManager {
  static bool isMusicEnabled = true;
  static bool isSfxEnabled = true;
  static GamepadOptions gamePadOptions = GamepadOptions();
  static int stageProgress = 0;
}

class GamepadOptions {
  bool enabled = true;
  double opacity = 0.5;
  double dpadSize = 200;
  double actionButtonSize = 65;
}
