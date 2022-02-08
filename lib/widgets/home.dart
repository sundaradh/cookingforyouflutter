import 'dart:async';

import 'package:cookingforyou/model/recipe.api.dart';
import 'package:cookingforyou/model/recipe.dart';
import 'package:cookingforyou/widgets/recipe_card.dart';
import 'package:cookingforyou/widgets/search.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
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
    recipes = await RecipeApi.getRecipe(query);
    setState(() {
      _isLoading = false;
      this.recipes = recipes;
    });
  }

  Widget buildSearch() => SearchWidget(
        text: query,
        hintText: 'Recipe,Category,Cooking Time or Calories',
        onChanged: searchRecipe,
      );
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
    return Scaffold(
      appBar: AppBar(
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.restaurant_menu),
            SizedBox(width: 10),
            Text(
              'Cooking For You',
              style: TextStyle(fontFamily: "ConcertOne"),
            ),
          ],
        ),
        backgroundColor: Color(0xFFA23522),
      ),
      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : Column(
              children: [
                buildSearch(),
                Expanded(
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
      drawer: Drawer(
        child: ListView(
          children: <Widget>[
            // header
            Image.asset('assets/on.png'),
            // body

            Divider(),

            InkWell(
              onTap: () {},
              child: ListTile(
                title: Text("My account"),
                leading: Icon(
                  Icons.person,
                  color: Colors.red,
                ),
              ),
            ),
            Divider(),
            InkWell(
              onTap: () {},
              child: ListTile(
                title: Text("Categories"),
                leading: Icon(
                  Icons.dashboard,
                  color: Colors.orange,
                ),
              ),
            ),
            Divider(),

            InkWell(
              onTap: () {},
              child: ListTile(
                title: Text("Setting"),
                leading: Icon(
                  Icons.settings,
                  color: Colors.deepOrange,
                ),
              ),
            ),
            InkWell(
              onTap: () {},
              child: ListTile(
                title: Text("About us"),
                leading: Icon(
                  Icons.help,
                  color: Colors.pink,
                ),
              ),
            ),
            ListTile(
              title: Text('Rate', style: TextStyle(color: Colors.red[700])),
              leading: Icon(
                Icons.star,
                color: Colors.red[700],
              ),
              onTap: () {
                launch(
                    "https://play.google.com/store/apps/details?id=com.globaldestiny");
              },
            ),
            ListTile(
                title: Text('Share', style: TextStyle(color: Colors.red[700])),
                leading: Icon(
                  Icons.share,
                  color: Colors.red[700],
                ),
                onTap: () {}),
            InkWell(
              onTap: () async {},
              child: ListTile(
                title: Text("Logout"),
                leading: Icon(
                  Icons.logout,
                  color: Colors.deepOrange,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
