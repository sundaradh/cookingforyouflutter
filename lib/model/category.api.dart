import 'dart:convert';

import 'package:cookingforyou/model/category.recipe.dart';
import 'package:http/http.dart' as http;

class CategoryApi {
  static Future<List<cRecipe>> getRecipe(String query) async {
    var response = await http.get(Uri.parse(
        "https://cookingforyou.pythonanywhere.com/cookingforu/category/4/?format=json"));
    var data = json.decode(utf8.decode(response.bodyBytes));

    return cRecipe.recipesFromSnapshot(data, query);
  }
}
