import 'package:flame/sprite.dart';
import 'package:flame/nine_tile_box.dart';
import 'package:flame/components/nine_tile_box_component.dart';
import 'package:flame/components/mixins/has_game_ref.dart';
import 'package:flame/text_config.dart';
import 'package:flame/position.dart';

import 'dart:ui';

import '../game.dart';
import '../ingredient_renderer.dart';

class TopBar extends NineTileBoxComponent with HasGameRef<SnakeChef> {
  final labelText = TextConfig(
    fontFamily: 'VictorPixel',
    fontSize: 22,
    color: Color(0xFF94b0c2),
  );

  final counterText = TextConfig(
    fontFamily: 'VictorPixel',
    fontSize: 22,
    color: Color(0xFF333c57),
  );

  TopBar()
      : super(NineTileBox(Sprite('nine_box_white_tileset.png'),
            tileSize: 16, destTileSize: 50));

  @override
  void render(Canvas canvas) {
    super.render(canvas);

    final refLeft = x + 30;
    labelText.render(canvas, 'Collected', Position(refLeft, 20));

    labelText.render(canvas, 'Recipe', Position(x + width - 230, 20));
    counterText.render(
        canvas,
        '${gameRef.recipeIndexLabel}/${gameRef.stage.recipes.length}',
        Position(x + width - 230, 45));

    var i = 0;
    gameRef.collectedIngredients.forEach((ingredient) {
      renderIngredient(canvas, ingredient,
          Rect.fromLTWH(refLeft + i++ * 25 + 5, 45, 25, 25));
    });

    labelText.render(canvas, 'Time', Position(x + width - 80, 20));
    counterText.render(
        canvas, '${gameRef.stageTimer}', Position(x + width - 80, 45));
  }
}
