import 'package:auto_size_text/auto_size_text.dart';
import 'package:donde_app/utilities/constants.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_webservice/places.dart';

class RestaurantDescriptionScreen extends StatefulWidget {
  RestaurantDescriptionScreen({this.place});

  static const String id = 'restaurant_description_screen';
  final PlacesSearchResult place;

  @override
  _RestaurantDescriptionScreenState createState() =>
      _RestaurantDescriptionScreenState();
}

class _RestaurantDescriptionScreenState
    extends State<RestaurantDescriptionScreen> {
  String photoRef;

  @override
  Widget build(BuildContext context) {
    if (widget.place != null) {
      photoRef = widget.place.photos[0].photoReference;
      print(widget.place.photos[0].photoReference);
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
            Flexible(
              flex: 1,
              child: Container(
                padding: EdgeInsets.all(20.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>[
                    Expanded(
                      flex: 1,
                      child: Tab(
                        icon: Container(
                          margin: EdgeInsets.symmetric(horizontal: 10.0),
                          child: Image(
                            image: AssetImage(
                              'images/logo.png',
                            ),
                            fit: BoxFit.cover,
                          ),
//                        height: 45,
//                        width: 45,
                        ),
                      ),
                    ),
//                  Expanded(
//                    flex: 1,
//                    child: SizedBox(
//                      width: 10.0,
//                    ),
//                  ),
                    Expanded(
                      flex: 5,
                      child: AutoSizeText(
                        widget.place != null
                            ? this.widget.place.name
                            : "Restaurant Name",
                        style: kTitleTextStyle,
                        maxLines: 1,
                        overflow: TextOverflow.clip,
                      ),
                    ),
                  ],
                ),
              ),
            ),

            // Restaurant card
            Flexible(
              flex: 2,
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
          ],
        ),
      ),
    );
  }
}
