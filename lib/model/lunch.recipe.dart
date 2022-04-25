import 'dart:convert';

import 'package:cookingforyou/model/category.recipe.dart';
import 'package:cookingforyou/model/lunch.dart';
import 'package:http/http.dart' as http;

class LApi {
  static Future<List<lRecipe>> getRecipe(String query) async {
    var response = await http.get(Uri.parse(
        "https://cookingforyou.pythonanywhere.com/cookingforu/category/3/?format=json"));
    var data = json.decode(utf8.decode(response.bodyBytes));

    return lRecipe.recipesFromSnapshot(data, query);
  }
}
