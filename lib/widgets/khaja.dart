import 'dart:async';

import 'package:cookingforyou/model/khaja.dart';
import 'package:cookingforyou/model/khaja.recipe.dart';
import 'package:cookingforyou/widgets/recipe_card.dart';
import 'package:flutter/material.dart';

class Khaja extends StatefulWidget {
  const Khaja({Key? key}) : super(key: key);

  @override
  State<Khaja> createState() => _KhajaState();
}

class _KhajaState extends State<Khaja> {
  late List<kRecipe> recipes = [];
  bool _isLoading = true;
  String query = '';
  Timer? debouncer;

  @override
  void initState() {
    super.initState();
    getRecipes();
  }

  @override
  void dispose() {
    debouncer?.cancel();
    super.dispose();
  }

  void debounce(
    VoidCallback callback, {
    Duration duration = const Duration(milliseconds: 1000),
  }) {
    if (debouncer != null) {
      debouncer!.cancel();
    }

    debouncer = Timer(duration, callback);
  }

  Future<void> getRecipes() async {
    recipes = (await KApi.getRecipe(query)).cast<kRecipe>();
    setState(() {
      _isLoading = false;
      this.recipes = recipes;
    });
  }

  Future searchRecipe(String query) async => debounce(() async {
        final recipes = await KApi.getRecipe(query);

        if (!mounted) return;

        setState(() {
          this.query = query;
          this.recipes = recipes.cast<kRecipe>();
        });
      });
  int currentindex = 0;

  @override
  Widget build(BuildContext context) {
    recipes = List.from(recipes.reversed);
    return Scaffold(
      appBar: AppBar(
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.restaurant_menu),
            SizedBox(width: 10),
            Text(
              'Cooking For You',
              // ignore: prefer_const_constructors
              style: TextStyle(fontFamily: "ConcertOne"),
            ),
          ],
        ),
        backgroundColor: const Color(0xFFA23522),
      ),
      body: Column(
        children: [
          _isLoading
              ? const Center(child: CircularProgressIndicator())
              : Expanded(
                  child: ListView.builder(
                    itemCount: recipes.length,
                    itemBuilder: (context, index) {
                      return RecipeCard(
                        index: index,
                        recipe: recipes,
                        title: recipes[index].name,
                        cookTime: recipes[index].totalTime,
                        thumbnailUrl: recipes[index].image,
                        calories: recipes[index].calories_food,
                      );
                    },
                  ),
                ),
        ],
      ),
    );
  }
}
