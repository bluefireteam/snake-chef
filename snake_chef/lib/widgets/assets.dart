import 'package:flame/flame.dart';
import 'package:flame/spritesheet.dart';
import 'package:flame/sprite.dart';
import 'package:flame_fire_atlas/flame_fire_atlas.dart';

class WidgetsAssets {
  static SpriteSheet _buttons;
  static FireAtlas _sliderAtlas;

  static Future<void> load() async {
    await Flame.images.loadAll(["buttons.png"]);
    _buttons = SpriteSheet(
        imageName: "buttons.png",
        textureHeight: 20,
        textureWidth: 60,
        columns: 2,
        rows: 8);

    _sliderAtlas = await FireAtlas.fromAsset('atlases/slider.fa');
  }
}

class SlideSprites {
  static Sprite leftTile() => WidgetsAssets._sliderAtlas.getSprite('left');
  static Sprite rightTile() => WidgetsAssets._sliderAtlas.getSprite('right');
  static Sprite middleTile() => WidgetsAssets._sliderAtlas.getSprite('middle');
  static Sprite bullet() => WidgetsAssets._sliderAtlas.getSprite('bullet');
}

class ButtonSprites {
  static Sprite primaryButton() => WidgetsAssets._buttons.getSprite(0, 0);
  static Sprite primaryButtonPressed() =>
      WidgetsAssets._buttons.getSprite(1, 0);

  static Sprite secondaryButton() => WidgetsAssets._buttons.getSprite(0, 1);
  static Sprite secondaryButtonPressed() =>
      WidgetsAssets._buttons.getSprite(1, 1);

  static Sprite dpadButton() => WidgetsAssets._buttons.getSprite(2, 0);
  static Sprite dpadButtonPressed() => WidgetsAssets._buttons.getSprite(3, 0);

  static Sprite onButton() => WidgetsAssets._buttons.getSprite(2, 1);
  static Sprite onButtonPressed() => WidgetsAssets._buttons.getSprite(3, 1);

  static Sprite offButton() => WidgetsAssets._buttons.getSprite(4, 0);
  static Sprite offButtonPressed() => WidgetsAssets._buttons.getSprite(5, 0);

  static Sprite bronzeButton() => WidgetsAssets._buttons.getSprite(4, 1);
  static Sprite bronzeButtonPressed() => WidgetsAssets._buttons.getSprite(5, 1);

  static Sprite plainButton() => WidgetsAssets._buttons.getSprite(6, 0);
  static Sprite plainButtonPressed() => WidgetsAssets._buttons.getSprite(7, 0);
}
