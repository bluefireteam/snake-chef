import 'package:flame/sprite.dart';
import 'package:snake_chef/game/stage.dart';
import 'package:snake_chef/game/assets.dart';
import 'dart:ui';

Sprite mapIngredientSprite(Ingredient ingredient) {
  switch (ingredient) {
    case Ingredient.TOMATO:
      return Ingredients.getTomato();
    case Ingredient.LETTUCE:
      return Ingredients.getLettuce();
    case Ingredient.PASTA:
      return Ingredients.getPasta();
    case Ingredient.MEAT_BALLS:
      return Ingredients.getMeatBalls();
    case Ingredient.BREAD:
      return Ingredients.getBread();
    case Ingredient.CHEESE:
      return Ingredients.getCheese();
    case Ingredient.HAMBURGUER:
      return Ingredients.getHamburguer();
    case Ingredient.ONION:
      return Ingredients.getOnion();
    case Ingredient.MUSHROOM:
      return Ingredients.getMushroom();
  }

  return null;
}

void renderIngredient(Canvas canvas, Ingredient ingredient, Rect rect) {
  mapIngredientSprite(ingredient)?.renderRect(canvas, rect);
}
