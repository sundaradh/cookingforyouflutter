import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

var a;

class RecipeCard extends StatelessWidget {
  final String title;
  final String cookTime;
  final String thumbnailUrl;
  final String calories;
  final int index;
  final List recipe;

  const RecipeCard({
    required this.title,
    required this.cookTime,
    required this.thumbnailUrl,
    required this.calories,
    required this.index,
    required this.recipe,
  });
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        a = recipe[index];
        Navigator.push(
            context, MaterialPageRoute(builder: (_) => RecipeView()));
      },
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: 22, vertical: 10),
        width: MediaQuery.of(context).size.width,
        height: 180,
        decoration: BoxDecoration(
          color: Colors.black,
          borderRadius: BorderRadius.circular(15),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.6),
              offset: Offset(
                0.0,
                10.0,
              ),
              blurRadius: 10.0,
              spreadRadius: -6.0,
            ),
          ],
          image: DecorationImage(
            colorFilter: ColorFilter.mode(
              Colors.black.withOpacity(0.35),
              BlendMode.multiply,
            ),
            image: CachedNetworkImageProvider(
                "https://cookingforyou.pythonanywhere.com" + thumbnailUrl),
            fit: BoxFit.cover,
          ),
        ),
        child: Stack(
          children: [
            Align(
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 5.0),
                child: Text(
                  title,
                  style: TextStyle(
                    fontSize: 19,
                  ),
                  overflow: TextOverflow.ellipsis,
                  maxLines: 2,
                  textAlign: TextAlign.center,
                ),
              ),
              alignment: Alignment.center,
            ),
            Align(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    padding: EdgeInsets.all(5),
                    margin: EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      color: Colors.black.withOpacity(0.4),
                      borderRadius: BorderRadius.circular(15),
                    ),
                    child: Row(
                      children: [
                        Icon(
                          Icons.star,
                          color: Colors.yellow,
                          size: 18,
                        ),
                        SizedBox(width: 7),
                        Text("5"),
                      ],
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.all(5),
                    margin: EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      color: Colors.black.withOpacity(0.4),
                      borderRadius: BorderRadius.circular(15),
                    ),
                    child: Row(
                      children: [
                        Icon(
                          Icons.food_bank_sharp,
                          color: Colors.yellow,
                          size: 18,
                        ),
                        SizedBox(width: 7),
                        Text(calories),
                      ],
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.all(5),
                    margin: EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      color: Colors.black.withOpacity(0.4),
                      borderRadius: BorderRadius.circular(15),
                    ),
                    child: Row(
                      children: [
                        Icon(
                          Icons.schedule,
                          color: Colors.yellow,
                          size: 18,
                        ),
                        SizedBox(width: 7),
                        Text(cookTime),
                      ],
                    ),
                  )
                ],
              ),
              alignment: Alignment.bottomLeft,
            ),
          ],
        ),
      ),
    );
  }
}

class RecipeView extends StatefulWidget {
  const RecipeView({Key? key}) : super(key: key);

  @override
  _RecipeViewState createState() => _RecipeViewState();
}

String? videoId = YoutubePlayer.convertUrlToId(a.video);
YoutubePlayerController _controller = YoutubePlayerController(
  initialVideoId: '$videoId',
  flags: YoutubePlayerFlags(
    autoPlay: false,
    mute: false,
  ),
);

class _RecipeViewState extends State<RecipeView> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            a.name,
            style: TextStyle(fontFamily: 'Nepali'),
          ),
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                margin: EdgeInsets.symmetric(horizontal: 22, vertical: 10),
                width: MediaQuery.of(context).size.width,
                height: 180,
                decoration: BoxDecoration(
                  color: Colors.black,
                  borderRadius: BorderRadius.circular(15),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.6),
                      offset: Offset(
                        0.0,
                        10.0,
                      ),
                      blurRadius: 10.0,
                      spreadRadius: -6.0,
                    ),
                  ],
                  image: DecorationImage(
                    colorFilter: ColorFilter.mode(
                      Colors.black.withOpacity(0.05),
                      BlendMode.multiply,
                    ),
                    image: CachedNetworkImageProvider(
                        "https://cookingforyou.pythonanywhere.com" + a.image),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              Text(
                "Description\n" + a.description,
                style: TextStyle(color: Colors.black),
              ),
              Text(
                "Description\n" + a.description,
                style: TextStyle(color: Colors.black),
              ),
              Text(
                "\nIngrediants\n" + a.ingredients,
                style: TextStyle(color: Colors.black),
              ),
              Text(
                "\ninstructions\n" + a.instructions,
                style: TextStyle(color: Colors.black),
              ),
              Text(
                "\nCategory\n" + a.category,
                style: TextStyle(color: Colors.black),
              ),
              YoutubePlayer(
                controller: _controller,
                bottomActions: [
                  CurrentPosition(),
                  ProgressBar(isExpanded: true),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
