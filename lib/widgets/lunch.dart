import 'dart:async';

import 'package:cookingforyou/model/lunch.dart';
import 'package:cookingforyou/model/lunch.recipe.dart';
import 'package:cookingforyou/widgets/recipe_card.dart';
import 'package:flutter/material.dart';

class Lunch extends StatefulWidget {
  const Lunch({Key? key}) : super(key: key);

  @override
  State<Lunch> createState() => _LunchState();
}

class _LunchState extends State<Lunch> {
  late List<lRecipe> recipes = [];
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
    recipes = (await LApi.getRecipe(query)).cast<lRecipe>();
    setState(() {
      _isLoading = false;
      this.recipes = recipes;
    });
  }

  Future searchRecipe(String query) async => debounce(() async {
        final recipes = await LApi.getRecipe(query);

        if (!mounted) return;

        setState(() {
          this.query = query;
          this.recipes = recipes.cast<lRecipe>();
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
