class SettingsManager {
  static bool isMusicEnabled = true;
  static bool isSfxEnabled = true;
  static GamepadOptions gamePadOptions = GamepadOptions();
}

class GamepadOptions {
  bool enabled = true;
  double opacity = 0.5;
  double size = 200;
}
