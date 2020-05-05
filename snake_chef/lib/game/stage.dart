import 'package:flame/position.dart';

enum Ingredient { TOMATO, LETTUCE, PASTA, MEAT_BALLS, BREAD, CHEESE, HAMBURGUER, ONION, MUSHROOM }

class Stage {
  final int stageNumber;
  final List<Recipe> recipes;
  final List<Position> obstacles;

  int time;
  int initialX;
  int initialY;

  Stage({this.recipes, this.obstacles, this.initialX, this.initialY, this.time, this.stageNumber});

  factory Stage.fromJson(Map<String, dynamic> json) => Stage(
      time: json["time"],
      recipes: json["recipes"].map((recipe) => Recipe.fromJson(recipe)).toList().cast<Recipe>(),
      obstacles: json["obstacles"].map((obstacle) => Position(obstacle["x"].toDouble(), obstacle["y"].toDouble())).toList().cast<Position>(),
      initialX: json["initialX"],
      initialY: json["initialY"],
      stageNumber: json["stageNumber"]);

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

enum RecipeName {
  SALAD,
  PASTA,
  BURGER,
  ONION_SOUP,
  MUSHROOM_SOUP,
  TOMATO_SOUP,
}

class Recipe {
  final List<Ingredient> ingredients;
  RecipeName recipe;

  Recipe({this.ingredients, this.recipe});

  factory Recipe.fromJson(Map<String, dynamic> json) {
    final ingredients = json["ingredients"].map((ingredient) => Ingredient.values.firstWhere((e) => e.toString() == 'Ingredient.$ingredient'));

    final recipe = RecipeName.values.firstWhere((e) => e.toString() == 'RecipeName.${json['recipe']}');

    return Recipe(ingredients: ingredients.toList().cast<Ingredient>(), recipe: recipe);
  }

  bool checkCompletion(List<Ingredient> collectedIngredients) {
    return ingredients.every((ingredient) => collectedIngredients.contains(ingredient));
  }

  bool validIngredient(Ingredient ingredient) {
    return ingredients.contains(ingredient);
  }

  bool validRecipe(Ingredient ingredient, List<Ingredient> collectedIngredients) {
    final ingredientsCount = ingredients.where((element) => element == ingredient).length;
    final collectedIngredientsCount = collectedIngredients.where((element) => element == ingredient).length;

    return (collectedIngredientsCount + 1) <= ingredientsCount;
  }
}
