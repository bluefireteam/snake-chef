import 'package:flame/flame.dart';

import 'dart:convert';

class RecipeLoader {
  static Map<String, Map<String, dynamic>> recipes = {};

  static Future<void> load() async {
    await Future.wait([
      _loadFile("BANANA_SPLIT"),
      _loadFile("BURGER"),
      _loadFile("CARROT_CAKE"),
      _loadFile("CHOCOLATE_CAKE"),
      _loadFile("FRUIT_CAKE"),
      _loadFile("FRUIT_SALAD"),
      _loadFile("HOTDOG"),
      _loadFile("MUSHROOM_SOUP"),
      _loadFile("NIGUIRI"),
      _loadFile("ONION_SOUP"),
      _loadFile("PASTA"),
      _loadFile("PETIT_GATEAU"),
      _loadFile("PIZZA"),
      _loadFile("POKE"),
      _loadFile("RICE_BOWL"),
      _loadFile("SALAD"),
      _loadFile("SASHIMI"),
      _loadFile("SUSHI_CUCUMBER"),
      _loadFile("SUSHI_SALMON"),
      _loadFile("TACO_CHICKEN"),
      _loadFile("TACO_MUSHROOM"),
      _loadFile("TOMATO_SOUP"),
    ]);
  }

  static Future<void> _loadFile(String file) async {
    final raw = await Flame.assets.readFile("recipes/$file.json");
    final json = jsonDecode(raw);
    recipes[file] = json;
  }
}
