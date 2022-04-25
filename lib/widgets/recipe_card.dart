import 'package:cookingforyou/screens/login.dart';
import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

var a;

class RecipeCard extends StatelessWidget {
  final String title;
  final String cookTime;
  final String thumbnailUrl;
  final String calories;
  final int index;
  final List recipe;

  RecipeCard({
    required this.title,
    required this.cookTime,
    required this.thumbnailUrl,
    required this.calories,
    required this.index,
    required this.recipe,
  });
  late InterstitialAd _interstitialAd;
  bool _isAdLoaded = false;
  void _initAd() {
    InterstitialAd.load(
      adUnitId: InterstitialAd.testAdUnitId,
      request: AdRequest(),
      adLoadCallback: InterstitialAdLoadCallback(
        onAdLoaded: onAdLoaded,
        onAdFailedToLoad: (error) {},
      ),
    );
  }

  void onAdLoaded(InterstitialAd ad) {
    _interstitialAd = ad;
    _isAdLoaded = true;
    _interstitialAd.fullScreenContentCallback = FullScreenContentCallback(
      onAdDismissedFullScreenContent: (ad) {
        _interstitialAd.dispose();
        _isAdLoaded = false;
      },
      onAdFailedToShowFullScreenContent: (ad, error) {
        _interstitialAd.dispose();
        _isAdLoaded = false;
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    _initAd();
    return InkWell(
      onTap: () {
        a = recipe[index];
        Navigator.push(
            context, MaterialPageRoute(builder: (_) => RecipeView()));
        if (_isAdLoaded) {
          _interstitialAd.show();
        }
      },
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: 22, vertical: 10),
        width: MediaQuery.of(context).size.width,
        height: 200,
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
                    fontWeight: FontWeight.bold,
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
                          size: 20,
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
                          size: 20,
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
                          size: 20,
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

String? video;

class RecipeView extends StatefulWidget {
  const RecipeView({Key? key}) : super(key: key);

  @override
  _RecipeViewState createState() => _RecipeViewState();
}

class _RecipeViewState extends State<RecipeView> {
  late BannerAd _bannerAd;
  bool _isAdLoaded = false;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _initBannerAd();
  }

  @override
  void dispose() {
    _bannerAd.dispose();
    super.dispose();
  }

  _initBannerAd() {
    _bannerAd = BannerAd(
      size: AdSize.banner,
      adUnitId: BannerAd.testAdUnitId,
      listener: BannerAdListener(
        onAdLoaded: (ad) {
          _isAdLoaded = true;
        },
        onAdFailedToLoad: (ad, error) {},
      ),
      request: const AdRequest(),
    );
    _bannerAd.load();
  }

  @override
  Widget build(BuildContext context) {
    setState(() {
      video = YoutubePlayer.convertUrlToId(a.video);
      _isAdLoaded = true;
    });
    YoutubePlayerController _controller = YoutubePlayerController(
      initialVideoId: '$video',
      flags: const YoutubePlayerFlags(
        autoPlay: false,
        mute: false,
      ),
    );
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            a.name,
            style: TextStyle(fontFamily: "ConcertOne"),
          ),
          backgroundColor: Color(0xFFA23522),
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  margin: EdgeInsets.symmetric(horizontal: 22, vertical: 10),
                  width: MediaQuery.of(context).size.width,
                  height: 200,
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
                      fit: BoxFit.fill,
                    ),
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                const Text(
                  "परिचय",
                  style: TextStyle(
                      color: Color(0xFFA23522),
                      fontWeight: FontWeight.bold,
                      fontSize: 30),
                ),
                Text(
                  a.description,
                  style: TextStyle(
                    color: Color(0xFFA23522),
                    fontSize: 20,
                  ),
                ),
                Text(
                  "आवश्येक सामाग्री",
                  style: TextStyle(
                      color: Color(0xFFA23522),
                      fontWeight: FontWeight.bold,
                      fontSize: 30),
                ),
                Text(
                  a.ingredients,
                  style: TextStyle(
                    color: Color(0xFFA23522),
                    fontSize: 20,
                  ),
                ),
                Text(
                  "बनाउने विधि",
                  style: TextStyle(
                      color: Color(0xFFA23522),
                      fontWeight: FontWeight.bold,
                      fontSize: 30),
                ),
                Text(
                  a.instructions,
                  style: TextStyle(
                    color: Color(0xFFA23522),
                    fontSize: 20,
                  ),
                ),
                Text(
                  "पकाउने समय",
                  style: TextStyle(
                      color: Color(0xFFA23522),
                      fontWeight: FontWeight.bold,
                      fontSize: 30),
                ),
                Text(
                  a.totalTime,
                  style: TextStyle(
                    color: Color(0xFFA23522),
                    fontSize: 20,
                  ),
                ),
                Text(
                  "Calories Contain:" + a.calories_food,
                  style: TextStyle(
                      color: Color(0xFFA23522),
                      fontWeight: FontWeight.bold,
                      fontSize: 30),
                ),
                Text(
                  "Youtube Video",
                  style: TextStyle(
                      color: Color(0xFFA23522),
                      fontWeight: FontWeight.bold,
                      fontSize: 30),
                ),
                YoutubePlayer(
                  controller: _controller,
                  showVideoProgressIndicator: true,
                  bottomActions: [
                    CurrentPosition(),
                    ProgressBar(isExpanded: true),
                  ],
                ),
              ],
            ),
          ),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            Navigator.of(context).pushReplacement(
                MaterialPageRoute(builder: (context) => const Login()));
          },
          child: const Icon(Icons.star),
          backgroundColor: const Color(0xFFA23522),
        ),
        bottomNavigationBar: _isAdLoaded
            ? Container(
                height: _bannerAd.size.height.toDouble(),
                width: _bannerAd.size.width.toDouble(),
                child: AdWidget(
                  ad: _bannerAd,
                ),
              )
            : const SizedBox(),
      ),
    );
  }
}
