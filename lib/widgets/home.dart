import 'dart:async';

import 'package:cookingforyou/screens/login.dart';
import 'package:cookingforyou/widgets/breakfast.dart';
import 'package:cookingforyou/widgets/categoriesviews.dart';
import 'package:cookingforyou/widgets/category.dart';
import 'package:cookingforyou/widgets/khaja.dart';
import 'package:cookingforyou/widgets/lunch.dart';

import 'package:flutter_custom_carousel_slider/flutter_custom_carousel_slider.dart';
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
  List<CarouselItem> itemList = [
    CarouselItem(
      image: const NetworkImage(
        'https://img.dtcn.com/image/themanual/pexels-melanie-dompierre-1707917-1-500x500.jpg',
      ),
      boxDecoration: BoxDecoration(
        gradient: LinearGradient(
          begin: FractionalOffset.bottomCenter,
          end: FractionalOffset.topCenter,
          colors: [
            Colors.blueAccent.withOpacity(1),
            Colors.black.withOpacity(.3),
          ],
          stops: const [0.0, 1.0],
        ),
      ),
      title:
          'Push your creativity to its limits by reimagining this classic puzzle!',
      titleTextStyle: const TextStyle(
        fontSize: 12,
        color: Colors.white,
      ),
      leftSubtitle: '\$51,046 in prizes',
      rightSubtitle: '4882 participants',
      rightSubtitleTextStyle: const TextStyle(
        fontSize: 12,
        color: Colors.black,
      ),
      onImageTap: (i) {},
    ),
    CarouselItem(
      image: const NetworkImage(
          'https://previews.123rf.com/images/golubovystock/golubovystock1703/golubovystock170300187/74823663-mezcla-de-carne-a-la-parrilla-y-salchichas-en-el-tablero-de-madera-surtido-de-deliciosa-comida-servi.jpg'),
      title: '@coskuncay published flutter_custom_carousel_slider!',
      titleTextStyle: const TextStyle(
        fontSize: 12,
        color: Colors.white,
      ),
      leftSubtitle: '11 Feb 2022',
      rightSubtitle: 'v1.0.0',
      onImageTap: (i) {},
    ),
  ];
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
        hintText: 'Recipe,Cooking Time or Calories',
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
  int currentindex = 0;

  @override
  Widget build(BuildContext context) {
    final screen = [home(context), category(context), Login()];
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
      body: screen[currentindex],
      drawer: Drawer(
        child: ListView(
          children: <Widget>[
            // header
            Image.asset('assets/on.png'),
            // body

            const Divider(),
            InkWell(
              onTap: () {
                Navigator.of(context).pushReplacement(
                    MaterialPageRoute(builder: (context) => Categorylist()));
              },
              child: const ListTile(
                title: Text("Categories"),
                leading: Icon(
                  Icons.dashboard,
                  color: Colors.orange,
                ),
              ),
            ),
            const Divider(),

            InkWell(
              onTap: () {},
              child: const ListTile(
                title: Text("Setting"),
                leading: Icon(
                  Icons.settings,
                  color: Colors.deepOrange,
                ),
              ),
            ),
            InkWell(
              onTap: () {},
              child: const ListTile(
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
              child: const ListTile(
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
      bottomNavigationBar: BottomNavigationBar(
        iconSize: 20.0,
        currentIndex: currentindex,
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
            backgroundColor: Color(0xFFA23522),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.category),
            label: 'Category',
            backgroundColor: Color(0xFFA23522),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.login),
            label: 'Log In',
            backgroundColor: Color(0xFFA23522),
          ),
        ],
        selectedItemColor: Colors.amber[800],
        onTap: (index) {
          setState(() {
            currentindex = index;
          });
        },
      ),
    );
  }

  Widget home(BuildContext context) {
    return Column(
      children: [
        buildSearch(),
        CustomCarouselSlider(
          items: itemList,
          height: 150,
          subHeight: 50,
          width: MediaQuery.of(context).size.width * .9,
          autoplay: true,
          showText: false,
          showSubBackground: false,
          indicatorShape: BoxShape.circle,
          selectedDotColor: Colors.red,
          unselectedDotColor: Colors.white,
        ),
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
    );
  }

  Widget category(BuildContext context) {
    return SingleChildScrollView(
      child: Center(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(18.0),
              child: Container(
                height: 170,
                width: MediaQuery.of(context).size.width / 2,
                child: InkWell(
                  onTap: () {
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => const Category()));
                  },
                  child: Card(
                    child: Column(
                      children: [
                        Image.asset("assets/dinner.jpg"),
                      ],
                    ),
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: Container(
                height: 170,
                width: MediaQuery.of(context).size.width / 2,
                child: InkWell(
                  onTap: () {
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => const Breakfast()));
                  },
                  child: Card(
                    child: Column(
                      children: [
                        Image.asset("assets/beakfast.png"),
                      ],
                    ),
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: Container(
                height: 170,
                width: MediaQuery.of(context).size.width / 2,
                child: InkWell(
                  onTap: () {
                    Navigator.of(context).push(
                        MaterialPageRoute(builder: (context) => const Lunch()));
                  },
                  child: Card(
                    child: Column(
                      children: [
                        Image.asset("assets/lunch.jpg"),
                      ],
                    ),
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(18.0),
              child: Container(
                height: 170,
                width: MediaQuery.of(context).size.width / 2,
                child: InkWell(
                  onTap: () {
                    Navigator.of(context).push(
                        MaterialPageRoute(builder: (context) => const Khaja()));
                  },
                  child: Card(
                    child: Column(
                      children: [
                        Image.asset("assets/khaja.jpg"),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _showMyDialog() async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('About us'),
          content: SingleChildScrollView(
            child: ListBody(
              children: const <Widget>[
                Text(
                    'we mainly focused on user health by controlling calories and tasty food recipe guidance or instruction with user requirement in user interface of our pp we will provide some categories of food that user can easily select their food according to their requirement. also, this project provide access to user can contribute their recipe on application and user can review the app or specific recipe. Amin can upload the recipe video by providing YouTube link and user can watch the recipe by clicking the link that redirect YouTube video.'),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: const Text('Ok'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }
}
