import 'dart:convert';

import 'package:cookingforyou/model/breakfast.dart';
import 'package:http/http.dart' as http;

class BApi {
  static Future<List<bRecipe>> getRecipe(String query) async {
    var response = await http.get(Uri.parse(
        "https://cookingforyou.pythonanywhere.com/cookingforu/category/1/?format=json"));
    var data = json.decode(utf8.decode(response.bodyBytes));

    return bRecipe.recipesFromSnapshot(data, query);
  }
}
