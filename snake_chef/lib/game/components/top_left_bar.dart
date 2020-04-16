import 'package:flame/sprite.dart';
import 'package:flame/nine_tile_box.dart';
import 'package:flame/components/nine_tile_box_component.dart';
import 'package:flame/components/mixins/has_game_ref.dart';
import 'package:flame/text_config.dart';
import 'package:flame/position.dart';

import 'dart:ui';

import '../game.dart';
import '../assets.dart';

class TopLeftBar extends NineTileBoxComponent with HasGameRef<SnakeChef> {
  final labelText = TextConfig(
      fontFamily: 'VictorPixel',
      fontSize: 28,
      color: Color(0xFF333c57),
  );

  final textPosition = Position(35, 50);
  final spriteRect = Rect.fromLTWH(10, 60, 270, 180);


  TopLeftBar(): super(NineTileBox(Sprite('nine_box_tileset.png'), tileSize: 16, destTileSize: 50));

  @override
  void render(Canvas canvas) {
    super.render(canvas);

    labelText.render(canvas, 'Current order', textPosition);
    Plates.getSprite(gameRef.currentRecipe.recipe).renderRect(canvas, spriteRect);
  }
}
