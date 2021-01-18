import 'package:flame/sprite.dart';
import 'package:flame/nine_tile_box.dart';
import 'package:flame/components/nine_tile_box_component.dart';
import 'package:flame/components/mixins/has_game_ref.dart';
import 'package:flame/text_config.dart';
import 'package:flame/position.dart';

import 'dart:ui';
import 'dart:math';

import '../game.dart';
import '../ingredient_renderer.dart';
import '../stage.dart';

class _IngredientPos {
  Rect rect;
  Ingredient ingredient;
}

class BottomLeftBar extends NineTileBoxComponent with HasGameRef<SnakeChef> {
  Position textPosition;
  double _timer = 0.0;
  List<_IngredientPos> _ingredientsPositions;

  final labelText = TextConfig(
    fontFamily: 'VictorPixel',
    fontSize: 28,
    color: Color(0xFF333c57),
  );

  BottomLeftBar()
      : super(NineTileBox(Sprite('nine_box_white_tileset.png'),
            tileSize: 16, destTileSize: 50));

  void justCompletedOrder() {
    _timer = 0.5;
    initIngredientPositions();
  }

  @override
  void onMount() {
    textPosition = Position(100, y + 50);
    initIngredientPositions();
  }

  void reset() {
    initIngredientPositions();
  }

  @override
  void update(double dt) {
    super.update(dt);

    if (_timer > 0) {
      _timer -= dt;
    }
  }

  void initIngredientPositions() {
    _ingredientsPositions = [];

    final ingredients = gameRef.currentRecipe.ingredients;
    final ingredientsPerRow = 3;
    final rows = (ingredients.length / ingredientsPerRow).ceil();

    final padding = 40;
    final size = (width / ingredientsPerRow) - 10;

    var c = 0;

    for (var _y = 0; _y < rows; _y++) {
      final l = min(3, ingredients.length - c);
      for (var _x = 0; _x < l; _x++) {
        _ingredientsPositions.add(_IngredientPos()
          ..ingredient = ingredients[c]
          ..rect = Rect.fromLTWH(
            padding + _x * size,
            y + 90 + _y * size,
            size - padding,
            size - padding,
          ));
        c++;
      }
    }
  }

  @override
  void render(Canvas canvas) {
    super.render(canvas);
    if (_timer <= 0) {
      labelText.render(canvas, 'Recipe', textPosition);

      _ingredientsPositions?.forEach((i) {
        renderIngredient(canvas, i.ingredient, i.rect);
      });
    }
  }
}
