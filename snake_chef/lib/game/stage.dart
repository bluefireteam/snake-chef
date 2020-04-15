enum Ingredient { TOMATO, LETTUCE }

class Stage {
  final List<Recipe> recipes;

  Stage({this.recipes});
}

class Recipe {
  final List<Ingredient> ingredients;

  Recipe({this.ingredients});

  bool checkCompletion(List<Ingredient> collectedIngredients) {
    return ingredients.every((ingredient) => collectedIngredients.contains(ingredient));
  }

  bool validIngredient(Ingredient ingredient) {
    return ingredients.contains(ingredient);
  }
}
