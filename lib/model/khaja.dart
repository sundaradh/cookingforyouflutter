import 'dart:convert';

import 'package:cookingforyou/model/khaja.recipe.dart';
import 'package:http/http.dart' as http;

class KApi {
  static Future<List<kRecipe>> getRecipe(String query) async {
    var response = await http.get(Uri.parse(
        "https://cookingforyou.pythonanywhere.com/cookingforu/category/5/?format=json"));
    var data = json.decode(utf8.decode(response.bodyBytes));

    return kRecipe.recipesFromSnapshot(data, query);
  }
}
