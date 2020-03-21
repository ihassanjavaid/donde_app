/*
* Dart file housing the landing page of the app
* */

import 'package:donde_app/locationBrain.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:google_maps_webservice/places.dart';
import '../constants.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';

// ignore: must_be_immutable
class Home extends StatefulWidget {
  static const String id = 'home_screen';

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  // Attributes
  bool showSpinner = false;
  PlacesSearchResult place;
  LocationBrain _locationBrain;
  List<PlacesSearchResult> places;

  // Methods

  @override
  initState() {
    super.initState();
    this.showSpinner = true;
    this._locationBrain = LocationBrain();
    _getPlaces();
    this.showSpinner = false;
  }

  void _getPlaces() async {
    this.places = await this._locationBrain.getNearbyPlaces();
  }

  @override
  Widget build(BuildContext context) {
    return ModalProgressHUD(
      inAsyncCall: showSpinner,
      child: Scaffold(
        body: SafeArea(
          child: Column(
            children: <Widget>[
              // Title with icon
              Container(
                padding: EdgeInsets.all(20.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
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
                      'Restaurants',
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
                            width: double.infinity,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10.0),
                              image: DecorationImage(
                                fit: BoxFit.fill,
                                image: NetworkImage(
                                    'https://wpcdn.us-east-1.vip.tn-cloud.net/www.abc6.com/content/uploads/2020/03/restaurants.jpg'),
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
                                    place != null
                                        ? place.name
                                        : 'Restaurant Name',
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
      ),
    );
  }
}
