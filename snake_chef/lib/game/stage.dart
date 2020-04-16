import 'package:flame/position.dart';

enum Ingredient { TOMATO, LETTUCE }

class Stage {
  final List<Recipe> recipes;
  final List<Position> obstacles;

  int initialX;
  int initialY;

  Stage({
    this.recipes,
    this.obstacles,
    this.initialX,
    this.initialY,
  });

  List<Ingredient> stageIngredients() {
    List<Ingredient> _ingredients = [];

    recipes.forEach((recipe) {
      recipe.ingredients.forEach((ingredient) {
        if (!_ingredients.contains(ingredient)) {
          _ingredients.add(ingredient);
        }
      });
    });

    return _ingredients;
  }
}

class Recipe {
  final List<Ingredient> ingredients;

  Recipe({this.ingredients});
  Recipe.salad() : this(ingredients: [Ingredient.TOMATO, Ingredient.LETTUCE]);

  bool checkCompletion(List<Ingredient> collectedIngredients) {
    return ingredients.every((ingredient) => collectedIngredients.contains(ingredient));
  }

  bool validIngredient(Ingredient ingredient) {
    return ingredients.contains(ingredient);
  }
}
