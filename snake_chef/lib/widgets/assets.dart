import 'package:flame/flame.dart';
import 'package:flame/spritesheet.dart';
import 'package:flame/sprite.dart';

class WidgetsAssets {
  static SpriteSheet _buttons;

  static Future<void> load() async {
    await Flame.images.loadAll(["buttons.png"]);
    _buttons = SpriteSheet(imageName: "buttons.png", textureHeight: 20, textureWidth: 60, columns: 2, rows: 2);
  }
}

class ButtonSprites {
  static Sprite primaryButton() => WidgetsAssets._buttons.getSprite(0, 0);
  static Sprite primaryButtonPressed() => WidgetsAssets._buttons.getSprite(1, 0);

  static Sprite secondaryButton() => WidgetsAssets._buttons.getSprite(0, 1);
  static Sprite secondaryButtonPressed() => WidgetsAssets._buttons.getSprite(1, 1);
}
