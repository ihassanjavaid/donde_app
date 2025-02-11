import 'package:auto_size_text/auto_size_text.dart';
import 'package:donde_app/services/ads.dart';
import 'package:firebase_admob/firebase_admob.dart';
import 'package:flutter/material.dart';
import 'package:donde_app/constants.dart';
import 'package:google_maps_webservice/places.dart';

class RestaurantDescription extends StatefulWidget {
  static const String id = 'restaurant_description_screen';
  final PlacesSearchResult place;

  RestaurantDescription({@required this.place});

  @override
  _RestaurantDescriptionState createState() => _RestaurantDescriptionState();
}

class _RestaurantDescriptionState extends State<RestaurantDescription> {
  InterstitialAd _interstitialAd;
  String photoRef;

  @override
  void initState() {
    super.initState();
    _interstitialAd = Ads().createInterstitialAd()..load()..show();
  }

  @override
  void dispose() {
    super.dispose();
    _interstitialAd.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (widget.place != null) {
      photoRef = widget.place.photos[0].photoReference;
      print(widget.place.photos[0].photoReference);
      /*String photoAddress =
          "https://maps.googleapis.com/maps/api/place/photo?maxwidth=960&photoreference=$photoRef&key=AIzaSyA-aRQiJZfCzNgsyHfoUYNE8rwBLcu7fio";
      print(photoAddress);*/
    }
    return Scaffold(
      appBar: AppBar(
        title: AutoSizeText(
          'Donde',
          overflow: TextOverflow.clip,
          maxLines: 1,
          style: kTitleTextStyle.copyWith(color: Colors.white),
        ),
        centerTitle: true,
        backgroundColor: Colors.redAccent,
      ),
      body: SafeArea(
        child: Column(
          children: <Widget>[
            // Title with icon
            Container(
              padding: EdgeInsets.all(20.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  Tab(
                    icon: Container(
                      child: Image(
                        image: AssetImage(
                          'images/logo.png',
                        ),
                        fit: BoxFit.cover,
                      ),
                      height: 45,
                      width: 45,
                    ),
                  ),
                  Text(
                    '  ',
                    style: TextStyle(
                      fontSize: 30,
                    ),
                  ),
                  Text(
                    widget.place != null ?this.widget.place.name: "Restaurant Name",
                    style: kTitleTextStyle,
                  ),
                ],
              ),
            ),

            // Restaurant card
            Flexible(
              child: GestureDetector(
                onTap: () {},
                child: Card(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10.0)),
                  borderOnForeground: true,
                  elevation: 18.0,
                  child: Column(
                    children: <Widget>[
                      Expanded(
                        flex: 3,
                        child: Container(
                          child: Image.network(
                            'https://maps.googleapis.com/maps/api/place/photo?maxwidth=400&photoreference=$photoRef&key=AIzaSyA-uiBKbMxCqyMR6JqbfB-VnDAHL8tFx6U',
                            width: double.maxFinite,
                            height: double.maxFinite,
                            fit: BoxFit.fill,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            /*Padding(
              padding: const EdgeInsets.all(18.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  InkWell(
                    onTap: () {}, // Dislike
                    child: Image(
                      image: AssetImage('images/crossicon.png'),
                      height: 40,
                      width: 40,
                    ),
                  ),
                  InkWell(
                    onTap: () {}, // Like
                    child: Image(
                      image: AssetImage('images/hearticon.png'),
                      height: 40,
                      width: 40,
                    ),
                  ),
                ],
              ),
            )*/
          ],
        ),
      ),
    );
  }
}
