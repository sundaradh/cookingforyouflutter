import 'dart:convert';
import 'package:cookingforyou/model/recipe.dart';
import 'package:http/http.dart' as http;

class RecipeApi {
  static Future<List<Recipe>> getRecipe() async {
    var response = await http.get(Uri.parse(
        "https://cookingforyou.pythonanywhere.com/cookingforu/recipe-list/?format=json"));
    var data = jsonDecode(utf8.decode(response.bodyBytes));

    print(data);
    return Recipe.recipesFromSnapshot(data);
  }
}
