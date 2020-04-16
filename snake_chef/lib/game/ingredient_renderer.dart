import 'package:snake_chef/game/stage.dart';
import 'package:snake_chef/game/assets.dart';
import 'dart:ui';

void renderIngredient(Canvas canvas, Ingredient ingredient, Rect rect) {
  if (ingredient == Ingredient.TOMATO) {
    Ingredients.getTomato().renderRect(canvas, rect);
  } else if (ingredient == Ingredient.LETTUCE) {
    Ingredients.getLettuce().renderRect(canvas, rect);
  }
}
