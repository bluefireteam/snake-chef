import 'package:flame/sprite.dart';
import 'package:snake_chef/game/stage.dart';
import 'package:snake_chef/game/assets.dart';
import 'dart:ui';

Sprite mapIngredientSprite(Ingredient ingredient) {
  if (ingredient == Ingredient.TOMATO) {
    return Ingredients.getTomato();
  } else if (ingredient == Ingredient.LETTUCE) {
    return Ingredients.getLettuce();
  } else if (ingredient == Ingredient.PASTA) {
    return Ingredients.getPasta();
  } else if (ingredient == Ingredient.MEAT_BALLS) {
    return Ingredients.getMeatBalls();
  } else if (ingredient == Ingredient.BREAD) {
    return Ingredients.getBread();
  } else if (ingredient == Ingredient.CHEESE) {
    return Ingredients.getCheese();
  } else if (ingredient == Ingredient.HAMBURGUER) {
    return Ingredients.getHamburguer();
  }

  return null;
}

void renderIngredient(Canvas canvas, Ingredient ingredient, Rect rect) {
  mapIngredientSprite(ingredient)?.renderRect(canvas, rect);
}
