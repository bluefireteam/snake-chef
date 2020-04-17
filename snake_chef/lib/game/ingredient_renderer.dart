import 'package:snake_chef/game/stage.dart';
import 'package:snake_chef/game/assets.dart';
import 'dart:ui';

void renderIngredient(Canvas canvas, Ingredient ingredient, Rect rect) {
  if (ingredient == Ingredient.TOMATO) {
    Ingredients.getTomato().renderRect(canvas, rect);
  } else if (ingredient == Ingredient.LETTUCE) {
    Ingredients.getLettuce().renderRect(canvas, rect);
  } else if (ingredient == Ingredient.PASTA) {
    Ingredients.getPasta().renderRect(canvas, rect);
  } else if (ingredient == Ingredient.MEAT_BALLS) {
    Ingredients.getMeatBalls().renderRect(canvas, rect);
  } else if (ingredient == Ingredient.BREAD) {
    Ingredients.getBread().renderRect(canvas, rect);
  } else if (ingredient == Ingredient.CHEESE) {
    Ingredients.getCheese().renderRect(canvas, rect);
  } else if (ingredient == Ingredient.HAMBURGUER) {
    Ingredients.getHamburguer().renderRect(canvas, rect);
  }
}
