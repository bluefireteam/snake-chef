import 'package:snake_chef/game/assets.dart';
import 'package:snake_chef/game/stage.dart';
import 'dart:ui';

void renderIngredient(Canvas canvas, Ingredient ingredient, Rect rect) {
  Ingredients.getSprite(ingredient)?.renderRect(canvas, rect);
}
