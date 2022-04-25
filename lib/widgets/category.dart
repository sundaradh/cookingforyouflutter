import 'package:cookingforyou/widgets/breakfast.dart';
import 'package:cookingforyou/widgets/categoriesviews.dart';
import 'package:cookingforyou/widgets/khaja.dart';
import 'package:cookingforyou/widgets/lunch.dart';
import 'package:flutter/material.dart';

class Categorylist extends StatefulWidget {
  const Categorylist({Key? key}) : super(key: key);

  @override
  State<Categorylist> createState() => _CategorylistState();
}

class _CategorylistState extends State<Categorylist> {
  @override
  Widget build(BuildContext context) {
    var number = 0;
    return Scaffold(
      appBar: AppBar(
        title: const Text("Category"),
        backgroundColor: const Color(0xFFA23522),
      ),
      body: SingleChildScrollView(
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
                      number = 4;
                      Navigator.of(context).pushReplacement(MaterialPageRoute(
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
                      number = 4;
                      Navigator.of(context).pushReplacement(MaterialPageRoute(
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
                      number = 4;
                      Navigator.of(context).pushReplacement(MaterialPageRoute(
                          builder: (context) => const Lunch()));
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
                      number = 4;
                      Navigator.of(context).pushReplacement(MaterialPageRoute(
                          builder: (context) => const Khaja()));
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
      ),
    );
  }
}
