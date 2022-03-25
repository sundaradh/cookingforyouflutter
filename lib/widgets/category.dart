import 'package:cookingforyou/widgets/categoriesviews.dart';
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
    return SingleChildScrollView(
      child: Container(
        child: Center(
          child: Column(
            children: [
              InkWell(
                onTap: () {
                  number = 4;
                  Navigator.of(context).pushReplacement(MaterialPageRoute(
                      builder: (context) => const Category()));
                },
                child: Card(
                  child: Column(
                    children: [Image.asset("assets/on.png"), Text("Dinner")],
                  ),
                ),
              ),
              InkWell(
                onTap: () {
                  number = 4;
                },
                child: Card(
                  child: Column(
                    children: [Image.asset("assets/on.png"), Text("Dinner")],
                  ),
                ),
              ),
              InkWell(
                onTap: () {
                  number = 4;
                },
                child: Card(
                  child: Column(
                    children: [Image.asset("assets/on.png"), Text("Dinner")],
                  ),
                ),
              ),
              InkWell(
                onTap: () {
                  number = 4;
                },
                child: Card(
                  child: Column(
                    children: [Image.asset("assets/on.png"), Text("Dinner")],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
