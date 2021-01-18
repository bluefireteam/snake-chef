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
  final labelRecipeName = TextConfig(
    fontFamily: 'VictorPixel',
    fontSize: 22,
    color: Color(0xFF566c86),
  );

  final textPosition = Position(35, 50);
  final recipeName = Position(35, 75);
  final spriteRect = Rect.fromLTWH(10, 75, 270, 180);

  double _timer = 0.0;

  TopLeftBar()
      : super(NineTileBox(Sprite('nine_box_tileset.png'),
            tileSize: 16, destTileSize: 50));

  void justCompletedOrder() {
    _timer = 0.5;
  }

  @override
  void update(double dt) {
    super.update(dt);

    if (_timer > 0) {
      _timer -= dt;
    }
  }

  @override
  void render(Canvas canvas) {
    super.render(canvas);

    if (_timer > 0) {
      labelText.render(canvas, '  Completed  ', textPosition);
    } else {
      labelText.render(canvas, 'Current order', textPosition);
      labelRecipeName.render(
          canvas, gameRef.currentRecipe.recipeName, recipeName);
      Plates.getSprite(gameRef.currentRecipe.recipe)
          .renderRect(canvas, spriteRect);
    }
  }
}
