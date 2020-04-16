import 'package:flame/sprite.dart';
import 'package:flame/nine_tile_box.dart';
import 'package:flame/components/nine_tile_box_component.dart';
import 'package:flame/components/mixins/has_game_ref.dart';
import 'package:flame/text_config.dart';
import 'package:flame/position.dart';

import 'dart:ui';

import '../game.dart';
import '../ingredient_renderer.dart';

class BottomLeftBar extends NineTileBoxComponent with HasGameRef<SnakeChef> {
  Position textPosition;
  double _timer = 0.0;

  final labelText = TextConfig(
      fontFamily: 'VictorPixel',
      fontSize: 28,
      color: Color(0xFF333c57),
  );

  BottomLeftBar(): super(NineTileBox(Sprite('nine_box_white_tileset.png'), tileSize: 16, destTileSize: 50));

  void justCompletedOrder() {
    _timer = 1.0;
  }

  @override
  void onMount() {
    textPosition = Position(100, y + 50);
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
    if (_timer <= 0) {
      labelText.render(canvas, 'Recipe', textPosition);

      final recipeLength = gameRef.currentRecipe.ingredients.length;
      for (var i = 0; i < recipeLength; i++) {
        final ingredient = gameRef.currentRecipe.ingredients[i];

        final w = width / recipeLength - 50;
        final rect = Rect.fromLTWH(
            width / 2 - i * w,
            y + 100,
            w,
            w
        );

        renderIngredient(canvas, ingredient, rect);
      }
    }
  }
}
