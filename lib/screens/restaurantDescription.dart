import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:donde_app/constants.dart';
import 'package:google_maps_webservice/places.dart';

class RestaurantDescription extends StatelessWidget {
  static const String id = 'restaurant_description_screen';
  final PlacesSearchResult place;

  RestaurantDescription({@required this.place});

  @override
  Widget build(BuildContext context) {
    String photoRef = place.photos[0].photoReference;
    String photoAddress =
        "https://maps.googleapis.com/maps/api/place/photo?maxwidth=960&photoreference=$photoRef&key=AIzaSyA-aRQiJZfCzNgsyHfoUYNE8rwBLcu7fio";
    print(photoAddress);
    return Scaffold(
      appBar: AppBar(
        title: AutoSizeText(
          this.place.name,
          overflow: TextOverflow.clip,
          maxLines: 1,
          style: kTitleTextStyle,
        ),
        centerTitle: true,
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
                    place.name,
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
                        flex: 1,
                        child: Container(
                          width: double.infinity,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10.0),
                            image: DecorationImage(
                              fit: BoxFit.fill,
                              image: NetworkImage(photoAddress),
                            ),
                          ),
                        ),
                      ),
                      Expanded(
                        flex: 1,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: <Widget>[
                            Expanded(
                              flex: 3,
                              child: Padding(
                                padding: const EdgeInsets.only(left: 8.0),
                                child: AutoSizeText(
                                  place != null ? place.name : null,
                                  style: kCardTitleTextStyle,
                                  maxLines: 2,
                                  overflow: TextOverflow.clip,
                                ),
                              ),
                            ),
                            Expanded(
                              flex: 1,
                              child: Text(
                                '0.0 KMs',
                                style: kNormalTextStyle,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(18.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  InkWell(
                    onTap: () {}, // Dislike
                    child: Image(
                      image: AssetImage('images/crossicon.png'),
                      height: 36,
                      width: 36,
                    ),
                  ),
                  InkWell(
                    onTap: () {}, // Dislike
                    child: Image(
                      image: AssetImage('images/refreshicon.png'),
                      height: 30,
                      width: 30,
                    ),
                  ),
                  InkWell(
                    onTap: () {}, // Like
                    child: Image(
                      image: AssetImage('images/hearticon.png'),
                      height: 36,
                      width: 36,
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
