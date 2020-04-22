class SettingsManager {
  static bool isMusicEnabled = false;
  static bool isSfxEnabled = false;
  static GamepadOptions gamePadOptions = GamepadOptions();
}

class GamepadOptions {
  bool enabled = true;
  double opacity = 0.5;
  double size = 200;
}
