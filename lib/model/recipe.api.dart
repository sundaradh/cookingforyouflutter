import 'dart:convert';
import 'package:cookingforyou/model/recipe.dart';
import 'package:http/http.dart' as http;

class RecipeApi {
  static Future<List<Recipe>> getRecipe(String query) async {
    var response = await http.get(Uri.parse(
        "https://cookingforyou.pythonanywhere.com/cookingforu/recipe-list/?format=json"));
    var data = json.decode(utf8.decode(response.bodyBytes));

    return Recipe.recipesFromSnapshot(data, query);
  }
}
