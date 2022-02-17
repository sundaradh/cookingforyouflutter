import 'dart:async';

import 'package:cookingforyou/model/recipe.api.dart';
import 'package:cookingforyou/model/recipe.dart';
import 'package:flutter/material.dart';

class Categories extends StatefulWidget {
  const Categories({Key? key}) : super(key: key);

  @override
  _CategoriesState createState() => _CategoriesState();
}

class _CategoriesState extends State<Categories> {
  late List<Recipe> recipes = [];
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
    setState(() {
      _isLoading = false;
      this.recipes = recipes;
    });
  }

  Future searchRecipe(String query) async => debounce(() async {
        final recipes = await RecipeApi.getRecipe(query);

        if (!mounted) return;

        setState(() {
          this.query = query;
          this.recipes = recipes;
        });
      });
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: GridView.builder(
        scrollDirection: Axis.vertical,
        physics: NeverScrollableScrollPhysics(),
        shrinkWrap: true,
        gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
            maxCrossAxisExtent: 280,
            crossAxisSpacing: 0.7,
            mainAxisSpacing: 10),
        itemCount: recipes.length,
        itemBuilder: (BuildContext context, int index) {
          return Text(recipes[index].category);
        },
      ),
    );
  }
}
