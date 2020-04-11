import 'package:flame/sprite.dart';
import 'package:flame/spritesheet.dart';
import 'package:flame/flame.dart';

class Assets {
  static SpriteSheet ingredients;
  static SpriteSheet floor;

  static Future<void> load() async {
    await Flame.images.loadAll(["floor.png", "ingredients.png", "snake.png"]);
    ingredients = SpriteSheet(imageName: "ingredients.png", textureHeight: 16, textureWidth: 16, columns: 2, rows: 1);
    floor = SpriteSheet(imageName: "floor.png", textureHeight: 16, textureWidth: 16, columns: 1, rows: 2);
  }
}

class Ingredients {

  static Sprite getLettuce() {
    return Assets.ingredients.getSprite(0, 1);
  }

  static Sprite getTomato() {
    return Assets.ingredients.getSprite(0, 0);
  }
}

class Floor {

  static Sprite getFloorBorder() {
    return Assets.floor.getSprite(1, 0);
  }

  static Sprite getFloorTile() {
    return Assets.floor.getSprite(0, 0);
  }
}